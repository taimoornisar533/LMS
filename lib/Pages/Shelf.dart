import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/Models/BookModel.dart';
import 'package:mobile_final/Components/Ratings.dart';
import 'package:mobile_final/Pages/BookDetails.dart';
import '../Models/AuthorModel.dart';
class Shelf extends StatefulWidget {
  @override
  State<Shelf> createState() => _ShelfState();
}

class _ShelfState extends State<Shelf> {
  ScrollController _scrollController = ScrollController();
  static List<AuthorModel> authorList = [
    AuthorModel(1,"Stephen King","75",5,"USA","https://images.unsplash.com/photo-1511165403689-1e53da0499fa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1664&q=80"),
    AuthorModel(2,"J.K Rowling","60",4,"USA","https://images.unsplash.com/photo-1610466024868-910c6e7e8929?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8SkslMjByb3dsaW5nfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
    AuthorModel(3,"Paulo Colheo","85",4,"USA","https://images.unsplash.com/photo-1522742943744-b3cd4e6f98e1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8UGF1bG8lMjBDb2VsaG98ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"),
    AuthorModel(4,"Mark Cuban","75",3,"USA","https://images.unsplash.com/photo-1622463097549-289d80f7521d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8TWFyayUyMEN1YmFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
  ];
  static List<BookModel> bookList = [
    BookModel(1,"Harry Potter", authorList[1],5, "Book by J.K Rowling blah blah", DateTime(1998,1,1,1), "https://images.unsplash.com/photo-1610466024868-910c6e7e8929?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8SkslMjByb3dsaW5nfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
    BookModel(2,"IT", authorList[0], 4,"Book by Stephen King blah blah", DateTime(1980,1,1,1), "https://media.istockphoto.com/id/523361201/photo/book-of-stephen-king.jpg?s=1024x1024&w=is&k=20&c=G02NSEEcx9268pOGCVL3j5hqtjj393ZZDrN37g01aMo="),
    BookModel(3,"The Alchemist", authorList[2], 4, "Book by Paulo Coleho blah blah", DateTime(1980,1,1,1), "https://media.istockphoto.com/id/1341442882/photo/female-witch-making-potion-on-dark-background-magic-bottles-with-potions-and-candles-on-table.jpg?s=1024x1024&w=is&k=20&c=oEJ17J8WaOSPmc-zrVclHDOmTicYGLK4c22d6XViEGw="),
    BookModel(4,"How To Be RicH", authorList[3],3, "Book by Mark Cuban", DateTime(1980,1,1,1), "https://images.unsplash.com/photo-1622463097549-289d80f7521d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8TWFyayUyMEN1YmFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
  ];
  List<BookModel> toDisplay = List.from(bookList);
  void updateList(String value){
    setState(() {
      toDisplay = bookList.where((element) => element.bookName!.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }
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
                    onChanged: (value) => updateList(value),
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
            child: toDisplay.isNotEmpty ?
            ListView.separated(
              itemCount: toDisplay.length,
              separatorBuilder: (ctx, i) => Divider(
                thickness: 1,
                height: 36,
              ),
              itemBuilder: (ctx, i) => InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: ((context) => BookDetails(bookId: i,))
                      )
                  );
                },
                child: BooksListItem(
                bookPublishedDate: DateFormat('d MMM, yyyy').format(toDisplay[i].bookPublishedDate!),
                bookTitle: toDisplay[i].bookName!,
                bookRating: toDisplay[i].bookRating!,
                bookImageUrl: toDisplay[i].bookImageUrl!,
                ),
              ),
            )
                :
            const Center(
              child: Text(
                "No results found...",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold
                ),
              ),
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
  });

  final int bookRating;
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
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black26,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
