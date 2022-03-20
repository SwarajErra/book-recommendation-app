import 'package:book_recommendation_app/Rating.dart';

class Book {
  final String bookTitle;
  final int bookId;
  final int bookImageId;
  final String bookCategory;
  final String bookSubTitle;
  final String bookCoverDetails;
  final double bookOverallRating;
  final String bookAddedBy;
  final String bookPublishedBy;
  final List<Rating> bookRatingsAndReviews;
  final bool isBlocked;

  Book({
        required this.bookTitle,
        required this.bookId,
        required this.bookImageId,
        required this.bookCategory,
        required this.bookSubTitle,
        required this.bookCoverDetails,
        required this.bookOverallRating,
        required this.bookAddedBy,
        required this.bookPublishedBy,
        required this.bookRatingsAndReviews,
        required this.isBlocked,
      });
}
