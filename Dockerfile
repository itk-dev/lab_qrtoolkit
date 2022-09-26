FROM python:3.8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN useradd --create-home snake
RUN mkdir -p /var/www/qrtoolkit/static
RUN chown -R snake /var/www/qrtoolkit/*

RUN apt update  \
    && DEBIAN_FRONTEND=noninteractive apt -y upgrade \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install -r requirements.txt

WORKDIR /home/snake
USER snake
COPY src src
USER root
RUN chown snake:snake /home/snake/src/itk_qr/mydatabase
RUN chown snake:snake /home/snake/src/itk_qr/
USER snake

#necessary for gunicorn to find wsgi.py
WORKDIR src/itk_qr
CMD ["gunicorn", "project.wsgi:application", "--bind=0.0.0.0:8090"]
