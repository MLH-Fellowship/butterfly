class QueryMutation {
  String register(String email, String user, String password) {
    return """ 
      mutation {
        register(
          email: "$email",
          username: "$user",
          password1: "$password",
          password2: "$password",
        ) {
          success,
          errors,
          token,
          refreshToken
        }
      }
    """;
  }
}
