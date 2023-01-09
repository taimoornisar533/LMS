import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  final VoidCallback onClickedLogin;
  const SignUp({
    Key ? key,
    required this.onClickedLogin,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  final adminName = TextEditingController();
  final adminPass = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final nameField = TextFormField(
        controller: adminName,
        autofocus: false,
        onTap: (){
          Timer(Duration(milliseconds: 200), () {
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          });
        },
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "User Name",
            border:
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0)
            )
        )
    );
    final passField = TextFormField(
        controller: adminPass,
        autofocus: false,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        onTap: (){
          Timer(Duration(milliseconds: 200), () {
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          });
        },
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "User Password",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))));
    final signupButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: const Color(0xff262F3E),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.70,
        height: MediaQuery.of(context).size.height * 0.005,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            try {
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: adminName.text.trim(), password: adminPass.text.trim(),
              );
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: const Color(0xff262F3E),
                  title: const Text(
                    "LMS",
                    style: TextStyle(color: Color(0xff2492eb)),
                  ),
                  content: Text("User Registered Successfully",style: TextStyle(color: Colors.white),),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Container(
                        color: const Color(0xff262F3E),
                        padding: const EdgeInsets.all(14),
                        child: const Text("Okay"),
                      ),
                    ),
                  ],
                ),
              );
            } on FirebaseAuthException catch (e) {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: const Color(0xff262F3E),
                  title: const Text(
                    "LMS",
                    style: TextStyle(color: Color(0xff2492eb)),
                  ),
                  content: Text(e.message.toString(),style: TextStyle(color: Colors.white),),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Container(
                        color: const Color(0xff262F3E),
                        padding: const EdgeInsets.all(14),
                        child: const Text("Okay"),
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        },
        child: Text(
          "Register",
          style: TextStyle(color: Colors.white,fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ),
    );
    final loginlink = RichText(
      text: TextSpan(
          text: "Already have an Account?  ",
          style: TextStyle(
              color: Colors.black,
              fontSize: 20
          ),
          children: [
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = widget.onClickedLogin,
              text: "Login",
              style: TextStyle(
                  color: Color(0xff2492eb)
              ),
            ),
          ]
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
                width: width,
                height: height * 0.55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
                    color: Color(0xff262F3E)
                ),
                child: Image.asset("Assets/Images/flutterlogo.png")
            ),
            const SizedBox(height: 25.0),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    nameField,
                    const SizedBox(height: 25.0),
                    passField,
                    const SizedBox(height: 25.0),
                    signupButon,
                    const SizedBox(height: 25.0),
                    loginlink,
                    const SizedBox(height: 100.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
