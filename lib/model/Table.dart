class TableShop{
  String _id;
  String _name;
  bool _isActive;


  TableShop(this._id, this._name, this._isActive);

  bool get isActive => _isActive;

  set isActive(bool value) {
    _isActive = value;
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
