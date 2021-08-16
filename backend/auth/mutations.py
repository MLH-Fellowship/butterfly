import graphene
from .types import EventType, EventInput, UserType, UserInput, UpdateEventInput
from users.models import Event, User

class AddEvent(graphene.Mutation):
    class Arguments:
        input = EventInput(required=True)

    event = graphene.Field(EventType)

    def mutate(self, parent, input=None):
        if input is None:
            return AddEvent(event=None)
        _event = Event.objects.create(**input)
        return AddEvent(event=_event)

class AddAttendees(graphene.Mutation):
    class Arguments:
        eventId = graphene.ID()
        userId = graphene.ID()

    event = graphene.Field(EventType)
    
    def mutate(self, info, eventId, userId):
        _event = Event.objects.get(id=eventId)
        _user = User.objects.get(id=userId)

        if not _event.attendees.filter(id=userId).exists():
            _event.attendees.add(_user)
            _event.save()
        return AddAttendees(event=_event)

class DeleteAttendees(graphene.Mutation):
    class Arguments:
        eventId = graphene.ID()
        userId = graphene.ID()

    event = graphene.Field(EventType)
    
    def mutate(self, info, eventId, userId):     
        _event = Event.objects.get(id=eventId)
        _user = User.objects.get(id=userId)

        if _event.attendees.filter(id=userId).exists():
            _event.attendees.remove(_user)
        return DeleteAttendees(event=_event)

class AddUser(graphene.Mutation):
    class Arguments:
        input = UserInput(required=True)

    user = graphene.Field(UserType)

    def mutate(self, parent, input=None):
        if input is None:
            return AddUser(user=None)
        _user = User.objects.create(**input)
        return AddUser(user=_user)

class Mutation(graphene.ObjectType):
    add_event = AddEvent.Field()
    add_user = AddUser.Field()
    add_attendees = AddAttendees.Field()
    delete_attendees = DeleteAttendees.Field()