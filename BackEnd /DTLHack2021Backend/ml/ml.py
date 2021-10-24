import os

from catboost import CatBoostRegressor
import pandas as pd


this_dir = os.path.dirname(os.path.abspath(__file__))
model_path = os.path.normpath(this_dir + "/sport")
model = CatBoostRegressor()
model.load_model(model_path)


def predict(json_data):
	df = pd.DataFrame(json_data)
	result = model.predict(df)
	result = str(result.astype(float)[0])
	return result
