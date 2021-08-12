import 'package:flutter/material.dart';
import 'package:frontend/screens/screen_type.dart';

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
  else if(screen == ScreenType.Attending){
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