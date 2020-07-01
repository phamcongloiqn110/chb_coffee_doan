import 'package:bhccoffee/model/DrinkOrderDetail.dart';

import 'package:flutter/cupertino.dart';

class OrderDetail extends ChangeNotifier{
  List<DrinkOrderDetail> _drinkOrderDetails = [];
  double _price = 0.0;

  void addDrink(DrinkOrderDetail drink){
    _drinkOrderDetails.add(drink);
    _price += drink.priceAfterSale;
    notifyListeners();
  }

  void removeDrink(DrinkOrderDetail drink){
    _price -= drink.priceAfterSale;
    _drinkOrderDetails.remove(drink);
    notifyListeners();
  }


  int get count {
    return _drinkOrderDetails.length;
  }

  set count (int value) {
    _drinkOrderDetails.length = value;
  }

  double get totalPrice {
    return _price;
  }

  set totalPrice(double value) {
    _price = value;
  }


  set drinkOrderDetails(List<DrinkOrderDetail> value) {
    _drinkOrderDetails = value;
  }

  List<DrinkOrderDetail> get basketDrinkOrderDetail {
    return _drinkOrderDetails;
  }

  set basketDrinkOrderDetail(List<DrinkOrderDetail> value) {
    _drinkOrderDetails = value;
  }

  double tongGia(double value) {
    _price = value;
  }

  set price(double value) {
    _price = value;
  }
}