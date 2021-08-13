from graphene_django import DjangoObjectType, DjangoListField
from users.models import Event, User
import graphene

class EventType(DjangoObjectType):
    class Meta:
        model = Event
        fields = ("id", "name", "date", "startTime", "endTime", "tag", "user", "location", "description", "attendee")

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
    attendee_id = graphene.List(of_type=graphene.ID, required=True, name="attendee")

# class AttendeeType(DjangoObjectType):
#     class Meta:
#         model = Attendee
#         fields = ("id", "name", "email")

# class AttendeeInput(graphene.InputObjectType):
#     name = graphene.String(required=True)
#     email = graphene.String(required=True)

class UserType(DjangoObjectType):
    class Meta:
        model = User
        fields = ("id", "name", "email", "password")

    events = DjangoListField(EventType)
    attending_events = DjangoListField(EventType)

    def resolve_events(self, info):
        return Event.objects.filter(user=self.id)
    
    def resolve_attending_events(self, info):
        return self.attending_events.all()

class UserInput(graphene.InputObjectType):
    id = graphene.ID()
    name = graphene.String(required=True)
    email = graphene.String(required=True)
    password = graphene.String(required=True)