import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_final/Models/AuthorModel.dart';
import '../models/Response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Authors');
final CollectionReference _Collection2 = _firestore.collection('Books');

class FirebaseCrud {

  static Future<Response> addAuthor({
    required String name,
    required String age,
    required String rating,
    required String country,
    required String picture,
  }) async {

    Response response = Response();

    final docAuthor = FirebaseFirestore.instance.collection('Authors').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "author_id": docAuthor.id,
      "author_name": name,
      "author_age": age,
      "author_rating" : rating,
      "author_country" : country,
      "author_picture" : picture
    };

    var result = await docAuthor
        .set(data)
        .whenComplete(() {
      response.code = 200;
      response.message = "Author sucessfully added to the database";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> addBook({
    required String name,
    required String author,
    required String rating,
    required String bio,
    required String date,
    required String picture,
  }) async {

    Response response = Response();

    final docAuthor = FirebaseFirestore.instance.collection('Books').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "book_id": docAuthor.id,
      "book_name": name,
      "book_author": author,
      "book_rating" : rating,
      "book_bio" : bio,
      "book_published_date" : date,
      "book_picture" : picture
    };

    var result = await docAuthor
        .set(data)
        .whenComplete(() {
      response.code = 200;
      response.message = "Book sucessfully added to the database";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readAuthors() {
    CollectionReference notesItemCollection =
        _Collection;

    return notesItemCollection.snapshots();
  }

  static Stream<QuerySnapshot> readBooks() {
    CollectionReference notesItemCollection =
        _Collection2;

    return notesItemCollection.snapshots();
  }

}