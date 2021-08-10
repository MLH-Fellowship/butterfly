import 'dart:developer';

class Account {
  Account(this.id, this.firstName, this.lastName, this.email, this.password);

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  getId() => this.id;

  getFirstName() => this.firstName;

  getLastName() => this.lastName;

  getEmail() => this.email;

  getPassword() => this.password;
}
