import 'package:flutter/material.dart';
import 'package:tetris_basic/services/services.dart';
import 'package:tetris_basic/size_config.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(50),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: SizeConfig.blockSizeVertical! * 10),
            const Text("TETRIS",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 240, 217, 181))),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 10,
            ),
            const LoginForm(),
            SizedBox(height: SizeConfig.blockSizeVertical! * 20),
            SizedBox(
                width: SizeConfig.blockSizeHorizontal! * 95,
                height: 60,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor:
                            const Color.fromARGB(255, 240, 217, 181)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/registerScreen');
                    },
                    child: const Text('Register',
                        style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 96, 59, 26))))),
          ],
        )),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  final bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 74, 70, 72),
              hintText: "Email",
              hintStyle: const TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 32, 32, 32),
                  fontStyle: FontStyle.italic),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                    style: BorderStyle.none, color: Color.fromARGB(0, 0, 0, 0)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (value) => setState(() => email = value),
            style: const TextStyle(
                fontSize: 22, color: Color.fromARGB(255, 240, 217, 181)),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: SizeConfig.blockSizeHorizontal! * 59,
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 74, 70, 72),
                    hintText: "Password",
                    hintStyle: const TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(255, 32, 32, 32),
                        fontStyle: FontStyle.italic),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          style: BorderStyle.none,
                          color: Color.fromARGB(0, 0, 0, 0)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: _obscureText,
                  onChanged: (value) => setState(() => password = value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  style: const TextStyle(
                      fontSize: 22, color: Color.fromARGB(255, 240, 217, 181)),
                ),
              ),
              SizedBox(width: SizeConfig.blockSizeHorizontal! * 2),
              SizedBox(
                  width: 60,
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor:
                              const Color.fromARGB(255, 74, 70, 72)),
                      onPressed: () {},
                      child: const Text('?',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 240, 217, 181))))),
            ],
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
                  onPressed: () {
                    Auth().login(email, password).then((result) {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/', (route) => false);
                    });
                  },
                  child: const Text('Login',
                      style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 96, 59, 26))))),
        ],
      ),
    );
  }
}
