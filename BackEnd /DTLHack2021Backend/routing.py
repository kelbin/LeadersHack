from controllers import SportPointsController, DataGeneratorController, GeoZoneController, PredictionMLController


routings = [
    ("*", "data", "/get/sportpoints", SportPointsController),
    ("*", "generate_data", "/generateData", DataGeneratorController),
    ("*", "geo_zones", "/geoZones", GeoZoneController),
    ("*", "prediction", "/prediction", PredictionMLController)
]
