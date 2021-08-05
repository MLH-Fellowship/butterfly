from django.db import models

class User(models.Model):
    """
    The User model class the basic user object. This acts as the only user object since this project does not implement authentication.
    Each User object has three fields:
    name - stores the name of the user
    email - stores the user's email
    password - stores the user's password without authentication
    """
    name = models.CharField(max_length=100)
    email = models.CharField(max_length=100, unique=True)
    password = models.CharField(max_length=100)

    def __str__(self):
        return self.name

class Event(models.Model):
    """
    The Event class defines the event object. This object stores two relations to User: "user" and "attendees". 
    Each Event object has nine fields:
    name
    date
    startTime
    endTime
    tag - will be used to implement filtering at a later time
    user - stores a ForeignKey relation to a User, who acts as the owner
    location
    description
    attendees - stores a ManyToMany relation with multiple Users, more than one User can attend an event
    """
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
