import logging

import redis

from redis import Redis
from sqlalchemy import create_engine

from common.Config import Config, get_config
from common.Utils import get_or_set

logger = logging.getLogger(__name__)


def get_redis() -> Redis:
    """
    Opens a new database connection if there is none yet for the
    current application context.
    """
    config = get_config()
    return get_or_set('db', lambda: connect_redis(config))


def connect_redis(config: Config) -> Redis:
    logger.debug(f'Connecting to the DB.')
    return redis.Redis(
        host=config.redis_url,
        port=config.redis_port,
        username=config.redis_username,
        password=config.redis_password,
        charset="utf-8",
        decode_responses=True)


def get_postgres():
    config = get_config()
    engine = create_engine('postgresql+psycopg2://user:password@hostname/database_name')


def connect_postgres(config: Config):
    engine = create_engine('postgresql+psycopg2://user:password@hostname/database_name')