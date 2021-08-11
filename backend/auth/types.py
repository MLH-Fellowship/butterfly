from graphene_django import DjangoObjectType
from users.models import Event
from users.models import User
import graphene

class EventType(DjangoObjectType):
    class Meta:
        model = Event
        fields = ("id", "name", "date", "tag", "organizer", "location", "description")
class UserType(DjangoObjectType):
    class Meta:
        model = User
        fields = ("name", "dateJoined", "birthday", "typeOfUser")

class EventInput(graphene.InputObjectType):
    id = graphene.ID()
    name = graphene.String(required=True)
    date = graphene.DateTime(required=True)
    tag = graphene.String(required=True)
    organizer = graphene.String(required=True)
    location = graphene.String(required=True)
    description = graphene.String(required=True)

class User(graphene.InputObjectType):
    name = graphene.String(required=True)
    dateJoined = graphene.DateTime(required = True)
    birthday = graphene.DateTime(required = True)
    typeOfUser = graphene.String(required = True)
