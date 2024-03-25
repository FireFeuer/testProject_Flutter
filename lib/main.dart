import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'viewAllCompanyPage.dart';
import 'model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

final loginController = TextEditingController();
final passwordController = TextEditingController();

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Введите логин',
            ),
            controller: _loginController,
          ),
          SizedBox(height: 10),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Введите пароль',
            ),
            controller: _passwordController,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final response = await http.post(
                  Uri.parse('http://127.0.0.1:8000/api/token/'),
                  body: {
                    'username': _loginController.text,
                    'password': _passwordController.text,
                  },
                );

                if (response.statusCode == 200) {
                  final jsonResponse = json.decode(response.body);
                  GlobalVariables.accessToken = jsonResponse['access'];

                  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompanyList()),
              );
                }
              }
            },
            child: Text('Войти'),
          ),
        ],
      ),
    );
  }
}