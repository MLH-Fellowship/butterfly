import graphene
from .types import EventType, UserType
from users.models import Event, User

class Query(graphene.ObjectType):
    all_events = graphene.List(EventType)
    event = graphene.Field(EventType, eventId=graphene.String())
    all_users = graphene.List(UserType)
    user = graphene.Field(UserType, userId=graphene.String())
    userByEmail = graphene.Field(UserType, email=graphene.String())

    def resolve_all_events(self, parent):
        """GraphQL query for all Event objects

        Args:
            None

        Returns:
            [Event]: QuerySet of Event objects
        """
        return Event.objects.all().order_by('date')

    def resolve_event(self, parent, eventId):
        """GraphQL query for Event object by ID

        Args:
            None

        Returns:
            Event: An Event object
        """
        return Event.objects.get(id=eventId)

    def resolve_all_users(self, parent):
        """GraphQL query for all User objects

        Args:
            None

        Returns:
            [User]: QuerySet of User objects
        """
        return User.objects.all()
    
    def resolve_user(self, info, userId):
        """GraphQL query for User object by ID

        Args:
            None

        Returns:
            User: A User object
        """
        return User.objects.get(id=userId)
    
    # Resolver for userByEmail query
    def resolve_userByEmail(self, info, email):
        """GraphQL query for User object by email. This query was intended for a custom means of authentication. 

        Args:
            None

        Returns:
            User: A User object
        """
        return User.objects.get(email=email)