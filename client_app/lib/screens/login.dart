import 'package:client_app/services/grpc_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final _loginForm = GlobalKey<FormState>();
    final grpcService = GrpcService();
    late String secretCode;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Login",
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 5.0,
              ),
            ),
            Form(
              key: _loginForm,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Secret Code',
                      hintStyle: TextStyle(
                        color: Colors.white12,
                        fontSize: 17.0,
                      ),
                      labelText: 'Secret Code',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    validator: (String? val) {
                      secretCode = val!;
                      return (val.isEmpty) ? "Secret code is required" : null;
                    },
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.amberAccent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 7.0),
                    child: FlatButton(
                      onPressed: () async {
                        if (_loginForm.currentState!.validate()) {
                          var result = await grpcService.loginUser(secretCode);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('secret_code', result.secretCode);
                          Navigator.pushNamed(context, '/home');
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 19.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 3.0),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
