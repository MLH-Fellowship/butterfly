import graphene
from .types import EventType, EventInput, UserType, UserInput, UpdateEventInput
from users.models import Event, User

# GraphQL mutation for adding an event from EventInput
class AddEvent(graphene.Mutation):
    """GraphQL mutation to create an Event object from EventInput

        Args:
            input (EventInput): All fields of EventInput are required.

        Returns:
            EventType: An Event object
    """
    class Arguments:
        input = EventInput(required=True)

    event = graphene.Field(EventType)

    def mutate(self, parent, input=None):
        if input is None:
            return AddEvent(event=None)
        _event = Event.objects.create(**input)
        return AddEvent(event=_event)

class DeleteEvent(graphene.Mutation):
    """GraphQL mutation to delete an existing Event object by ID

        Args:
            eventId (graphene.ID): ID of Event object

        Returns:
            Boolean: True/False value of whether the object was deleted
    """
    class Arguments:
        eventId = graphene.ID()

    deleted = graphene.Boolean()
    
    def mutate(self, info, eventId):
        if Event.objects.get(id=eventId):
            _event = Event.objects.get(id=eventId)
            _event.delete()
            return DeleteEvent(deleted=True)
        return DeleteEvent(deleted=False)

class AddAttendees(graphene.Mutation):
    """GraphQL mutation to add a User object to an existing Event object's attendees

    Args:
        eventId (graphene.ID): ID of Event object
        userId (graphene.ID): ID of User object

    Returns:
        [EventType]: An Event object
    """
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
    """GraphQL mutation to delete a User object from an existing Event object's attendees

    Args:
        eventId (graphene.ID): ID of Event object
        userId (graphene.ID): ID of User object

    Returns:
        EventType: An Event object
    """
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
    """GraphQL mutation to create an User object from UserInput

        Args:
            input (UserInput): All fields of UserInput are required.

        Returns:
            UserType: A User object
    """
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