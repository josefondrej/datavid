import logging
import os
from dataclasses import dataclass
from typing import Optional

from flask import current_app as app

from common.Utils import get_or_set

logger = logging.getLogger(__name__)


@dataclass
class Config:
    redis_url: str
    redis_port: int
    redis_username: Optional[str]
    redis_password: Optional[str]

    postgres_user: str
    postgres_password: str
    postgres_db: str
    postgres_url: str


def get_config() -> Config:
    """
    Obtains configuration from the application context.
    """
    return get_or_set('config', build_configuration)


def build_configuration() -> Config:
    """
    Builds configuration from environment or from the Flask properties
    """
    logger.debug('Building configuration.')
    config = Config(redis_url=get_prop('REDIS_URL'),
                    redis_port=int(get_prop('REDIS_PORT')),
                    redis_username=get_prop('REDIS_USERNAME', True),
                    redis_password=get_prop('REDIS_PASSWORD', True),
                    postgres_user=get_prop('POSTGRES_USER', True),
                    postgres_password=get_prop('POSTGRES_PASSWORD', True),
                    postgres_db=get_prop('POSTGRES_DB', True),
                    postgres_url=get_prop('POSTGRES_URL', True))
    logger.debug(f'Used configuration: {config}')
    return config


def get_prop(name: str, optional: bool = False) -> str:
    """
    Gets property from environment or from the flask env.
    """
    config = os.environ.get(name, app.config.get(name))
    if not optional and not config:
        logger.error(f'It was not possible to retrieve configuration for property "{name}"!')
        raise EnvironmentError(f'No existing configuration for "{name}" found!')
    return config
