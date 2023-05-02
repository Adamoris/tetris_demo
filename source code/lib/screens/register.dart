import 'package:flutter/material.dart';
import 'package:tetris_basic/size_config.dart';
import 'package:tetris_basic/services/services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(50),
      child: Center(
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
            const Text("TETRIS",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 240, 217, 181))),
            SizedBox(height: SizeConfig.blockSizeVertical! * 5),
            const RegisterForm(),
            SizedBox(height: SizeConfig.blockSizeVertical! * 5),
            SizedBox(
                width: SizeConfig.blockSizeHorizontal! * 95,
                height: 60,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor:
                            const Color.fromARGB(255, 236, 135, 115)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel',
                        style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 255, 255, 255))))),
          ]))),
    ));
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? username;
  String? password;
  String? confirm;

  final bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // email
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 74, 70, 72),
              hintText: "Email",
              hintStyle: const TextStyle(
                  fontSize: 22, color: Color.fromARGB(255, 32, 32, 32)),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                    style: BorderStyle.none, color: Color.fromARGB(0, 0, 0, 0)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty || !value.isValidEmail()) {
                return 'Please enter a valid email.';
              }
              return null;
            },
            onChanged: (value) => setState(() => email = value),
            style: const TextStyle(
                fontSize: 22, color: Color.fromARGB(255, 240, 217, 181)),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 3,
          ),
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 74, 70, 72),
              hintText: "Username",
              hintStyle: const TextStyle(
                  fontSize: 22, color: Color.fromARGB(255, 32, 32, 32)),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                    style: BorderStyle.none, color: Color.fromARGB(0, 0, 0, 0)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a username.';
              }
              return null;
            },
            onChanged: (value) => setState(() => username = value),
            style: const TextStyle(
                fontSize: 22, color: Color.fromARGB(255, 240, 217, 181)),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 3,
          ),
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 74, 70, 72),
              hintText: "Password",
              hintStyle: const TextStyle(
                  fontSize: 22, color: Color.fromARGB(255, 32, 32, 32)),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                    style: BorderStyle.none, color: Color.fromARGB(0, 0, 0, 0)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            obscureText: _obscureText,
            onChanged: (value) => setState(() => password = value),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a password.';
              } else if (value.length < 6) {
                return 'Password is too short!';
              }
              return null;
            },
            style: const TextStyle(
                fontSize: 22, color: Color.fromARGB(255, 240, 217, 181)),
          ),
          // password
          SizedBox(height: SizeConfig.blockSizeVertical! * 3),
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 74, 70, 72),
              hintText: "Confirm Password",
              hintStyle: const TextStyle(
                  fontSize: 22, color: Color.fromARGB(255, 32, 32, 32)),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                    style: BorderStyle.none, color: Color.fromARGB(0, 0, 0, 0)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            obscureText: _obscureText,
            onChanged: (value) => setState(() => confirm = value),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please re-type your password.';
              } else if (value != password) {
                return 'Passwords do not match!';
              }
              return null;
            },
            style: const TextStyle(
                fontSize: 22, color: Color.fromARGB(255, 240, 217, 181)),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical! * 3),
          SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 95,
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor:
                          const Color.fromARGB(255, 240, 217, 181)),
                  onPressed: (_formKey.currentState != null &&
                          _formKey.currentState!.validate())
                      ? () {
                          Auth()
                              .register(email, password, username)
                              .then((result) {
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil('/', (route) => false);
                          });
                        }
                      : null,
                  child: Text('Complete',
                      style: TextStyle(
                          fontSize: 30,
                          color: (_formKey.currentState != null &&
                                  _formKey.currentState!.validate())
                              ? const Color.fromARGB(255, 96, 59, 26)
                              : const Color.fromARGB(255, 74, 70, 72))))),
        ],
      ),
    );
  }
}
