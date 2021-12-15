import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:towghana/model/user.dart';
//import 'package:towghana/screens/forgotPassword.dart';
import 'package:towghana/screens/mainPage.dart';
import 'package:towghana/screens/registration.dart';

late User user;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool processing = false;

  //form key
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  //get User Data

  getUserData() {}

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please Enter your Email";
          }
          //reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return " Please Enter a valid E-mail";
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Enter Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

    //Password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return "Password required";
          }
          if (!regex.hasMatch(value)) {
            return "Enter a Valid Password (Min. 6 Characters)";
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Enter Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

    final loginButton = Material(
        elevation: 5,
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
            onPressed: () {
              signIn(emailController.text, passwordController.text);
            },
            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
            minWidth: MediaQuery.of(context).size.width,
            child: processing == false
                ? Text("Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))
                : CircularProgressIndicator(
                    backgroundColor: Colors.greenAccent,
                    semanticsLabel: 'Loading ..',
                  )));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: 200,
                          child: Image.asset(
                            'assets/images/logo.jpeg',
                            fit: BoxFit.contain,
                          )),
                      SizedBox(height: 45),
                      emailField,
                      SizedBox(height: 25),
                      passwordField,
                      SizedBox(height: 35),
                      loginButton,
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrationScreen()));
                            },
                            child: Text("Register Here",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //Forgot password field
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //      GestureDetector(
                      //       onTap: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => ForgotPassword()));
                      //       },
                      //       child: Text("Forgot Password ?",
                      //           style: TextStyle(
                      //               color: Colors.grey,
                      //               fontWeight: FontWeight.w600,
                      //               fontSize: 15)),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

//Login Function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        processing = true;
      });
      //  var url = Uri.parse('https://towghana.com/tg/api/user/login');
      var url = Uri.parse('https://towghana.com/tg/api/user/login');

      var data = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      var response = await http.post(url, body: data);
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        var userData = responseData['user'];

        User authUser = User.fromJson(userData);

        setState(() {
          processing = false;
          user = authUser;
        });

        print(user);
        Fluttertoast.showToast(
            msg: 'Login Successful', toastLength: Toast.LENGTH_SHORT);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MainPage()));
      } else {
        setState(() {
          processing = false;
        });

        Fluttertoast.showToast(
            msg: 'Login Failed!', toastLength: Toast.LENGTH_SHORT);
      }
    }
  }
}
