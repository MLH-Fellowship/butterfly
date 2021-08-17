FROM python:3.8-slim-buster

RUN mkdir /butterfly
COPY requirements.txt /butterfly
WORKDIR /butterfly
RUN pip3 install -r requirements.txt

COPY . /butterfly

CMD ["gunicorn", "wsgi:app", "-w 1", "-b 0.0.0.0:80"]