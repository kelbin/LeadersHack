from typing import List, Dict, Optional
import os

import pandas as pd

NAME_INDEX = 0
ADDRESS_INDEX = 1
OWNER_INDEX = 2
RATING_INDEX = 3
SPORTS_INDEX = 4
LAT_INDEX = 5
LONG_INDEX = 6
SIZE_INDEX = 7


def generate_db_data() -> Optional[List[Dict]]:
	this_dir = os.path.dirname(os.path.abspath(__file__))
	excel_data = pd.read_excel(os.path.normpath(this_dir + "/data.xlsx"))
	data = pd.DataFrame(excel_data,
						columns=["Объект", "Адрес", "Ведомственная Организация", "Доступность",
								 "Вид спорта", "Широта (Latitude)", "Долгота (Longitude)", "Площадь спортзоны"])
	sport_points = []
	for row in data.values:
		if not None in row:
			list_with_already_added_sport_point = list(
				filter(lambda sport_point: sport_point["name"] == row[NAME_INDEX], sport_points)
			)
			if list_with_already_added_sport_point:
				already_added_sport_point_dict = list_with_already_added_sport_point[0]
				already_added_sport_point_index = sport_points.index(already_added_sport_point_dict)
				sports = already_added_sport_point_dict.get("sports")
				new_sport = row[SPORTS_INDEX]
				if new_sport not in sports:
					sports.append(new_sport)
				already_added_sport_point_dict["sports"] = sports

				sport_points[already_added_sport_point_index] = already_added_sport_point_dict
			else:
				sport_point = {
					"name": row[NAME_INDEX],
					"category": None,
					"size": row[SIZE_INDEX],
					"location": {
						"latitude": row[LAT_INDEX],
						"longitude": row[LONG_INDEX],
						"fullAdressString": row[ADDRESS_INDEX]
					},
					"owner": row[OWNER_INDEX],
					"phone": None,
					"sports": [
						row[SPORTS_INDEX]
					],
					"rating": row[RATING_INDEX]
				}
				sport_points.append(sport_point)
	return sport_points
