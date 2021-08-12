from graphene_django import DjangoObjectType, DjangoListField
from users.models import Event, User
import graphene

class EventType(DjangoObjectType):
    class Meta:
        model = Event
        fields = ("id", "name", "date", "startTime", "endTime", "tag", "user", "location", "description")
        # To be implemented
        # fields = ("id", "name", "date", "tag", "user", "location", "description", "attendees")



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
    # To be implemented
    # attendees = graphene.String(required=True, name="User")

class UserType(DjangoObjectType):
    class Meta:
        model = User
        fields = ("id", "name", "username", "password")

    events = DjangoListField(EventType)

    def resolve_events(self, info):
        return Event.objects.filter(user=self.id)
    # To be implemented
    # attendees = DjangoListField(UserType)
    # events = DjangoListField(EventType)

    # def resolve_events(self, info):
    #     return Event.objects.filter(user=self.id)

    # To be implemented
    # def resolve_attendees(self, info):
    #     return Event

class UserInput(graphene.InputObjectType):
    id = graphene.ID()
    name = graphene.String(required=True)
    username = graphene.String(required=True)
    password = graphene.String(required=True)