import 'package:flutter/material.dart';
import 'package:mobile_final/Models/BookModel.dart';
import 'package:mobile_final/Components/Ratings.dart';
import 'package:intl/intl.dart';
import '../Models/AuthorModel.dart';
class BookDetails extends StatefulWidget {
  var bookId;
  BookDetails({super.key, required this.bookId});
  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  static List<AuthorModel> authorList = [
    AuthorModel(authorId: "1",authorName: "Stephen King", authorAge: "75", authorRating: 5, authorCountry: "USA", authorPictureUrl: "https://images.unsplash.com/photo-1511165403689-1e53da0499fa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1664&q=80"),
    AuthorModel(authorId: "2",authorName: "J.K Rowling", authorAge: "60", authorRating: 4, authorCountry: "USA", authorPictureUrl: "https://images.unsplash.com/photo-1610466024868-910c6e7e8929?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8SkslMjByb3dsaW5nfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
    AuthorModel(authorId: "3",authorName: "Paulo Coleho", authorAge: "80", authorRating: 4, authorCountry: "USA", authorPictureUrl: "https://images.unsplash.com/photo-1522742943744-b3cd4e6f98e1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8UGF1bG8lMjBDb2VsaG98ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"),
    AuthorModel(authorId: "4",authorName: "Mark Cuban", authorAge: "75", authorRating: 3, authorCountry: "USA", authorPictureUrl: "https://images.unsplash.com/photo-1622463097549-289d80f7521d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8TWFyayUyMEN1YmFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
  ];
  static List<BookModel> bookList = [
    BookModel(bookId: "1",bookName: "Harry Potter",bookAuthor: "J.K Rowling",bookRating: 5,bookBio:  "Nullam ultricies mauris at rutrum facilisis. Ut accumsan libero a tempus consectetur. Maecenas blandit ex a enim luctus mollis. Praesent faucibus finibus ultrices. Suspendisse egestas viverra elit at mollis. Donec consectetur vulputate erat. Duis hendrerit ipsum elit, posuere consectetur libero gravida finibus. Sed consectetur ipsum ac nisl pellentesque, vel pellentesque turpis tristique.",bookPublishedDate: DateTime(1998,1,1,1),bookImageUrl: "https://images.unsplash.com/photo-1610466024868-910c6e7e8929?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8SkslMjByb3dsaW5nfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
    BookModel(bookId: "2",bookName: "IT",bookAuthor: "Stephen King",bookRating: 4,bookBio: "Nullam ultricies mauris at rutrum facilisis. Ut accumsan libero a tempus consectetur. Maecenas blandit ex a enim luctus mollis. Praesent faucibus finibus ultrices. Suspendisse egestas viverra elit at mollis. Donec consectetur vulputate erat. Duis hendrerit ipsum elit, posuere consectetur libero gravida finibus. Sed consectetur ipsum ac nisl pellentesque, vel pellentesque turpis tristique.",bookPublishedDate: DateTime(1980,1,1,1),bookImageUrl: "https://media.istockphoto.com/id/523361201/photo/book-of-stephen-king.jpg?s=1024x1024&w=is&k=20&c=G02NSEEcx9268pOGCVL3j5hqtjj393ZZDrN37g01aMo="),
    BookModel(bookId: "3",bookName: "The Alchemist",bookAuthor: "Paulo Coleho",bookRating: 4,bookBio: "Nullam ultricies mauris at rutrum facilisis. Ut accumsan libero a tempus consectetur. Maecenas blandit ex a enim luctus mollis. Praesent faucibus finibus ultrices. Suspendisse egestas viverra elit at mollis. Donec consectetur vulputate erat. Duis hendrerit ipsum elit, posuere consectetur libero gravida finibus. Sed consectetur ipsum ac nisl pellentesque, vel pellentesque turpis tristique.",bookPublishedDate: DateTime(1980,1,1,1),bookImageUrl: "https://media.istockphoto.com/id/1341442882/photo/female-witch-making-potion-on-dark-background-magic-bottles-with-potions-and-candles-on-table.jpg?s=1024x1024&w=is&k=20&c=oEJ17J8WaOSPmc-zrVclHDOmTicYGLK4c22d6XViEGw="),
    BookModel(bookId: "4",bookName: "How To Be RicH",bookAuthor: "Mark Cuban",bookRating: 3,bookBio: "Nullam ultricies mauris at rutrum facilisis. Ut accumsan libero a tempus consectetur. Maecenas blandit ex a enim luctus mollis. Praesent faucibus finibus ultrices. Suspendisse egestas viverra elit at mollis. Donec consectetur vulputate erat. Duis hendrerit ipsum elit, posuere consectetur libero gravida finibus. Sed consectetur ipsum ac nisl pellentesque, vel pellentesque turpis tristique.",bookPublishedDate: DateTime(1980,1,1,1),bookImageUrl: "https://images.unsplash.com/photo-1622463097549-289d80f7521d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8TWFyayUyMEN1YmFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
  ];
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
                              bookList[widget.bookId].bookName!,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 28,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 5),
                            Text(
                              bookList[widget.bookId].bookAuthor!,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Published on ${DateFormat('d MMM, yyyy').format(bookList[widget.bookId].bookPublishedDate!)}",
                            ),
                            SizedBox(height: 10),
                            Ratings(rating: bookList[widget.bookId].bookRating!),
                            SizedBox(height: 15),
                            Text(
                              bookList[widget.bookId].bookBio!,
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
                            image: NetworkImage(bookList[widget.bookId].bookImageUrl!),
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
