import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  late String? mainImage;
  late String mainName;
  late String? currentImage;
  late String currentName;
  bool showButton = false;

  void initialize({String? image, required String name}) {
    currentImage = image;
    currentName = name;
    mainImage = image;
    mainName = name;
  }

  void reset({String? image, required String name}) {
    currentImage = image;
    currentName = name;
    mainImage = image;
    mainName = name;

    //for reset
    checkDiff();

    notifyListeners();
  }

  void setImage(String image) async {
    currentImage = image;
    checkDiff();
    notifyListeners();
  }

  void setName(String name) {
    currentName = name;
    checkDiff();
    notifyListeners();
  }

  void checkDiff() {
    if (currentImage == mainImage && currentName == mainName) {
      showButton = false;
    } else {
      showButton = true;
    }
  }

  void clearData() {
    mainImage = null;
    mainName = '';
    currentImage = null;
    currentName = '';
    showButton = false;
  }
}
