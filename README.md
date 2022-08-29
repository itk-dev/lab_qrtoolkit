# QR TOOLKIT

https://github.com/lab9k/qrtoolkit-core
tested med Django 3.0.11

# Install
Anaconda/venv
pip install django-qr-toolkit-core 

# Setup
Skal udføres første gang for at kunne bruge systemet
-udfyld konfigurationsfiler
-migrate
-createsuperuser

# First Deploy container
Build
`docker build -t qrtoolkit .`
Run
`docker run -it -d -p 8090:8090 --name qrtoolkit qrtoolkit`
Create static files in container "/var/www/qrtoolkit/static" (optional 1/2)
`docker exec qrtoolkit python manage.py collectstatic`
Copy static files from container to host webserver static files dir (optional (2/2))
`docker cp qrtoolkit:/var/www/qrtoolkit <path_to_static_files_dir>`


# Testing
`python manage.py runserver`
eller 
```
$ nohup python manage.py runserver &
$ jobs -l
```
Gå til localhost:xxxx/admin