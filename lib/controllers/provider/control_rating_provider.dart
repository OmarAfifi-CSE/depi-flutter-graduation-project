import 'package:batrina/models/product_model.dart';
import 'package:batrina/models/review_model.dart';
import 'package:flutter/cupertino.dart';

class ControlRatingProvider extends ChangeNotifier {
  late double currentRating;
  late int currentRatingCount;

  void setRating(List<ReviewModel> reviews) {
    double totalRating = 0;
    for (var review in reviews) {
      totalRating += review.rating;
    }
    double averageRating = totalRating / reviews.length;
    averageRating = averageRating.clamp(0.0, 5.0);
    currentRating = averageRating.round().toDouble();
    currentRatingCount = reviews.length;
    notifyListeners();
  }
}
