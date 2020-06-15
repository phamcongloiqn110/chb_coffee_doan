import 'package:bhccoffee/model/OrderDetail.dart';

class Order{
  String _id;
  DateTime _date;
  OrderDetail _orderDetail;

  Order(this._id, this._date, this._orderDetail);

  OrderDetail get orderDetail => _orderDetail;

  set orderDetail(OrderDetail value) {
    _orderDetail = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}