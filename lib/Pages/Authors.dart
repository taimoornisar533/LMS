import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_final/Models/AuthorModel.dart';
import 'package:mobile_final/Components/Ratings.dart';
import 'package:mobile_final/Pages/AuthorDetails.dart';
class Authors extends StatefulWidget {
  @override
  State<Authors> createState() => _AuthorsState();
}

class _AuthorsState extends State<Authors> {
  ScrollController _scrollController = ScrollController();
  static List<AuthorModel> authorList = [
    AuthorModel(1,"Stephen King","75",5,"USA","https://images.unsplash.com/photo-1511165403689-1e53da0499fa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1664&q=80"),
    AuthorModel(2,"J.K Rowling","60",4,"USA","https://images.unsplash.com/photo-1610466024868-910c6e7e8929?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8SkslMjByb3dsaW5nfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
    AuthorModel(3,"Paulo Colheo","85",4,"USA","https://images.unsplash.com/photo-1522742943744-b3cd4e6f98e1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8UGF1bG8lMjBDb2VsaG98ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"),
    AuthorModel(4,"Mark Cuban","75",3,"USA","https://images.unsplash.com/photo-1622463097549-289d80f7521d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8TWFyayUyMEN1YmFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
  ];
  List<AuthorModel> toDisplay = List.from(authorList);
  void updateList(String value){
    setState(() {
      toDisplay = authorList.where((element) => element.authorName!.toLowerCase().contains(value.toLowerCase())).toList();
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
                    onChanged: (value) => updateList(value),
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
              child:toDisplay.isNotEmpty ?
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
                            builder: ((context) => AuthorDetail(authorId: i))
                        )
                    );
                  },
                  child: AuthorsListItem(
                    authorAge: toDisplay[i].authorAge!,
                    authorName: "${toDisplay[i].authorName}",
                    authorRating: toDisplay[i].authorRating!,
                    authorImageUrl: toDisplay[i].authorPictureUrl!,
                  ),
                ),
              )
                  :
              Center(
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
class AuthorsListItem extends StatelessWidget {
  const AuthorsListItem({
    required this.authorAge,
    required this.authorRating,
    required this.authorName,
    required this.authorImageUrl,
  });

  final String authorAge;
  final int authorRating;
  final String authorName;
  final String authorImageUrl;

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
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black26,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
