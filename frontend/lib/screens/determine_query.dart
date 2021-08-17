import 'package:flutter/material.dart';
import 'package:frontend/screens/screen_type.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

String determineQuery(ScreenType screen){
  if(screen == ScreenType.Browse){
    return """
        query getAllEvents {
          allEvents {
            id
            name
            date
            startTime
            endTime  
            tag
            location
            description
          }
        }
      """;
  }
  else if(screen == ScreenType.Hosting){
    return """
        query getHostedEvents{
          user(userId:"1") {
            events {
              id
              name
              date
              startTime
              endTime
              tag
              location
              description
            }
          }
        }
      """;
  }
  else if(screen == ScreenType.Attending){
    return """
        query getAttendingEvents{
          user(userId:"1") {
            attendingEvents {
              id
              name
              date
              startTime
              endTime
              tag
              location
              description
            }
          }
        }
      """;
  }
  else return """
        query getAllEvents {
          allEvents {
            id
            name
            date
            startTime
            endTime  
            tag
            location
            description
          }
        }
      """;
}

List extractData(QueryResult result, ScreenType screen){
  if(screen == ScreenType.Browse){
    print(result.data["allEvents"].runtimeType);
    return result.data["allEvents"];
  }
  else if(screen == ScreenType.Hosting){
    return result.data["user"]["events"];
  }
  else if(screen == ScreenType.Attending){
    return  result.data["user"]["attendingEvents"];
  }
  else return  result.data["allEvents"];
}