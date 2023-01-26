import 'package:flutter/material.dart';
import '../Services/firebase_crud.dart';
class AddAuthor extends StatefulWidget {
  @override
  State<AddAuthor> createState() => _AddAuthorState();
}

class _AddAuthorState extends State<AddAuthor> {
  final authorName = TextEditingController();
  final authorAge = TextEditingController();
  final authorRating = TextEditingController();
  final authorCountry = TextEditingController();
  final authorPic = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final nameField = TextFormField(
        controller: authorName,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
            return 'Only Enter Alphabets';
          }
        },
        decoration: InputDecoration(
            icon: const Icon(Icons.person,color: Color(0xff262F3E)),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            labelText: "Author Name",
            labelStyle: const TextStyle(color: Color(0xff262F3E)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: const BorderSide(width: 2.0, color: Color(0xff262F3E)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
        )
    );
    final ratingField = TextFormField(
        controller: authorRating,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          if (!RegExp(r'^[0-9]+$').hasMatch(value)){
            return 'Only Enter Numbers';
          }
        },
        decoration: InputDecoration(
          icon: const Icon(Icons.star,color: Color(0xff262F3E)),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Author Rating",
          labelStyle: const TextStyle(color: Color(0xff262F3E)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: const BorderSide(width: 2.0, color: Color(0xff262F3E)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
    );
    final ageField = TextFormField(
        controller: authorAge,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          if (!RegExp(r'^[0-9]+$').hasMatch(value)){
            return 'Only Enter Numbers';
          }
        },
        decoration: InputDecoration(
          icon: const Icon(Icons.calendar_month,color: Color(0xff262F3E)),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Author Age",
          labelStyle: const TextStyle(color: Color(0xff262F3E)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: const BorderSide(width: 2.0, color: Color(0xff262F3E)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        )
    );
    final countryField = TextFormField(
        controller: authorCountry,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
          icon: const Icon(Icons.flag,color: Color(0xff262F3E)),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Author Country",
          labelStyle: const TextStyle(color: Color(0xff262F3E)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: const BorderSide(width: 2.0, color: Color(0xff262F3E)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        )
    );
    final pictureField = TextFormField(
        controller: authorPic,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
          icon: const Icon(Icons.camera_alt,color: Color(0xff262F3E)),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Author Picture",
          labelStyle: const TextStyle(color: Color(0xff262F3E)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: const BorderSide(width: 2.0, color: Color(0xff262F3E)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        )
    );
    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: const Color(0xff262F3E),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {

            var response = await FirebaseCrud.addAuthor(
              name: authorName.text,
              age: authorAge.text,
              country: authorCountry.text,
              rating: authorRating.text,
              picture: authorPic.text
            );
            if (response.code != 200) {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: const Color(0xff262F3E),
                  title: const Text(
                    "LMS",
                    style: TextStyle(color: Color(0xff2492eb)),
                  ),
                  content: Text(response.message.toString(),style: TextStyle(color: Colors.white),),
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
            } else {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: const Color(0xff262F3E),
                  title: const Text(
                    "LMS",
                    style: TextStyle(color: Color(0xff2492eb)),
                  ),
                  content: Text(response.message.toString(),style: TextStyle(color: Colors.white),),
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
        child: const Text(
          "Add Author",
          style: TextStyle(color: Color(0xff2492eb),fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                width: width,
                height: height * 0.12,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                    color: Color(0xff262F3E)
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 8.0, 45.0, 8.0),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white38,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: height * 0.01),
                        child: const Text(
                          "Add Author",
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      nameField,
                      const SizedBox(height: 40.0),
                      ageField,
                      const SizedBox(height: 40.0),
                      ratingField,
                      const SizedBox(height: 40.0),
                      countryField,
                      const SizedBox(height: 40.0),
                      pictureField,
                      const SizedBox(height: 40.0),
                      SaveButon,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
