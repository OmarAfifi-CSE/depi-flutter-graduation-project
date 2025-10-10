import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  late String? mainImage;
  late String mainName;
  late String? currentImage;
  late String currentName;
  bool showButton = false;

  void initilize({String? image, required String name}) {
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
    print("currentName" + currentName);
    print("name" + mainName);
    print("currentImage${currentImage}");
    print("image${mainImage}");
    print(showButton);
    notifyListeners();
  }

  void setName(String name) {
    currentName = name;
    checkDiff();
    print("currentName" + currentName);
    print("name" + mainName);
    print("currentImage${currentImage}");
    print("image${mainImage}");
    print(showButton);
    notifyListeners();
  }

  void checkDiff() {
    if (currentImage == mainImage && currentName == mainName) {
      showButton = false;
    } else {
      showButton = true;
    }
  }
}
