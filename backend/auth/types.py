from graphene_django import DjangoObjectType
from users.models import Event
import graphene

class EventType(DjangoObjectType):
    class Meta:
        model = Event
        fields = ("id", "name", "date", "time", "tag", "organizer", "location")

class EventInput(graphene.InputObjectType):
    id = graphene.ID()
    name = graphene.String(required=True)
    date = graphene.DateTime(required=True)
    tag = graphene.String(required=True)
    organizer = graphene.String(required=True)
    location = graphene.String(required=True)