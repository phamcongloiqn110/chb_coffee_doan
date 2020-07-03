class TableShop{
  String _id;
  String _name;
  bool _isActive;
  Map<dynamic, dynamic> _listOrder = {};
  String _status;


  TableShop(this._id, this._name, this._isActive, this._listOrder, this._status);

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

  Map<dynamic, dynamic> get listOrder => _listOrder;

  set listOrder(Map<dynamic, dynamic> value) {
    _listOrder = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }
}
