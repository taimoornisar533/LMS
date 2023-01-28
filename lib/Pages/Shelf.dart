import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/Models/BookModel.dart';
import 'package:mobile_final/Components/Ratings.dart';
import 'package:mobile_final/Pages/AddBook.dart';
import 'package:mobile_final/Pages/BookDetails.dart';
import '../Models/AuthorModel.dart';
import '../Services/firebase_crud.dart';
class Shelf extends StatefulWidget {
  @override
  State<Shelf> createState() => _ShelfState();
}

class _ShelfState extends State<Shelf> {
  ScrollController _scrollController = ScrollController();
  String search = "";
  Stream<QuerySnapshot> bookList = FirebaseCrud.readBooks();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(
                  builder: ((context) => AddBook())
              )
          );
        },
        backgroundColor: const Color(0xff262F3E),
        tooltip: "Add Book",
        child: const Icon(Icons.add),
      ),
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
                    "Shelf",
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
                              book: BookModel(
                                bookName: data['book_name'],
                                bookBio: data['book_bio'],
                                bookAuthor: data['book_author'],
                                bookImageUrl: data['book_picture'],
                                bookRating: int.parse(data['book_rating']),
                                bookId: data['book_id'],
                                bookPublishedDate: DateTime.parse(data['book_published_date'])
                              ),
                              bookPublishedDate: DateFormat('d MMM, yyyy').format(DateTime.parse(data['book_published_date'])),
                              bookTitle: data['book_name'],
                              bookRating: int.parse(data['book_rating']),
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
                              book: BookModel(
                                  bookName: data['book_name'],
                                  bookBio: data['book_bio'],
                                  bookAuthor: data['book_author'],
                                  bookImageUrl: data['book_picture'],
                                  bookRating: int.parse(data['book_rating']),
                                  bookId: data['book_id'],
                                  bookPublishedDate: DateTime.parse(data['book_published_date'])
                              ),
                              bookPublishedDate: DateFormat('d MMM, yyyy').format(DateTime.parse(data['book_published_date'])),
                              bookTitle: data['book_name'],
                              bookRating: int.parse(data['book_rating']),
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
    required this.bookRating,
    required this.bookPublishedDate,
    required this.bookTitle,
    required this.bookImageUrl,
    required this.book,
  });

  final int bookRating;
  final BookModel book;
  final String bookPublishedDate;
  final String bookTitle;
  final String bookImageUrl;

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
                  Text(
                    bookPublishedDate,
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
                  Ratings(rating: bookRating),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: ((context) => BookDetails(book: book,))
                      )
                  );
                },
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black26,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
