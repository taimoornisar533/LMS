import 'package:mobile_final/Models/AuthorModel.dart';
class BookModel{
  int? bookId;
  String? bookName;
  AuthorModel? bookAuthor;
  int? bookRating;
  String? bookBio;
  DateTime? bookPublishedDate;
  String? bookImageUrl;

  BookModel(this.bookId,this.bookName,this.bookAuthor,this.bookRating,this.bookBio,this.bookPublishedDate,this.bookImageUrl);
}