import os
import yaml


THIS_DIR = os.path.dirname(os.path.abspath(__file__))
CONFIG_PATH = os.path.normpath(THIS_DIR + "/../configs/configs.yaml")

with open(CONFIG_PATH) as file:
	configs = yaml.full_load(file)


class Settings:
	MONGO_HOST = configs["mongo_host"]
	MONGO_DBNAME = configs["mongo_dbname"]
