import '../model/DrinkOrderDetail.dart';
import '../model/OrderDetail.dart';
import '../model/Table.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class TableCardOrderedPending extends StatefulWidget {

  final TableShop table;

  const TableCardOrderedPending({Key key, this.table}) : super(key: key);

  @override
  _TableCardOrderedPendingState createState() => _TableCardOrderedPendingState();
}

class _TableCardOrderedPendingState extends State<TableCardOrderedPending> {

  final DatabaseReference Database =  FirebaseDatabase.instance.reference();
  sendData(List<DrinkOrderDetail> orderDetail, TableShop table){
    var detail = [];
    var date = DateTime.now().millisecondsSinceEpoch ~/ 1000;
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
      'staff' : null,
      'status': 'pending'
    });



    final List<DrinkOrderDetail> listDrinkOrderDetail = [];

    for(var i=0; i<orderKey.length;i++){
      Database.child("orders")..onValue.listen((event) {
        DataSnapshot snapshot = event.snapshot;

        var KEYS = snapshot.value.keys;
        var DATA = snapshot.value;

        listDrinkOrderDetail.clear();

        for (var individualKey in KEYS) {
          DrinkOrderDetail drink = DrinkOrderDetail(
            DATA[individualKey]['food'],
            DATA[individualKey]['num']
          );
          listDrinkOrderDetail.add(drink);
        }
        setState(() {
          print('Length: $listDrinkOrderDetail.length');
        });
      });
    }

    var dbRefTable = Database.child("table").child(widget.table.id);
    var dbRefTableOrder = dbRefTable.child("orders");
    DatabaseReference newChildRef = dbRefTableOrder.push();
    var key = newChildRef.key;
    dbRefTableOrder.child(key).set(
        orderKey);
    dbRefTable.child("status").set('pending');
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
                      color: Colors.orange,
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
                          child: Text("Bàn đang chờ món"),
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
                                      fontSize: 16.0);
                                }
                              },
                              child: Container(
                                height: 20.0,
                                width: 150.0,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 240),
                                  borderRadius: BorderRadius.circular(35.0),
                                ),
                                child: Center(
                                  child: Text("Đặt thêm món", style: TextStyle(
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


