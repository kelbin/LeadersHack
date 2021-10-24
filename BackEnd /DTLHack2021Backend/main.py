from aiohttp import web
from aiohttp.web import middleware
from motor import motor_asyncio as ma

from routing import routings
from settings import Settings

MONGO_HOST = Settings.MONGO_HOST
MONGO_DBNAME = Settings.MONGO_DBNAME


@middleware
async def db_handler(request, handler):
    if request.path.startswith('/static/') or request.path.startswith('/_debugtoolbar'):
        response = await handler(request)
        return response
    request.db = app.db
    response = await handler(request)
    return response


if __name__ == "__main__":
    app = web.Application(middlewares=[db_handler])

    for route in routings:
        app.router.add_route(route[0], route[2], route[3], name=route[1])

    app.client = ma.AsyncIOMotorClient(MONGO_HOST)
    app.db = app.client[MONGO_DBNAME]

    web.run_app(app, port=8080)
