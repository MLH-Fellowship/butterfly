import graphene
from .types import EventType, EventInput, UserType, UserInput
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

class DeleteEvent(graphene.Mutation):
    class Arguments:
        id = graphene.ID()
    
    event = graphene.Field(EventType)
    def mutate(self, parent):
        return Event.objects.delete(id)

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

# type Event:
#     id: ID!
#     name: String!
#     tag: String!
#     organizer: User!
#     location: String!
#     description: String!

# type User:
#     id: ID!
#     username: String!
#     password: String!