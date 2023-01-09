import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    final logoutButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: const Color(0xff262F3E),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.70,
        height: MediaQuery.of(context).size.height * 0.005,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: (){
          FirebaseAuth.instance.signOut();
        },
        child: Text(
          "Logout",
          style: TextStyle(color: Colors.white,fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ),
    );
    return Scaffold(
      body: Container(
        child: Center(
          child: logoutButon,
        ),
      ),
    );
  }
}
