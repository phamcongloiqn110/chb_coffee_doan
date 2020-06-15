import 'package:bhccoffee/model/Drink.dart';

class ListFood{
  String _id;
  String _name;
  String _description;
  bool _isActive;
  List<Drink> _listDrinks;

  ListFood(this._id, this._name, this._description, this._isActive,
      this._listDrinks);

  List<Drink> get listDrinks => _listDrinks;

  set listDrinks(List<Drink> value) {
    _listDrinks = value;
  }

  bool get isActive => _isActive;

  set isActive(bool value) {
    _isActive = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}