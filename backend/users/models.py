from django.db import models

# Create your models here.

class Event(models.Model):
    name = models.CharField(max_length=100)
    date = models.DateTimeField()
    tag = models.CharField(max_length=100)
    organizer = models.CharField(max_length=100)
    location = models.CharField(max_length=100)
    description = models.CharField(max_length=100)

    def __str__(self):
        return self.name
class User(models.Model):
    name = models.CharField(max_length = 100)
    dateJoined = models.DateTimeField()
    birthday = models.DateTimeField()
    typeOfUser = models.CharField(max_length = 100)
    