from django.db import models

class User(models.Model):
    name = models.CharField(max_length=100)
    username = models.CharField(max_length=100)
    password = models.CharField(max_length=100)

    def __str__(self):
        return self.name

class Event(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=100)
    date = models.DateTimeField()
    startTime = models.TimeField(default="14:30:59")
    endTime = models.TimeField(default="14:30:59")
    tag = models.CharField(max_length=100)
    user = models.ForeignKey(User, on_delete=models.CASCADE, default="test")
    location = models.CharField(max_length=100)
    description = models.CharField(max_length=100, default="Event")
    # To be implemented 
    # attendees = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return self.name