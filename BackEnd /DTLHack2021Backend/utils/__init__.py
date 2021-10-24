

class KEYS:
	APPLICATION_JSON = 'application/json'
	ERROR_MSG = "error_msg"
	GEO_ZONES = "geo_zones"
	GEOZONES_DB = "GEOZONES"
	LATITUDE = "latitude"
	LONGITUDE = "longitude"
	LOCATION = "location"
	MAX_LAT = "maxLat"
	MAX_LONG = "maxLong"
	MAX_LOCATION = "maxLocation"
	MIN_LAT = "minLat"
	MIN_LONG = "minLong"
	MIN_LOCATION = "minLocation"
	PREDICTION = "prediction"
	RESPONSE = "response"
	REQUEST = "request"
	SPORT_POINTS = "sport_points"
	SPORTPOINTS_DB = "SPORTPOINTS"
	STATUS = "status"


def get_square_points(coordinates_dict):
	coordinates_dict = {key: float(val) for key, val in coordinates_dict.items()}
	min_latitude = coordinates_dict.get("minLat")
	min_longitude = coordinates_dict.get("minLong")
	max_latitude = coordinates_dict.get("maxLat")
	max_longitude = coordinates_dict.get("maxLong")

	upper_left_point = (max_latitude, max_longitude)
	lower_right_point = (min_latitude, min_longitude)

	square_center_point = (
		(upper_left_point[0] + lower_right_point[0]) / 2,
		(upper_left_point[1] + lower_right_point[1]) / 2
	)
	vector_point = (
		upper_left_point[0] - square_center_point[0],
		upper_left_point[1] - square_center_point[1]
	)
	upper_right_point = (
		square_center_point[0] - vector_point[1],
		square_center_point[1] + vector_point[0]
	)
	lower_left_point = (
		square_center_point[0] + vector_point[1],
		square_center_point[1] - vector_point[0]
	)
	return upper_left_point, upper_right_point, lower_right_point, lower_left_point
