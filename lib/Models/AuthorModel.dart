class AuthorModel{
  final String? authorId;
  final String? authorName;
  final String? authorAge;
  final int? authorRating;
  final String? authorCountry;
  final String? authorPictureUrl;

  AuthorModel({this.authorId = '',required this.authorName,required this.authorAge,required this.authorRating,required this.authorCountry,required this.authorPictureUrl});
}