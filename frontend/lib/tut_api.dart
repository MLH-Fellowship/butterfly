import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    //deprecated: cache: InMemoryCache(),

    cache: GraphQLCache(store: InMemoryStore()),
    link: HttpLink(
        // uri:
        'http://127.0.0.1:8000/graphql'),
  ),
);

final String getEventsQuery = """
query {
  allEvents {
    id,
    name,
    date,
    tag, 
    organizer,
    location
  }
}
""";

final String createEventMutation = """
mutation addEvent(\$input: EventInput!) {
  addEvent(input: \$input) {
    event {
      name
      date
      tag
      organizer
      location
    }
  }
}
""";

// final String updateTaskMutation = """
// mutation UpdateTodo(\$id: ID!, \$completed: Boolean!) {
//   updateTodo(id: \$id, completed: \$completed) {
//     id
//   }
// }
// """;
