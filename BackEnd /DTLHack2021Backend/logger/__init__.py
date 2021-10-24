from typing import Dict
from datetime import datetime
import pytz


tz = pytz.timezone('Europe/Moscow')


def log(self, type: str = None, data: Dict = None, incoming: bool = False) -> None:
	if incoming:
		print(f"[{datetime.now(tz)}] METHOD: {self.request.method} || Controller: {self.__class__.__name__}; \n{type.capitalize()} data: \n{data}")
	else:
		print(f"{type.capitalize()} data: \n{data}")
