from django.db import models

class User(models.Model):
    name = models.CharField(max_length=100)
    email = models.CharField(max_length=100, unique=True)
    password = models.CharField(max_length=100)

    def __str__(self):
        return self.name

class Event(models.Model):
    name = models.CharField(max_length=100)
    date = models.DateField()
    startTime = models.TimeField()
    endTime = models.TimeField()
    tag = models.CharField(max_length=100)
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="user")
    location = models.CharField(max_length=100)
    description = models.CharField(max_length=100, default="Event description")
    attendees = models.ManyToManyField(User, related_name="attending_users")
    
    def __str__(self):
        return self.name