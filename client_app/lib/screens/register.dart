import 'package:client_app/protos/service.pb.dart';
import 'package:client_app/services/grpc_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerForm = GlobalKey<FormState>();
  final grpcService = GrpcService();
  late String name;
  late String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Register",
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 5.0,
              ),
            ),
            Form( 
              key: _registerForm,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        color: Colors.white12,
                        fontSize: 17.0,
                      ),
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    validator: (String? val) {
                      name = val!;
                      return (val.isEmpty) ? "Name is required" : null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: Colors.white12,
                        fontSize: 17.0,
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onChanged: (value) => email = value,
                    validator: (String? val) {
                      email = val!;
                      return (val.isEmpty) ? "Email address is required" : null;
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
                        if (_registerForm.currentState!.validate()) {
                          var body = User();
                          body.name = name;
                          body.emailAddress = email;
                          var result = await grpcService.createUser(body);
                          SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('secret_code', result.secretCode);
                              Navigator.pushNamed(context, '/home');
                        }
                      },
                      child: const Text(
                        "Register",
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
                  "Already have an account with us?",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 3.0),
                    child: Text(
                      "Login",
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
