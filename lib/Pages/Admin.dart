import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/Models/BookModel.dart';
import 'package:mobile_final/Components/Ratings.dart';
import 'package:mobile_final/Pages/AddBook.dart';
import 'package:mobile_final/Pages/BookDetails.dart';
import 'package:mobile_final/Pages/BorrowBook.dart';
import '../Models/AuthorModel.dart';
import '../Models/BorrowModel.dart';
import '../Services/firebase_crud.dart';
class AdminPage extends StatefulWidget {
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  ScrollController _scrollController = ScrollController();
  String search = "";
  Stream<QuerySnapshot> bookList = FirebaseCrud.readBorrows();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: width,
            height: height * 0.22,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
                color: Color(0xff262F3E)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "Borrowed Books",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                  margin: EdgeInsets.only(bottom: height * 0.01),
                ),
                SizedBox(
                  width: width * 0.80,
                  child: TextField(
                    onTap: (){
                      Timer(Duration(milliseconds: 200), () {
                        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                      });
                    },
                    onChanged: (value){
                      setState(() {
                        search = value;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.all(5),
                      hintText: "Search for Books",
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Color(0xff262F3E),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: bookList,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index].data()
                      as Map<String, dynamic>;

                      if (search == "") {
                        return Card(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                            child: BooksListItem(
                              borrow: BorrowModel(
                                  bookName: data['book_name'],
                                  bookBio: data['book_bio'],
                                  bookAuthor: data['book_author'],
                                  bookImageUrl: data['book_picture'],
                                  bookRating: int.parse(data['book_rating']),
                                  bookId: data['book_id'],
                                  bookPublishedDate: DateTime.parse(data['book_published_date']),
                                  borrowerName: data['borrower_name'],
                                  borrowDate: DateTime.parse(data['book_bdate']),
                                  returnDate: DateTime.parse(data['book_rdate']),
                              ),
                              borrowDate: DateFormat('d MMM, yyyy').format(DateTime.parse(data['book_bdate'])),
                              returnDate: DateFormat('d MMM, yyyy').format(DateTime.parse(data['book_rdate'])),
                              bookTitle: data['book_name'],
                              bookId: data['book_id'],
                              borrowerName: data['borrower_name'],
                              bookImageUrl: data['book_picture'],
                            ),
                          ),
                        );
                      }
                      if (data['book_name']
                          .toString()
                          .toLowerCase()
                          .contains(search.toLowerCase())) {
                        return Card(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                            child: BooksListItem(
                              borrow: BorrowModel(
                                  bookName: data['book_name'],
                                  bookBio: data['book_bio'],
                                  bookAuthor: data['book_author'],
                                  bookImageUrl: data['book_picture'],
                                  bookRating: int.parse(data['book_rating']),
                                  bookId: data['book_id'],
                                  bookPublishedDate: DateTime.parse(data['book_published_date']),
                                  borrowDate: DateTime.parse(data['book_bdate']),
                                  returnDate: DateTime.parse(data['book_rdate']),
                            ),
                              borrowDate: DateFormat('d MMM, yyyy').format(DateTime.parse(data['book_bdate'])),
                              returnDate: DateFormat('d MMM, yyyy').format(DateTime.parse(data['book_rdate'])),
                              bookTitle: data['book_name'],
                              bookId: data['book_id'],
                              borrowerName: data['borrower_name'],
                              bookImageUrl: data['book_picture'],
                            ),
                          ),
                        );
                      }
                      return Container();
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BooksListItem extends StatelessWidget {
  const BooksListItem({
    required this.borrowerName,
    required this.borrowDate,
    required this.returnDate,
    required this.bookTitle,
    required this.bookImageUrl,
    required this.borrow,
    required this.bookId,
  });

  final String borrowerName;
  final BorrowModel borrow;
  final String borrowDate;
  final String returnDate;
  final String bookTitle;
  final String bookImageUrl;
  final String bookId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: Container(
        child: Row(
          children: [
            //Book Image
            Container(
              height: 160,
              width: 115,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(bookImageUrl),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(width: 20),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( "Borrow Date: " +
                    borrowDate,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text( "Return Date: " +
                    returnDate,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 130,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            bookTitle,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 130,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text( "Borrowed By: " + borrowerName,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),

                ],
              ),
            ),
            Spacer(),
            TextButton(
              style: TextButton.styleFrom(
                primary: const Color.fromARGB(255, 143, 133, 226),
                textStyle: const TextStyle(fontSize: 12.5),
              ),
              child: const Text('Return'),
              onPressed: () async {
                var response =
                await FirebaseCrud.deleteBorrow(docId: bookId);
                if (response.code != 200) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content:
                          Text(response.message.toString()),
                        );
                      });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
