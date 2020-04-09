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
    return get_or_set('redis', lambda: connect_redis(config))


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
    return get_or_set('postgres', lambda: connect_postgres(config))


def connect_postgres(config: Config):
    return create_engine(f'postgresql+psycopg2://{config.postgres_user}:{config.postgres_password}@{config.postgres_url}/{config.postgres_db}')