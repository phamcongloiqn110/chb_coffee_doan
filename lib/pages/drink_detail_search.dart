import '../model/Drink.dart';
import '../model/DrinkOrderDetail.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../model/OrderDetail.dart';

class DrinkDetailsSearch extends StatefulWidget {

  final Drink _drink;

  DrinkDetailsSearch(this._drink);

  @override
  _DrinkDetailsSearchState createState() => _DrinkDetailsSearchState();
}

class _DrinkDetailsSearchState extends State<DrinkDetailsSearch> {

  var _mediumSpace = SizedBox(
    height: 10.0,
  );

  var _smallSpace = SizedBox(
    height: 5.0,
  );

  int countNum = 1;

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderDetail>(
      builder: (context, OrderDetail, child){
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1000.0,
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 300.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget._drink.image),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  _mediumSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 250.0,
                        child: Text(
                          widget._drink.name,
                          style: TextStyle(fontSize: 18.0, color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        widget._drink.price.toString()+" VND",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  _mediumSpace,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Mô tả:",
                      style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _smallSpace,
                  Text(
                    widget._drink.description,
                    textAlign: TextAlign.justify,
                  ),
                  _smallSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(icon: Icon(
                          Icons.remove_circle),
                          onPressed: (){
                            setState(() {
                              if(countNum<2){
                                countNum = 1;
                                Fluttertoast.showToast(
                                    msg: "Số lượng đặt không nhỏ hơn 1",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }else{
                                countNum--;
                              }
                            });
                          }),
                      SizedBox(width: 15.0,),
                      Text('$countNum', style: TextStyle(fontSize: 16.0,),),
                      SizedBox(width: 15.0,),
                      IconButton(icon: Icon(
                          Icons.add_circle),
                          onPressed: (){
                            setState(() {
                              if(countNum>98){
                                countNum = 99;
                                Fluttertoast.showToast(
                                    msg: "Số lượng đặt không lớn hơn 99",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }else{
                                countNum++;
                              }
                            });
                          }),
                    ],
                  ),
                  _smallSpace,
                  Center(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      padding: const EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                        ),
                        child: Container(
                          constraints: const BoxConstraints(minWidth: 88.0, minHeight: 45.0), // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: const Text(
                            'Thêm vào giỏ hàng',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      onPressed: (){
                        var isHaveDrink = 0;
                        for(var i = 0; i<OrderDetail.count;i++){
                          if(OrderDetail.basketDrinkOrderDetail[i].drink.id == widget._drink.id){
                            OrderDetail.basketDrinkOrderDetail[i].quantity += int.parse('$countNum');
                            OrderDetail.basketDrinkOrderDetail[i].priceAfterSale;
                            OrderDetail.tongGia(OrderDetail.totalPriceAfterSale + OrderDetail.basketDrinkOrderDetail[i].drink.totalDrink());
                            isHaveDrink = 1;
                            Fluttertoast.showToast(
                                msg: "Đã thêm sản phẩm vào giỏ hàng",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            break;
                          }
                        }
                        if(isHaveDrink == 0){
                          OrderDetail.addDrink(new DrinkOrderDetail(widget._drink, int.parse('$countNum')));
                          Fluttertoast.showToast(
                              msg: "Đã thêm sản phẩm vào giỏ hàng",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}