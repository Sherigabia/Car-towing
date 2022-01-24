import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:towghana/screens/login.dart';

class TokenScreen extends StatefulWidget {
  const TokenScreen({Key? key}) : super(key: key);

  @override
  _TokenScreenState createState() => _TokenScreenState();
}

class _TokenScreenState extends State<TokenScreen> {
  bool processing = false;

  //form key
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController phoneNumberEditingController =
      new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final phoneNumberField = TextFormField(
        autofocus: false,
        controller: phoneNumberEditingController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter Token Sent !";
          }
        },
        onSaved: (value) {
          phoneNumberEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.phone_android),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Enter Token ",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

    //Password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
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
          passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Enter Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

    // Confirm Password
    final confirmPasswordField = TextFormField(
        autofocus: false,
        obscureText: true,
        controller: confirmPasswordEditingController,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Passwords do not match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Confirm Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));
    final loginButton = Material(
        elevation: 5,
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
            onPressed: () {
              updatePassword(phoneNumberEditingController.text,
                  confirmPasswordEditingController.text);
            },
            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
            minWidth: MediaQuery.of(context).size.width,
            child: processing == false
                ? Text("Submit",
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.red,
            )),
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
                      //  mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Password Reset",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 45),
                        // SizedBox(
                        //     height: 200,
                        //     child: Image.asset(
                        //       'assets/images/logo.jpeg',
                        //       fit: BoxFit.contain,
                        //     )),
                        SizedBox(height: 25),
                        phoneNumberField,
                        SizedBox(height: 25),
                        SizedBox(height: 20),
                        passwordField,
                        SizedBox(height: 20),
                        confirmPasswordField,
                        SizedBox(height: 20),

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
  void updatePassword(String token, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        processing = true;
      });

      var url = Uri.parse('https://towghana.com/tg/api/user/updatePassword');

      var data = {
        "token": phoneNumberEditingController.text,
        "password": confirmPasswordEditingController.text,
      };
      print(data);
      var response = await http.post(url, body: data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          processing = false;
        });
        Fluttertoast.showToast(
            msg: 'Password Successfully Reset ',
            toastLength: Toast.LENGTH_SHORT);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        setState(() {
          processing = false;
        });
        Fluttertoast.showToast(
            msg: 'Could not Reset Password', toastLength: Toast.LENGTH_SHORT);
      }
    }
  }
}
