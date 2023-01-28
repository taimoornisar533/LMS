import 'package:mobile_final/Models/AuthorModel.dart';
class BookModel{
  final String? bookId;
  final String? bookName;
  final String? bookAuthor;
  final int? bookRating;
  final String? bookBio;
  final DateTime bookPublishedDate;
  final String? bookImageUrl;

  BookModel(
      {this.bookId = '',
      required this.bookName,
      required this.bookAuthor,
      required this.bookRating,
      required this.bookBio,
      required this.bookPublishedDate,
      required this.bookImageUrl});
}