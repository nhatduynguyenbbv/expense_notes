import 'package:expense_notes/src/screens/sign_in.dart';
import 'package:expense_notes/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/sign-up';

  const SignUp({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? _emailErrorMsg;
  String? _passwordErrorMsg;
  String? _confirmPasswordErrorMsg;

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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

    final confirmPasswordField = TextFormField(
      style: const TextStyle(fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          errorText: _confirmPasswordErrorMsg),
      controller: confirmPasswordController,
      obscureText: true,
      validator: (value) => _validateConfirmPassword(value),
    );

    final signUpButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          minimumSize: Size(MediaQuery.of(context).size.width, 40)),
      onPressed: () async {
        if (isLoading) {
          return;
        }

        if (_formKey.currentState!.validate()) {
          setState(() {
            _emailErrorMsg = null;
            _passwordErrorMsg = null;
            isLoading = true;
          });
          var result = await await context
              .read<AuthService>()
              .registerNewAccount(
                  emailController.text, passwordController.text);

          setState(() {
            isLoading = false;
          });

          if (result == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Your account has been created.'),
              backgroundColor: Colors.green,
            ));
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
      child: !isLoading
          ? const Text(
              "Create New Account",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(color: Colors.white),
                SizedBox(width: 24),
                Text(
                  'Please wait...',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
    );

    final signIn = Row(
      children: <Widget>[
        const Text('Already have an account?'),
        TextButton(
          child: const Text(
            'Sign in.',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: SingleChildScrollView(
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
                  const SizedBox(height: 25.0),
                  emailField,
                  const SizedBox(height: 25.0),
                  passwordField,
                  const SizedBox(height: 25.0),
                  confirmPasswordField,
                  const SizedBox(
                    height: 35.0,
                  ),
                  signUpButton,
                  const SizedBox(
                    height: 15.0,
                  ),
                  signIn
                ],
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

  String? _validateConfirmPassword(String? value) {
    final required = _validateRequired(value);
    if (required != null) {
      return required;
    }

    if (confirmPasswordController.text != passwordController.text) {
      return 'Confirmation Password does not match';
    }

    return null;
  }
}
