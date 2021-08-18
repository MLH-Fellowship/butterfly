FROM python:3.8-slim-buster

RUN mkdir /butterfly_webpage
COPY requirements.txt /butterfly_webpage
WORKDIR /butterfly_webpage
RUN pip3 install -r requirements.txt

COPY . /butterfly_webpage

CMD ["gunicorn", "wsgi:app", "-w 1", "-b 0.0.0.0:80"]