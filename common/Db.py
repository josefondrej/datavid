import logging

import redis
from flask_sqlalchemy import SQLAlchemy
from redis import Redis

from common.Config import Config, get_config
from common.Utils import get_or_set

logger = logging.getLogger(__name__)

db = SQLAlchemy()


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