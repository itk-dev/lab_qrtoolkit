#!/bin/bash
export DJANGO_SUPERUSER_PASSWORD=itisagooddaytodie
export DJANGO_SUPERUSER_USERNAME=smith
export DJANGO_SUPERUSER_EMAIL=john_smith@aarhus.dk

python manage.py migrate
python manage.py createsuperuser --noinput
