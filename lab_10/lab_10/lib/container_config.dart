import 'package:flutter/material.dart';

class ContainerConfig with ChangeNotifier {
  double width = 200.0;
  double height = 200.0;
  double borderRadius = 20.0;

  void updateWidth(double newWidth) {
    width = newWidth;
    notifyListeners();
  }

  void updateHeight(double newHeight) {
    height = newHeight;
    notifyListeners();
  }

  void updateBorderRadius(double newRadius) {
    borderRadius = newRadius;
    notifyListeners();
  }
}
