import 'Drink.dart';

class DrinkOrderDetail {
  Drink _drink;
  int _quantity;
  double _priceAfterSale;

  Drink get drink => _drink;

  int get quantity => _quantity;

  double get priceAfterSale {
    if(_drink.isSale){
      _priceAfterSale = (_drink.price * 1 * _drink.sale)/100;
    }
    else
      _priceAfterSale = _drink.price * 1;
    return _priceAfterSale;
  }

  DrinkOrderDetail(this._drink, this._quantity){
    if(_drink.isSale){
      this._priceAfterSale = (_drink.price *_quantity * (100-_drink.sale))/100;
    }
    else
      this._priceAfterSale = _drink.price * _quantity;
  }

  set quantity(int value) {
    _quantity = value;
  }
}