import graphene
from .types import EventType, UserType
from users.models import Event, User

class Query(graphene.ObjectType):
    all_events = graphene.List(EventType)
    event = graphene.Field(EventType, eventId=graphene.String())
    all_users = graphene.List(UserType)
    user = graphene.Field(UserType, userId=graphene.String())

    # Resolver for allEvents query
    def resolve_all_events(self, parent):
        return Event.objects.all().order_by('date')

    # Resolver for eventById query
    def resolve_event(self, parent, eventId):
        return Event.objects.get(id=eventId)

    # Resolver for allUsers query
    def resolve_all_users(self, parent):
        return User.objects.all()
    
    # Resolver for userById query
    def resolve_user(self, info, userId):
        return User.objects.get(id=userId)