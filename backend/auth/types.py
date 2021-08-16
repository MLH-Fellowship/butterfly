from graphene_django import DjangoObjectType, DjangoListField
from users.models import Event, User
import graphene

class EventType(DjangoObjectType):
    class Meta:
        model = Event
        fields = ("id", "name", "date", "startTime", "endTime", "tag", "user", "location", "description", "attendees")

class EventInput(graphene.InputObjectType):
    id = graphene.ID()
    name = graphene.String(required=True)
    date = graphene.DateTime(required=True)
    startTime = graphene.Time(required=True)
    endTime = graphene.Time(required=True)
    tag = graphene.String(required=True)
    user_id = graphene.String(required=True, name="user")
    location = graphene.String(required=True)
    description = graphene.String(required=True)
    attendees = graphene.List(graphene.String)

class UpdateEventInput(graphene.InputObjectType):
    id = graphene.ID(required=True)
    name = graphene.String(required=False)
    date = graphene.DateTime(required=False)
    startTime = graphene.Time(required=False)
    endTime = graphene.Time(required=False)
    tag = graphene.String(required=False)
    user_id = graphene.String(required=False, name="user")
    location = graphene.String(required=False)
    description = graphene.String(required=False)
    attendees = graphene.List(graphene.String, required=False)

class UserType(DjangoObjectType):
    class Meta:
        model = User
        fields = ("id", "name", "email", "password")

    # GraphQL field for events user is hosting
    events = DjangoListField(EventType)
    def resolve_events(self, info): 
        return Event.objects.filter(user=self.id)
    
    # GraphQL field for events user is attending
    attending_events = DjangoListField(EventType)
    def resolve_attending_events(self, info):
        return Event.objects.filter(attendees__id=self.id)

class UserInput(graphene.InputObjectType):
    id = graphene.ID()
    name = graphene.String(required=True)
    email = graphene.String(required=True)
    password = graphene.String(required=True)