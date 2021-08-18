# base image  
FROM python:3.8   
# setup environment variable  
# ENV DockerHOME=/home/app/webapp  

# set work directory  
RUN mkdir /butterfly_backend  

# copy requirements
COPY requirements.txt /butterfly_backend

# where your code lives  
WORKDIR /butterfly_backend

# set environment variables  
# ENV PYTHONDONTWRITEBYTECODE 1
# ENV PYTHONUNBUFFERED 1  

# install dependencies  
RUN pip install --upgrade pip  

# copy whole project to your docker home directory.  
COPY . /butterfly_backend

# run this command to install all dependencies  
RUN pip install -r requirements.txt  

# port where the Django app runs  
EXPOSE 8000  

# start server  
# CMD python manage.py runserver  
ENTRYPOINT ["sh", "entrypoint.sh"]