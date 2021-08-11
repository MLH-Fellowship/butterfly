import graphene
from .types import EventType
from .types import UserType
from users.models import Event
from users.models import User

class Query(graphene.ObjectType):
    all_events = graphene.List(EventType)
    all_users = graphene.List(UserType)
    #
    event = graphene.Field(EventType, eventId=graphene.String())
    user = graphene.Field(UserType, userID = graphene.String())
    # Resolver for feed field
    def resolve_all_events(self, parent):
        return Event.objects.all().order_by('date')
    def resolve_all_users(self,parent):
        return User.objects.all().order_by('name')

    # Resolver for post field
    def resolve_event(self, parent, eventId):
        return Event.objects.get(id=eventId) 
    def resolve_user(self,parent,userID):
        return User.objects.get(uid = userID)
