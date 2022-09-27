FROM python:3.8

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN addgroup --gid 1042 snake \
 && useradd --create-home --uid 1042 --gid 1042 snake \
 && mkdir -p /var/www/qrtoolkit/static \
 && chown -R snake /var/www/qrtoolkit/*

RUN apt update  \
    && DEBIAN_FRONTEND=noninteractive apt -y upgrade \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install -r requirements.txt

RUN chown -R snake:snake /home/snake

USER snake

#necessary for gunicorn to find wsgi.py
WORKDIR /home/snake/src/itk_qr

CMD ["gunicorn", "project.wsgi:application", "--bind=0.0.0.0:8090"]
