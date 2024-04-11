FROM python:3.12.2

RUN mkdir /app
RUN apt-get install ca-certificates curl wget

WORKDIR /app

COPY requirements.txt ./
# RUN pip install wheel
# RUN pip install setuptools
RUN pip install -r requirements.txt

COPY ./ ./

EXPOSE 5003

CMD ["gunicorn","-b :5003","parking.wsgi:application"]

