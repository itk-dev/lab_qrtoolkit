# QR TOOLKIT

https://github.com/lab9k/qrtoolkit-core
Tested with Django 3.0.11
Adapted for Docker deployment

## Using docker compose to run the project.

1. Start
```sh
docker compose up --detach --build
```

2. Create static files for HTML "/var/www/qrtoolkit/static" (the path is defined in base.py and Dockerfile).
```sh
docker compose exec --user snake qrtoolkit python manage.py collectstatic
```

3. Run migrations
```sh
docker compose exec --user snake qrtoolkit python manage.py migrate
```

4. Create superuser for Django admin interface
```sh
docker compose exec --user snake qrtoolkit python manage.py createsuperuser
```

5. Done. Open your browser and access the admin interface
[https://qr.itkdev.dk/admin/](https://qr.itkdigital.etek.dk/admin/)

## Support / Service

See API logs in docker container:
```sh
docker exec qrtoolkit tail -f qr_django.log 
```

See Gunicorn logs:
```sh
docker logs -f qrtoolkit
```

### How to assign API access token to user (manually)

Before using the API, a token must be generated.

Inside Docker, open Django shell and run the following:
```sh
docker compose exec qrtoolkit bash
# now running bash inside container
python manage.py shell
# now running python shell
```

```python
from rest_framework.authtoken.models import Token
from django.contrib.auth import get_user_model
user = get_user_model().objects.first() # select the user you want to assign a token to
token = Token.objects.create(user=user)
print(token)
# >>> 7cc521475b91cbe88d9420a4cd43d14b1fed76f5

# To get the token after creation:
token = Token.objects.get_or_create(user=user)
print(token)
# >>> 7cc521475b91cbe88d9420a4cd43d14b1fed76f5
```

### API request example

Use a token to GET on api
```bash
curl -X GET http://localhost:8090/api/qrcodes/ -H 'Authorization: Token 7cc521475b91cbe88d9420a4cd43d14b1fed76f5'
```

# Development

## Install

Anaconda/venv, python version 3.10 is working.

pip install -r requirements.txt 

## Django configuration

Check that base.py setup is adapted to your development environment.

# Testing

For testing django in your local development environment, start the server:
`python manage.py runserver` or 

```
$ nohup python manage.py runserver &
$ jobs -l
```

Open localhost:<port>/admin

## Testing in Docker

For Django to allow localhost to connect (and avoid HTTP 400 Bad Request), override ALLOWED_HOSTS in Dockerfile:
```bash
docker run -it -d -p 8090:8090 -e ALLOWED_HOSTS=localhost --name qrtoolkit qrtoolkit 
```
