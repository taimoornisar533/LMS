import 'package:flutter/material.dart';
import 'package:mobile_final/Models/BookModel.dart';
import 'package:mobile_final/Components/Ratings.dart';
import 'package:intl/intl.dart';
import '../Models/AuthorModel.dart';
class BookDetails extends StatefulWidget {
  final BookModel book;
  BookDetails({super.key,required this.book});
  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
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
                            "Book Details",
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
                Stack(
                  children: [
                    Positioned.fill(
                      top: 65,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 175),
                            Text(
                              "${widget.book.bookName}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 28,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${widget.book.bookAuthor}",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Published on ${DateFormat('d MMM, yyyy').format(widget.book.bookPublishedDate)}",
                            ),
                            SizedBox(height: 10),
                            Ratings(rating: widget.book.bookRating?.toInt() ?? 0),
                            SizedBox(height: 15),
                            Text(
                              widget.book.bookBio?.toString() ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      heightFactor: 2.8,
                      child: Container(
                        height: 230,
                        width: 155,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.book.bookImageUrl?.toString() ?? ''),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      heightFactor: 10.2,
                      child: Container(
                        width: width * 0.80,
                        height: height * 0.08,
                        decoration: BoxDecoration(
                          color: const Color(0xff262F3E),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            "BORROW",
                            style: TextStyle(
                              color: Color(0xff2492eb),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }
}
