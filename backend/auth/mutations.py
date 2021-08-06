import graphene
from .types import EventType, EventInput
from users.models import Event

class AddEvent(graphene.Mutation):
    class Arguments:
        input = EventInput(required=True)

    event = graphene.Field(EventType)

    def mutate(self, parent, input=None):
        if input is None:
            return AddEvent(event=None)
        _event = Event.objects.create(**input)
        return AddEvent(event=_event)

class Mutation(graphene.ObjectType):
    add_event = AddEvent.Field()