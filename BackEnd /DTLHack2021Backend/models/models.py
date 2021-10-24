from typing import Dict, List

from geojson import Point, Polygon, Feature
from turfpy.measurement import boolean_point_in_polygon

from utils import get_square_points, KEYS
from utils.excel_parser.excel_parser import generate_db_data


class SportPointsModel:

    def __init__(self, db):
        self.db = db
        self.collection = self.db[KEYS.SPORTPOINTS_DB]

    async def create_sport_points(self) -> None:
        documents_count = await self.collection.count_documents({"rating": "Окружное"}, limit = 1)
        if documents_count == 0:

            print("inserting data to the database")

            sport_points = generate_db_data()

            for sport_point in sport_points:
                self.collection.insert_one(sport_point)

        print("data initialized")

    async def get_sport_points_inside_area(self, coordinates_dict: Dict) -> List:
        upper_left_point, upper_right_point, \
        lower_right_point, lower_left_point = get_square_points(coordinates_dict)

        polygon = Polygon(
            (
                [
                    [
                        upper_left_point,
                        upper_right_point,
                        lower_right_point,
                        lower_left_point
                    ]
                ]
            )
        )

        result = []
        cursor = self.collection.find()
        for document in await cursor.to_list(length=43000):
            location = document.get(KEYS.LOCATION)
            latitude = location.get(KEYS.LATITUDE)
            longitude = location.get(KEYS.LONGITUDE)
            point = Feature(geometry=Point((latitude, longitude)))
            if boolean_point_in_polygon(point, polygon):
                result.append(document)
        return result

    async def update(self, data):
        print(data)
        result = self.collection.update_one({"name": data["name"]},
                                            {"$set": data})
        return result


class GeoZoneModel:

    def __init__(self, db):
        self.db = db
        self.collection = self.db[KEYS.GEOZONES_DB]

    async def create(self, geo_zone_data: Dict) -> Dict:
        geo_zones_data = geo_zone_data.get('geo_zones')
        if geo_zones_data:
            result = []
            for geo_zone_data in geo_zones_data:
                res = self.collection.insert_one(geo_zone_data)
                result.append(res)
        else:
            result = self.collection.insert_one(geo_zone_data)
        return result

    async def get(self) -> List:
        test_records_names = ["test1", "test2"]
        result = []
        cursor = self.collection.find()
        for document in await cursor.to_list(length=150):
            if document.get("name")  not in test_records_names:
                result.append(document)
        return result

    async def update(self, geo_zone_data: Dict) -> Dict:
        geo_zones_data = geo_zone_data.get('geo_zones')
        if geo_zones_data:
            result = []
            for geo_zone_data in geo_zones_data:
                res = self.collection.update_one({"name": geo_zone_data["name"]},
                                                {"$set": geo_zone_data})
                result.append(res)
        else:
            result = self.collection.update_one({"name": geo_zone_data["name"]},
                                                {"$set": geo_zone_data})
        return result
