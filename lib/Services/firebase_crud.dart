import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Admins');
final CollectionReference _Collection2 = _firestore.collection('Customers');

class FirebaseCrud {

  static Future<Response> registerAdmin({
    required String uname,
    required String password,
  }) async {

    Response response = Response();
    DocumentReference documentReferencer =
        _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "user_name": uname,
      "password": password,
    };

    var result = await documentReferencer
        .set(data)
        .whenComplete(() {
          response.code = 200;
          response.message = "Sucessfully registred as admin";
        })
        .catchError((e) {
            response.code = 500;
            response.message = e;
        });

        return response;
  }

  static Future<Response> addCustomer({
    required String name,
    required String city,
    required String contactno,
    required String country,
    required String cnic,
  }) async {

    Response response = Response();
    DocumentReference documentReferencer =
    _Collection2.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "customer_name": name,
      "customer_city": city,
      "contact_no" : contactno,
      "customer_country" : country,
      "customer_cnic" : cnic
    };

    var result = await documentReferencer
        .set(data)
        .whenComplete(() {
      response.code = 200;
      response.message = "Customer sucessfully added to the database";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }


  static Future<Response> updateEmployee({
    required String name,
    required String position,
    required String contactno,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer =
        _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "employee_name": name,
      "position": position,
      "contact_no" : contactno
    };

    await documentReferencer
        .update(data)
        .whenComplete(() {
           response.code = 200;
          response.message = "Sucessfully updated Employee";
        })
        .catchError((e) {
            response.code = 500;
            response.message = e;
        });

        return response;
  }

  static Future<Response> updateCustomer({
    required String name,
    required String city,
    required String contactno,
    required String country,
    required String cnic,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer =
    _Collection2.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "customer_name": name,
      "customer_city": city,
      "contact_no" : contactno,
      "customer_country" : country,
      "customer_cnic" : cnic
    };

    await documentReferencer
        .update(data)
        .whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated Customer";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readEmployee() {
    CollectionReference notesItemCollection =
        _Collection;

    return notesItemCollection.snapshots();
  }

  static Stream<QuerySnapshot> readCustomers() {
    CollectionReference notesItemCollection =
        _Collection2;

    return notesItemCollection.snapshots();
  }

  static Future<Response> deleteEmployee({
    required String docId,
  }) async {
     Response response = Response();
    DocumentReference documentReferencer =
        _Collection.doc(docId);

    await documentReferencer
        .delete()
        .whenComplete((){
          response.code = 200;
          response.message = "Sucessfully Deleted Employee";
        })
        .catchError((e) {
           response.code = 500;
            response.message = e;
        });

   return response;
  }

  static Future<Response> deleteCustomer({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer =
    _Collection2.doc(docId);

    await documentReferencer
        .delete()
        .whenComplete((){
      response.code = 200;
      response.message = "Sucessfully Deleted Customer";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

}