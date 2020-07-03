#!/bin/bash

function config_core() {
    sed -i 's/DEBUG.*/DEBUG = False/g' SA/backend/settings.py
    sed -i "104s/SA2/${DB_NAME}/g" SA/backend/settings.py 
    sed -i "105s/root/${DB_USER}/g" SA/backend/settings.py 
    sed -i "106s/123456/${DB_PASSWORD}/g" SA/backend/settings.py 
    sed -i "107s/192.168.10.10/${DB_HOST}/g" SA/backend/settings.py 
    sed -i "108s/3306/${DB_PORT}/g" SA/backend/settings.py 
    sed -i "s@CELERY_BROKER_URL.*@CELERY_BROKER_URL = 'redis://${REDIS_PASSWORD}\@${REDIS_HOST}:${REDIS_PORT}/1'@g" SA/backend/settings.py
    sed -i "s@redis://127.0.0.1:6379/3@redis://${REDIS_PASSWORD}\@${REDIS_HOST}:${REDIS_PORT}/3@g" SA/backend/settings.py
}

config_core
source /opt/py3/bin/activate
python SA/manage.py makemigrations
python SA/manage.py migrate
python SA/scripts/add_user.py
cd /opt/SA && daphne -b 0.0.0.0 -p 8000 --proxy-headers backend.asgi2:application
