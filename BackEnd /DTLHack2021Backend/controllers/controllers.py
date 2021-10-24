import math

from aiohttp import web

from logger import log
from models import SportPointsModel, GeoZoneModel
from ml.ml import predict
from JSONEncoder import JSONEncoder
from utils import KEYS


class SportPointsController(web.View):

	def __init__(self, request: web.Request) -> None:
		super(SportPointsController, self).__init__(request)
		self.sport_points = SportPointsModel(db=self.request.db)

	async def get(self) -> web.Response:
		coordinates_dict = self.request.query
		log(self, type=KEYS.REQUEST, data=coordinates_dict, incoming=True)

		if len(coordinates_dict) != 4:
			error_message = {
				KEYS.STATUS: "error",
				KEYS.ERROR_MSG: "missing or extra coordinates",
			}
			return web.Response(content_type=KEYS.APPLICATION_JSON, text=JSONEncoder().encode(error_message))

		sport_points_inside_area = await self.sport_points.get_sport_points_inside_area(coordinates_dict)
		log(self,
			type="response info",
			data={
				"sport_points_objects": {
					"length": len(sport_points_inside_area),
					"example": sport_points_inside_area[0] if sport_points_inside_area else None
				}
			},
		)
		return web.Response(content_type=KEYS.APPLICATION_JSON,
							text=JSONEncoder().encode({KEYS.SPORT_POINTS: sport_points_inside_area}))

	async def patch(self):
		update_data = await self.request.json()
		response = await self.sport_points.update(update_data)
		log(self, type=KEYS.RESPONSE, data=response)
		return web.Response(content_type=KEYS.APPLICATION_JSON, text=JSONEncoder().encode({KEYS.STATUS: 200}))



class DataGeneratorController(web.View):
	'''
	needed to create database records and insert them into the database
	'''

	def __init__(self, request: web.Request) -> None:
		super(DataGeneratorController, self).__init__(request)
		self.sport_points = SportPointsModel(db=self.request.db)

	async def get(self):
		await self.sport_points.create_sport_points()
		return web.Response(content_type=KEYS.APPLICATION_JSON, text=JSONEncoder().encode({KEYS.STATUS: 200}))


class GeoZoneController(web.View):

	def __init__(self, request: web.Request) -> None:
		super(GeoZoneController, self).__init__(request)
		self.geo_zones = GeoZoneModel(db=self.request.db)
		self.sport_points = SportPointsModel(db=self.request.db)

	async def post(self):
		geo_zone_data = await self.request.json()
		log(self, type=KEYS.REQUEST, data=geo_zone_data, incoming=True)
		await self.geo_zones.create(geo_zone_data)
		return web.Response(content_type=KEYS.APPLICATION_JSON, text=JSONEncoder().encode({KEYS.STATUS: 200}))

	async def get(self):
		geo_zones = await self.geo_zones.get()
		for geo_zone in geo_zones:
			location = {
				KEYS.MIN_LAT: geo_zone[KEYS.MIN_LOCATION][KEYS.LATITUDE],
				KEYS.MIN_LONG: geo_zone[KEYS.MIN_LOCATION][KEYS.LONGITUDE],
				KEYS.MAX_LAT: geo_zone[KEYS.MAX_LOCATION][KEYS.LATITUDE],
				KEYS.MAX_LONG: geo_zone[KEYS.MAX_LOCATION][KEYS.LONGITUDE]
			}
			sport_points = await self.sport_points.get_sport_points_inside_area(location)
			sport_points_size = sum([val for sport_point in sport_points
									 for key, val in sport_point.items() if key == "size" and not math.isnan(val)])
			sports_list = [val for sport_point in sport_points
							 for key, val in sport_point.items() if key == "sports"]
			all_sports = [val for sublist in sports_list for val in sublist]
			all_sports = list(set(all_sports))
			geo_zone.update({"sport_points_count": len(sport_points)})
			geo_zone.update({"sport_points_size": sport_points_size})
			geo_zone.update({"sports_count": len(all_sports)})

		log(self, type=KEYS.RESPONSE, data=geo_zones, incoming=True)
		return web.Response(content_type=KEYS.APPLICATION_JSON, text=JSONEncoder().encode({KEYS.GEO_ZONES: geo_zones}))

	async def patch(self):
		geo_zone_data = await self.request.json()
		log(self, type=KEYS.REQUEST, data=geo_zone_data, incoming=True)
		response = await self.geo_zones.update(geo_zone_data)
		log(self, type=KEYS.RESPONSE, data=response)
		return web.Response(content_type=KEYS.APPLICATION_JSON, text=JSONEncoder().encode({KEYS.STATUS: 200}))


class PredictionMLController(web.View):

	async def get(self):
		prediction_data = await self.request.json()
		log(self, type=KEYS.REQUEST, data=prediction_data, incoming=True)
		response = predict(prediction_data)
		log(self, type=KEYS.RESPONSE, data=response)
		return web.Response(content_type=KEYS.APPLICATION_JSON,
							text=JSONEncoder().encode({KEYS.PREDICTION: response}))
