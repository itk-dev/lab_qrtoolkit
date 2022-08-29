from base import *
# production setup
ENVIRONMENT = "prod"
# Database
# https://docs.djangoproject.com/en/4.0/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': 'production_databse',
        }
}
