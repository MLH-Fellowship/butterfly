import graphene
from .types import EventType
from users.models import Event

class Query(graphene.ObjectType):
    all_events = graphene.List(EventType)
    event = graphene.Field(EventType, eventId=graphene.String())

    # Resolver for feed field
    def resolve_all_events(self, parent):
        return Event.objects.all().order_by('date')

    # Resolver for post field
    def resolve_event(self, parent, info, eventId):
        return Event.objects.get(id=eventId)