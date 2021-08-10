class QueryMutation {
  String addAccount(String id, String firstName, String lastName, String email,
      String password) {
    return """ 
      mutation {
        addAccount(
          id: "$id",
          firstName: "$firstName",
          lastName: "$lastName",
          email: "$email",
          password: "$password",
        ){
          id
          firstName
          lastName
          email
          password
        }
      }
    """;
  }

  String getAll() {
    return """
    {
      accounts{
        id
        firstName
        lastName
        email
        password
      }
    }
    """;
  }

  String deleteAccount(id) {
    return """
      mutation{
        deleteAccount(id:"$id"){
          id
        }
      }
      """;
  }

  String editAccount(
      String id, String firstName, String lastName, String email) {
    return """
      mutation{
        editAccount(id: "$id", firstName: "$firstName", lastName: "$lastName", email: "$email"){
          email
          }
      }
    """;
  }
  
}
