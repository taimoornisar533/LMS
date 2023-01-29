import 'package:mobile_final/Models/AuthorModel.dart';
class BorrowModel{
  final String? bookId;
  final String? bookName;
  final String? bookAuthor;
  final int? bookRating;
  final String? bookBio;
  final DateTime? bookPublishedDate;
  final String? bookImageUrl;
  final String? bookPrice;
  final DateTime? borrowDate;
  final DateTime? returnDate;
  final String? borrowerName;

  BorrowModel({
      this.bookId,
      this.bookName,
      this.bookAuthor,
      this.bookRating,
      this.bookBio,
      this.bookPublishedDate,
      this.bookImageUrl,
      this.bookPrice,
      this.borrowDate,
      this.returnDate,
      this.borrowerName});
}