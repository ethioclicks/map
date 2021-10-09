import 'package:flutter/cupertino.dart';

class AddCarProvider with ChangeNotifier {
  final String carName;
  final String color;
  final String model;

  AddCarProvider(
    @required this.carName,
    @required this.color,
    @required this.model,
  );
}
