# QR TOOLKIT

https://github.com/lab9k/qrtoolkit-core
tested med Django 3.0.11

# Install
Anaconda/venv
pip install django-qr-toolkit-core 

# Setup
Skal udføres første gang for at kunne bruge systemet
-udfyld konfigurationsfiler
-python manage.py migrate
-python manage.py createsuperuser

# First Deploy container
1. Build the docker image
```bash
docker build -t qrtoolkit .
```
2. Run the container
```bash
docker run -v -it -d -p 8090:8090 --name qrtoolkit qrtoolkit
```
3. (Optional 1 of 2) Create static files in container "/var/www/qrtoolkit/static".

```bash
docker exec qrtoolkit python manage.py collectstatic
```
4. (Optional 2 of 2) Copy static files from container to host webserver static files dir.
```bash
docker cp qrtoolkit:/var/www/qrtoolkit <path_to_static_files_dir>
```
5. Open your browser and access the admin interface
[https://qr.itkdigital.etek.dk/admin/](https://qr.itkdigital.etek.dk/admin/)


# Testing
`python manage.py runserver`
eller 
```
$ nohup python manage.py runserver &
$ jobs -l
```
Gå til localhost:xxxx/admin

# Testing in Docker
For Django to allow localhost to connect (and avoid HTTP 400 Bad Request), override ALLOWED_HOSTS in Dockerfile:
```bash
docker run -it -d -p 8090:8090 -e ALLOWED_HOSTS=localhost --name qrtoolkit qrtoolkit 
```

# Logs
See API logs in docker container, e.g.:
```bash
docker exec qrtoolkit tail -f mysite.log 
```

# How to assign API token to user (manually)
Before using the API, a token must be generated.
Inside Docker, open Django shell and run the following:
```bash
docker exec -it qrtoolkit bash
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

# API request example
Use a token to GET on api
```bash
curl -X GET http://localhost:8090/api/qrcodes/ -H 'Authorization: Token 7cc521475b91cbe88d9420a4cd43d14b1fed76f5'
```