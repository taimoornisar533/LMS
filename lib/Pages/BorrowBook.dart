import 'package:flutter/material.dart';
import '../Models/BookModel.dart';
import '../Services/firebase_crud.dart';
import 'package:intl/intl.dart';

class AddBorrow extends StatefulWidget {
  final BookModel book;
  AddBorrow({super.key,required this.book});
  @override
  State<AddBorrow> createState() => _AddBorrowState();
}

class _AddBorrowState extends State<AddBorrow> {
  final bookName = TextEditingController();
  final bookAuthor = TextEditingController();
  final bookRating = TextEditingController();
  final bookBio = TextEditingController();
  final bookPic = TextEditingController();
  final bookPublishDate = TextEditingController();
  final borrowPrice = TextEditingController();
  final borrowDate = TextEditingController();
  final returnDate = TextEditingController();
  final borrowerName = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    bookName.value = TextEditingValue(text: widget.book!.bookName.toString());
    bookAuthor.value = TextEditingValue(text: widget.book!.bookAuthor.toString());
    bookRating.value = TextEditingValue(text: widget.book!.bookRating.toString());
    bookBio.value = TextEditingValue(text: widget.book!.bookBio.toString());
    bookPic.value = TextEditingValue(text: widget.book!.bookImageUrl.toString());
    bookPublishDate.value = TextEditingValue(text: widget.book!.bookPublishedDate.toString());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final nameField = TextFormField(
        controller: bookName,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
          icon: const Icon(Icons.menu_book_sharp,color: Color(0xff262F3E)),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Book Name",
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
      controller: bookRating,
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
        labelText: "Book Rating",
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
    final authorField = TextFormField(
        controller: bookAuthor,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
          icon: const Icon(Icons.person,color: Color(0xff262F3E)),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Book Author",
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
    final bioField = TextFormField(
        controller: bookBio,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
          icon: Icon(Icons.edit,color: Color(0xff262F3E)),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Book Bio",
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
    final dateField = TextFormField(
        controller: bookPublishDate,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(context: context,
              initialDate: DateTime.now(), firstDate: DateTime(1200),
              lastDate: DateTime(2100)
          );
          if (pickedDate != null){
            setState(() {
              bookPublishDate.text = DateFormat('yyyy-MM-dd').format(pickedDate);
            });
          }
        },
        decoration: InputDecoration(
          icon: const Icon(Icons.calendar_month, color:Color(0xff262F3E),),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Publish Date",
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
        controller: bookPic,
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
    final borrowerNameField = TextFormField(
        controller: borrowerName,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
          icon: const Icon(Icons.menu_book_sharp,color: Color(0xff262F3E)),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Borrower Name",
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
    final borrowDateField = TextFormField(
        controller: borrowDate,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(context: context,
              initialDate: DateTime.now(), firstDate: DateTime(1200),
              lastDate: DateTime(2100)
          );
          if (pickedDate != null){
            setState(() {
              borrowDate.text = DateFormat('yyyy-MM-dd').format(pickedDate);
            });
          }
        },
        decoration: InputDecoration(
          icon: const Icon(Icons.calendar_month, color:Color(0xff262F3E),),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Borrowing Date",
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
    final returnDateField = TextFormField(
        controller: returnDate,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(context: context,
              initialDate: DateTime.now(), firstDate: DateTime(1200),
              lastDate: DateTime(2100)
          );
          if (pickedDate != null){
            setState(() {
              returnDate.text = DateFormat('yyyy-MM-dd').format(pickedDate);
            });
          }
        },
        decoration: InputDecoration(
          icon: const Icon(Icons.calendar_month, color:Color(0xff262F3E),),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Returning Date",
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
    final borrowBookPrice = TextFormField(
        controller: borrowPrice,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
          icon: const Icon(Icons.menu_book_sharp,color: Color(0xff262F3E)),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Book Price",
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
    final SaveButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: const Color(0xff262F3E),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {

            var response = await FirebaseCrud.addBorrow(
                name: bookName.text,
                author: bookAuthor.text,
                rating: bookRating.text,
                bio: bookBio.text,
                date: bookPublishDate.text,
                picture: bookPic.text,
                price: borrowPrice.text,
                bDate: borrowDate.text,
                rDate: returnDate.text,
                bName: borrowerName.text,
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
          "Borrow",
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
                          "Borrow Book",
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
                      authorField,
                      const SizedBox(height: 40.0),
                      ratingField,
                      const SizedBox(height: 40.0),
                      bioField,
                      const SizedBox(height: 40.0),
                      dateField,
                      const SizedBox(height: 40.0),
                      pictureField,
                      const SizedBox(height: 40.0),
                      borrowerNameField,
                      const SizedBox(height: 40.0),
                      borrowBookPrice,
                      const SizedBox(height: 40.0),
                      borrowDateField,
                      const SizedBox(height: 40.0),
                      returnDateField,
                      const SizedBox(height: 40.0),
                      SaveButton,
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
