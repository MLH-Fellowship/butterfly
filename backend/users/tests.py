from django.test import TestCase
import json
from .models import User, Event

class UserTestCase(TestCase):
    def test_string_representation(self):
        """ 
        This test on the User model checks the string representation of User
        """
        user = User.objects.create(
            name="Test User", email="testuser@gmail.com", password="testpassword123")
            
        self.assertEqual(str(user), user.name)
        self.assertEqual("testuser@gmail.com", user.email)
        self.assertEqual("testpassword123", user.password)

# Test event model string representation, user to user relation, and attendee to user relation
class EventTestCase(TestCase):
    def test_string_representation(self):
        """ 
        This test on the Event model checks the string representation of Event. A "user" object is declared but not used as every Event requires one User relation. 
        """
        user = User.objects.create(
            name="Test User", email="testuser@gmail.com", password="testpassword123")
        event = Event.objects.create( 
            name="Test Event", date="2021-08-20", startTime="0:0:59", endTime="1:30:59", tag="Test tag", description="This is a test paragraph. This paragraph is longer than normal text", user=user)

        self.assertEqual(str(event), event.name)
        self.assertEqual("2021-08-20", event.date)
        self.assertEqual("0:0:59", event.startTime)
        self.assertEqual("1:30:59", event.endTime)
        self.assertEqual("Test tag", event.tag)
        self.assertEqual("This is a test paragraph. This paragraph is longer than normal text", event.description)

    def test_user_relation(self):
        """ 
        This test on the Event model checks the ForeignKey relation of User and Event.user.
        """
        user = User.objects.create(
            name="Test User", email="testuser@gmail.com", password="testpassword123")
        event = Event.objects.create(
            name="Test Event", date="2021-08-20", startTime="0:0:59", endTime="1:30:59", tag="Test tag", user=user)

        self.assertEquals(user.id, event.user.id)
        self.assertEqual(str(user), event.user.name)
        self.assertEqual("testuser@gmail.com", event.user.email)
        self.assertEqual("testpassword123", event.user.password)
    
    def test_attendee_relation(self):
        """ 
        This test on the Event model checks the ManyToMany relation of User and Event.attendees.
        """
        user1 = User.objects.create(
            name="Test User 1", email="testuser1@gmail.com", password="testpassword123")
        user2 = User.objects.create(
            name="Test User 2", email="testuser2@gmail.com", password="testpassword1234")
        user3 = User.objects.create(
            name="Test User 3", email="testuser3@gmail.com", password="testpassword12345")
        event = Event.objects.create(
            name="Test Event", date="2021-08-20", startTime="0:0:59", endTime="1:30:59", tag="Test tag", user=user1)
        
        event.attendees.add(user1)
        event.attendees.add(user2)
        event.attendees.add(user3)

        self.assertEqual(user1.id, event.attendees.get(id=user1.id).id)
        self.assertEqual(str(user1), event.attendees.get(id=user1.id).name)
        self.assertEqual("testuser1@gmail.com", event.attendees.get(id=user1.id).email)
        self.assertEqual("testpassword123", event.attendees.get(id=user1.id).password)

        self.assertEqual(user2.id, event.attendees.get(id=user2.id).id)
        self.assertEqual(str(user2), event.attendees.get(id=user2.id).name)
        self.assertEqual("testuser2@gmail.com", event.attendees.get(id=user2.id).email)
        self.assertEqual("testpassword1234", event.attendees.get(id=user2.id).password)

        self.assertEqual(user3.id, event.attendees.get(id=user3.id).id)
        self.assertEqual(str(user3), event.attendees.get(id=user3.id).name)
        self.assertEqual("testuser3@gmail.com", event.attendees.get(id=user3.id).email)
        self.assertEqual("testpassword12345", event.attendees.get(id=user3.id).password)