import graphene
from .types import EventType, EventInput, UserType, UserInput, UpdateEventInput
from users.models import Event, User

# GraphQL mutation for adding an event from EventInput
class AddEvent(graphene.Mutation):
    class Arguments:
        input = EventInput(required=True)

    event = graphene.Field(EventType)

    def mutate(self, parent, input=None):
        if input is None:
            return AddEvent(event=None)
        _event = Event.objects.create(**input)
        return AddEvent(event=_event)

# GraphQL mutation for deleting an event from eventID
class DeleteEvent(graphene.Mutation):
    class Arguments:
        eventId = graphene.ID()

    deleted = graphene.Boolean()
    
    def mutate(self, info, eventId):
        if Event.objects.get(id=eventId):
            _event = Event.objects.get(id=eventId)
            _event.delete()
            return DeleteEvent(deleted=True)
        return DeleteEvent(deleted=False)

# GraphQL mutation for adding attendees to an event given an eventID and userID
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

# GraphQL mutation for deleting attendees from an event given an eventID and userID
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

# GraphQL mutation for adding a User from UserInput
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
    delete_event = DeleteEvent.Field()