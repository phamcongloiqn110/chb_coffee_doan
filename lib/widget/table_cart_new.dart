import 'dart:async';

import 'package:bhccoffee/model/DrinkOrderDetail.dart';
import 'package:bhccoffee/model/OrderDetail.dart';
import 'package:bhccoffee/model/Table.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class TableCardNew extends StatefulWidget {

  final TableShop table;

  const TableCardNew({Key key, this.table}) : super(key: key);

  @override
  _TableCardNewState createState() => _TableCardNewState();
}

class _TableCardNewState extends State<TableCardNew> {

  final DatabaseReference Database =  FirebaseDatabase.instance.reference();

  sendData(List<DrinkOrderDetail> orderDetail, TableShop table){
    var detail = [];
    var date = DateTime.now().millisecondsSinceEpoch;
    for( var i = 0 ; i < orderDetail.length ; i++){
      var vl = {
        'food' : orderDetail[i].drink.id,
        'num' : orderDetail[i].quantity,
        'price' : orderDetail[i].priceAfterSale
      };

      detail.add(vl);
    }

    var orderKey = Database.child("orders").push().key;
    Database.child("orders").child(orderKey).set({
      'date'  : date,
      'detail': detail,
      'staff' : null
    });

    var dbRef = Database.child("table").child(widget.table.id).child("order");
    DatabaseReference newChildRef = dbRef.push();
    var key = newChildRef.key;
    dbRef.child(key).set(orderKey);
  }

  Timer _countdownTimer;

  @override
  void initState() {
    _countdownTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (mounted){
        setState(() {

        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderDetail>(
      builder: (context, OrderDetail, child){
        return Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 5.0
              ),
              height: 100.0,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5.0, offset: Offset(0, 3), color: Colors.black12),
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.white
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(top: 20.0, left: 30.0),
                            child: Text(widget.table.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                            alignment: Alignment.topLeft
                        ),
                        Container(
                          child: Text("Bàn trống"),
                        ),
                        SizedBox(height: 8.0,),
                        Container(
                          height: 20.0,
                          width: 200.0,
                          child: FlatButton(
                              onPressed: (){
                                if(OrderDetail.basketDrinkOrderDetail.length == 0){
                                  Fluttertoast.showToast(
                                      msg: "Hãy chọn món trước",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }else{
                                  sendData(OrderDetail.basketDrinkOrderDetail, widget.table);
                                  OrderDetail.basketDrinkOrderDetail.clear();
                                  OrderDetail.totalPrice = 0.0;
                                  Fluttertoast.showToast(
                                      msg: "Đặt món thành công",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }
                              },
                              child: Container(
                                height: 20.0,
                                width: 200.0,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 240),
                                  borderRadius: BorderRadius.circular(35.0),
                                ),
                                child: Center(
                                  child: Text("Chọn chỗ ngồi", style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 260),
                                    fontSize: 14.0,),),
                                ),
                              )
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}