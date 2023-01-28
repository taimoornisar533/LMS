import 'package:flutter/material.dart';
import '../Components/Ratings.dart';
import '../Models/AuthorModel.dart';
import '../Models/BookModel.dart';

class AuthorDetail extends StatefulWidget {
  final AuthorModel author;
  AuthorDetail({super.key, required this.author});
  @override
  State<AuthorDetail> createState() => _AuthorDetailState();
}

class _AuthorDetailState extends State<AuthorDetail> {
  static List<BookModel> bookList = [
    BookModel(bookId: "1",bookName: "Harry Potter",bookAuthor:"J.K Rowling",bookRating: 5,bookBio: "Book by J.K Rowling blah blah",bookPublishedDate: DateTime(1998,1,1,1),bookImageUrl: "https://images.unsplash.com/photo-1610466024868-910c6e7e8929?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8SkslMjByb3dsaW5nfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
    BookModel(bookId:"2",bookName: "IT",bookAuthor: "Stephen King",bookRating: 4,bookBio: "Book by Stephen King blah blah",bookPublishedDate: DateTime(1980,1,1,1),bookImageUrl: "https://media.istockphoto.com/id/523361201/photo/book-of-stephen-king.jpg?s=1024x1024&w=is&k=20&c=G02NSEEcx9268pOGCVL3j5hqtjj393ZZDrN37g01aMo="),
  ];
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.black87,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );
/*  static List<AuthorModel> authorList = [
    AuthorModel(authorId: "1",authorName: "Stephen King", authorAge: "75", authorRating: 5, authorCountry: "USA", authorPictureUrl: "https://images.unsplash.com/photo-1511165403689-1e53da0499fa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1664&q=80"),
    AuthorModel(authorId: "2",authorName: "J.K Rowling", authorAge: "60", authorRating: 4, authorCountry: "USA", authorPictureUrl: "https://images.unsplash.com/photo-1610466024868-910c6e7e8929?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8SkslMjByb3dsaW5nfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
    AuthorModel(authorId: "3",authorName: "Paulo Coleho", authorAge: "80", authorRating: 4, authorCountry: "USA", authorPictureUrl: "https://images.unsplash.com/photo-1522742943744-b3cd4e6f98e1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8UGF1bG8lMjBDb2VsaG98ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"),
    AuthorModel(authorId: "4",authorName: "Mark Cuban", authorAge: "75", authorRating: 3, authorCountry: "USA", authorPictureUrl: "https://images.unsplash.com/photo-1622463097549-289d80f7521d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8TWFyayUyMEN1YmFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
  ];*/
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
                          "Author Details",
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
                    top: 60,
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
                            "${widget.author.authorName}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 28,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${widget.author.authorAge} yrs old",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                           "${widget.author.authorCountry}",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10),
                          Ratings(rating: widget.author.authorRating?.toInt() ?? 0),
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Published Books",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextButton(
                                style: flatButtonStyle,
                                onPressed: () {},
                                child: Text("View all"),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                              height: 220,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  for (int i = 0; i < (bookList.length == 1 ? 1 : 2); i++)
                                    SizedBox(
                                      width: 120,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 160,
                                            width: 115,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(bookList[i].bookImageUrl!),
                                                fit: BoxFit.fill,
                                              ),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            bookList[i].bookName!,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 2),
                                          Ratings(rating: bookList[i].bookRating!, size: 18),
                                        ],
                                      ),
                                    ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    heightFactor: 3.2,
                    child: CircleAvatar(
                      radius: 110,
                      backgroundImage: NetworkImage(widget.author.authorPictureUrl?.toString() ?? ''),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
