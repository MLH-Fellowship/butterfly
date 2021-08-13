import graphene
from .types import EventType, EventInput, UserType, UserInput
from users.models import Event, User

class AddEvent(graphene.Mutation):
    class Arguments:
        id = graphene.ID()
        name = graphene.String(required=True)
        date = graphene.DateTime(required=True)
        startTime = graphene.Time(required=True)
        endTime = graphene.Time(required=True)
        tag = graphene.String(required=False)
        user_id = graphene.String(required=True, name="user")
        location = graphene.String(required=True)
        description = graphene.String(required=True)
        attendee_id = graphene.List(graphene.String(required=False, name="attendee"))

    event = graphene.Field(EventType)

    def mutate(self, parent, input=None):
        if input is None:
            return AddEvent(event=None)
        _event = Event.objects.create(**input)
        return AddEvent(event=_event)

class AddUser(graphene.Mutation):
    class Arguments:
        input = UserInput(required=True)

    user = graphene.Field(UserType)

    def mutate(self, parent, input=None):
        if input is None:
            return AddUser(user=None)
        _user = User.objects.create(**input)
        return AddUser(user=_user)

# class AddAttendee(graphene.Mutation):
#     class Arguments:
#         input = AttendeeInput(required=True)

#     attendee = graphene.Field(AttendeeType)

#     def mutate(self, parent, input=None):
#         if input is None:
#             return AddAttendee(attendee=None)
#         _attendee = Attendee.objects.create(**input)
#         return AddAttendee(attendee=_attendee)

class Mutation(graphene.ObjectType):
    add_event = AddEvent.Field()
    add_user = AddUser.Field()
    # add_attendee = AddAttendee.Field()
