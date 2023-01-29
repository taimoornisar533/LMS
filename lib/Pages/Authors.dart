import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/Models/AuthorModel.dart';
import 'package:mobile_final/Components/Ratings.dart';
import 'package:mobile_final/Pages/AddAuthor.dart';
import 'package:mobile_final/Pages/AuthorDetails.dart';
import '../Services/firebase_crud.dart';
class Authors extends StatefulWidget {
  @override
  State<Authors> createState() => _AuthorsState();
}

class _AuthorsState extends State<Authors> {
  ScrollController _scrollController = ScrollController();
  String search = "";
  Stream<QuerySnapshot> authorList = FirebaseCrud.readAuthors();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(
                  builder: ((context) => AddAuthor())
              )
          );
        },
        backgroundColor: const Color(0xff262F3E),
        tooltip: "Add Author",
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
                    "Authors",
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
                     hintText: "Search for Authors",
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
              stream: authorList,
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
                            child: AuthorsListItem(
                              auth: AuthorModel(authorName: data['author_name'],
                                  authorAge: data['author_age'],
                                  authorRating: int.parse(data['author_rating']),
                                  authorCountry: data['author_country'],
                                  authorPictureUrl: data['author_picture'],
                                  authorId: data['author_id']
                              ),
                              authorId: data['author_id'],
                              authorAge: data['author_age'],
                              authorName: "${data['author_name']}",
                              authorRating: int.parse(data['author_rating']),
                              authorImageUrl: data['author_picture'],
                            ),
                          ),
                        );
                      }
                      if (data['author_name']
                          .toString()
                          .toLowerCase()
                          .contains(search.toLowerCase())) {
                        return Card(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                            child: AuthorsListItem(
                              auth: AuthorModel(authorName: data['author_name'],
                                  authorAge: data['author_age'],
                                  authorRating: int.parse(data['author_rating']),
                                  authorCountry: data['author_country'],
                                  authorPictureUrl: data['author_picture'],
                                  authorId: data['author_id']
                              ),
                              authorId: data['author_id'],
                              authorAge: data['author_age'],
                              authorName: "${data['author_name']}",
                              authorRating: int.parse(data['author_rating']),
                              authorImageUrl: data['author_picture'],
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
class AuthorsListItem extends StatelessWidget {
  const AuthorsListItem({
    required this.authorId,
    required this.authorAge,
    required this.authorRating,
    required this.authorName,
    required this.authorImageUrl,
    required this.auth,
  });
  final String authorId;
  final String authorAge;
  final int authorRating;
  final String authorName;
  final String authorImageUrl;
  final AuthorModel auth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(authorImageUrl),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$authorAge yrs old",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "$authorName",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Ratings(rating: authorRating),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: ((context) => AuthorDetail(author: auth,))
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
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 20, 5),
            child: GestureDetector(
              onTap: () async {
                var response =
                await FirebaseCrud.deleteAuthor(docId: authorId);
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
              child: Icon(
                Icons.delete,
                color: Colors.black26,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
