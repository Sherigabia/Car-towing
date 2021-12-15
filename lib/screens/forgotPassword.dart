import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:towghana/model/user.dart';
import 'package:towghana/screens/login.dart';

late User user;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool processing = false;

  //form key
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            hintText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

    final loginButton = Material(
        elevation: 5,
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
            onPressed: () {
              forgotPassword(emailController.text);
            },
            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
            minWidth: MediaQuery.of(context).size.width,
            child: processing == false
                ? Text("Reset Password",
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
      appBar: AppBar(
        title: Text("Forgot Password?"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 36.0, right: 36),
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
                        Text(
                          "Enter Email to Recover Password",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 25),
                        emailField,
                        SizedBox(height: 25),
                        loginButton,
                        SizedBox(height: 15),
                      ]),
                ),
              )),
        ),
      ),
    );
  }

//Login Function
  void forgotPassword(String email) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        processing = true;
      });

      var url = Uri.parse('https://towghana.com/tg/api/user/forgotPassword');

      var data = {
        "email": emailController.text,
      };
      print(data);
      var response = await http.post(url, body: data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          processing = false;
        });
        Fluttertoast.showToast(
            msg: 'Reset Password Success', toastLength: Toast.LENGTH_SHORT);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        setState(() {
          processing = false;
        });
        Fluttertoast.showToast(
            msg: 'Error Occured!', toastLength: Toast.LENGTH_SHORT);
      }
    }
  }
}
