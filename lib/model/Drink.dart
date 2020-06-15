import '../model/ListDrinks.dart';

class Drink{
  final String description;
  final String image;
  final bool isActive;
  final bool isSale;
  final ListFood keyList;
  final String name;
  final String price;
  final String sale;

  Drink({this.description, this.image, this.isActive, this.isSale, this.keyList,
      this.name, this.price, this.sale});
}