import 'package:expense_notes/src/screens/sign_up.dart';
import 'package:expense_notes/src/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class SignIn extends StatefulWidget {
  static const routeName = '/sign-in';

  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? _emailErrorMsg;
  String? _passwordErrorMsg;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      style: const TextStyle(fontSize: 20.0),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        errorText: _emailErrorMsg,
      ),
      controller: emailController,
      validator: (value) => _validateRequired(value),
    );

    final passwordField = TextFormField(
      style: const TextStyle(fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          errorText: _passwordErrorMsg),
      controller: passwordController,
      obscureText: true,
      validator: (value) => _validateRequired(value),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              _emailErrorMsg = null;
              _passwordErrorMsg = null;
            });
            var result = await AuthService()
                .signIn(emailController.text, passwordController.text);

            if (result == null) {
              Navigator.pushReplacementNamed(context, Home.routeName);
            } else {
              if (result['message'] != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(result['message'].toString()),
                  backgroundColor: Colors.red,
                ));
              } else {
                setState(() {
                  _emailErrorMsg = result['email'];
                  _passwordErrorMsg = result['password'];
                });
              }
            }
          }
        },
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final register = Row(
      children: <Widget>[
        const Text('No account?'),
        TextButton(
          child: const Text(
            'Create One!',
          ),
          onPressed: () {
            Navigator.pushNamed(context, SignUp.routeName);
          },
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 155.0,
                      child: Image.asset(
                        "assets/images/logo.jpg",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 45.0),
                    emailField,
                    const SizedBox(height: 25.0),
                    passwordField,
                    const SizedBox(
                      height: 35.0,
                    ),
                    loginButton,
                    const SizedBox(
                      height: 15.0,
                    ),
                    register
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validateRequired(String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }
}
