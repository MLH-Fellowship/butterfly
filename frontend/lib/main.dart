// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:frontend/models/account.dart';
import 'package:frontend/screens/eventgoingpg.dart';
import 'package:frontend/screens/landingpg.dart';
import 'package:frontend/screens/signup.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'graphql_conf.dart';
import 'query_mutation.dart';

// screens
import 'screens/browse_events.dart';
import 'package:flutter_config/flutter_config.dart';
import 'screens/registerform.dart';
import 'package:frontend/screens/eventform.dart';
import '../widgets/exp_datetime.dart';
import 'package:flutter/services.dart';
import 'package:frontend/screens/login.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(GraphQLProvider(
    client: GraphQLConfiguration.client,
    child: const CacheProvider(child: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  get account => null; //for SignUp

  @override
  Widget build(BuildContext context) {
    //print(FlutterConfig.get('BuildableIdentifier'));
    return MaterialApp(
        title: 'Login Demo Asap',
        theme: ThemeData(primarySwatch: Colors.red),
        debugShowCheckedModeBanner: false,
 
        routes: <String, WidgetBuilder>{
          '/': (context) => LandingPg(),
          '/login': (context) => LoginPage(title: 'Butterfly'),
          '/signup': (context) => SignUp(account: this.account, isAdd: false),
          '/eventform': (context) => EventForm(account: this.account, isAdd: false),
          '/eventgoingpg': (context) => EventGoingPg(),
          '/registerform': (context) => RegisterForm(),

        });
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// Control whether user is logging in or registering
enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  //GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  QueryMutation addMutation = QueryMutation();

  final TextEditingController _emailFilter = TextEditingController();
  final TextEditingController _passwordFilter = TextEditingController();
  String _email = "";
  String _password = "";
  FormType _form = FormType.login;

  var account; // our default setting is to login, and we should switch to creating an account when the user chooses to

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  // Swap in between our two forms, registering and logging in
  void _formChange() async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildBar(context),
      appBar: AppBar(
        title: const Text('Butterfly'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return AppBar(
      title: const Text("Simple Login ASAP"),
      centerTitle: true,
    );
  }

  Widget _buildTextFields() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: TextField(
              controller: _emailFilter,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ),
          Container(
            child: TextField(
              controller: _passwordFilter,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return Container(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              child: const Text('Login'),
              onPressed: _loginPressed,
            ),
            TextButton(
              child: const Text('Dont have an account? Tap here to register.'),
              onPressed: _formChange,
            ),
            TextButton(
              child: const Text('Forgot Password?'),
              onPressed: _passwordReset,
            ),
            // @ToDo Remove eventpg textbutton after linked routing
            TextButton(
              child: const Text('Register an Account'),
              onPressed: () {
                Route route =
                    MaterialPageRoute(builder: (context) => RegisterForm());
                Navigator.push(context, route);
              },
            ),
            TextButton(
              child: const Text('GoTo EventPg'),
              onPressed: () {
                Route route =
                    MaterialPageRoute(builder: (context) => EventGoingPg());
                Navigator.push(context, route);
              },
            ),
            TextButton(
              child: const Text('Sign Up'),
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (context) =>
                        SignUp(account: this.account, isAdd: false));
                Navigator.push(context, route);
              },
            ),
            TextButton(
              child: const Text('Create an Event'),
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (context) =>
                        EventForm(account: this.account, isAdd: false));
                Navigator.push(context, route);
              },
            ),
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            // ElevatedButton(
            //   child: const Text('Create an Account'),
            //   onPressed: _createAccountPressed(),
            // ),
            TextButton(
              child: const Text('Have an account? Click here to log in.'),
              onPressed: _formChange,
            )
          ],
        ),
      );
    }
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password

  void _loginPressed() {
    // ignore: avoid_print
    print('The user wants to login with $_email and $_password');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BrowseEvents()));
  }

  void _createAccountPressed(id, firstName, lastName, email, password) async {
    // ignore: avoid_print
    print('The user wants to create an account with $_email and $_password');

    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.mutate(
      MutationOptions(
        // documentNode: addMutation.register('$_email', '', '$_password'),
        // ignore: deprecated_member_use
        documentNode: gql(
            addMutation.addAccount(id, firstName, lastName, email, password)),
      ),
    );
    if (result.data["success"] != null) {
      print('The user was created successfully!');
    } else {
      print('There was an error!');
      print(result.data["register"]["errors"]["email"][0]["message"]);
    }
  }

  void _passwordReset() {
    // ignore: avoid_print
    print("The user wants a password reset request sent to $_email");
  }
}
