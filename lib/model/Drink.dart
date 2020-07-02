class Drink{
  String _id;
  String _name;
  String _description;
  String _image;
  bool _isActive;
  bool _isSale;
  double _price;
  int _sale;

  Drink(this._id, this._name, this._description, this._image, this._isActive,
      this._isSale, this._price, this._sale);

  int get sale => _sale;

  set sale(int value) {
    _sale = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  bool get isSale => _isSale;

  set isSale(bool value) {
    _isSale = value;
  }

  bool get isActive => _isActive;

  set isActive(bool value) {
    _isActive = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
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

  double totalDrink(){
    if(this.isSale){
      return price*sale/100;
    }
    return price;
  }

  double priceSale(){
    if(this.isSale){
      return price * (100-sale)/100;
    }
    else
      return price;
  }
//  Drink.map(dynamic obj){
//    this._id = obj['id'];
//    this._name = obj['name'];
//    this._description = obj['description'];
//    this._image = obj['image'];
//    this._isActive = obj['isActive'];
//    this._isSale = obj['isSale'];
//    this._price = obj['price'];
//    this._sale = obj['sale'];
//  }
//
//  Map<String, dynamic> toMap() {
//    var map = new Map<String, dynamic>();
//    if (_id != null) {
//      map['id'] = _id;
//    }
//    map['image'] = _image;
//    map['name'] = _name;
//    map['description'] = _description;
//    map['price'] = _price;
//    map['sale'] = _sale;
//
//    return map;
//  }
//
//  Drink.fromMap(Map<String, dynamic> map) {
//    this._id = map['id'];
//    this.name = map ['name'];
//    this.image = map['image'];
//    this._description = map['description'];
//    this._price = map['price'];
//    this._sale = map['sale'];
//  }

}