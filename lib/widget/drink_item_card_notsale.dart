import '../model/DrinkOrderDetail.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../model/Drink.dart';
import '../model/OrderDetail.dart';

class DrinkItemCardNotSale extends StatefulWidget {

  final Drink _drink;

  DrinkItemCardNotSale(this._drink);

  @override
  _DrinkItemCardNotSaleState createState() => _DrinkItemCardNotSaleState();
}

class _DrinkItemCardNotSaleState extends State<DrinkItemCardNotSale> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderDetail>(
      builder: (context, OrderDetail, child){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          padding: EdgeInsets.all(5.0),
          width: 500.0,
          height: 125.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 5.0, offset: Offset(0, 3), color: Colors.black12),
            ],
          ),
          child: Container(
            width: 450.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget._drink.image),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10.0)),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 190.0,
                        child: Text(
                          widget._drink.name,
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                          softWrap: true,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        width: 190.0,
                        child: Text(widget._drink.description),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        width: 190.0,
                        child: Text(
                          widget._drink.price.toString()+" VND",
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.lightBlue),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.black,
                    onPressed: (){
                      var isHaveDrink = 0;
                      for(var i = 0; i<OrderDetail.count;i++){
                        if(OrderDetail.basketDrinkOrderDetail[i].drink.id == widget._drink.id){
                          OrderDetail.basketDrinkOrderDetail[i].quantity += 1;
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
                        OrderDetail.addDrink(new DrinkOrderDetail(widget._drink, 1));
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
        );
      },
    );
  }
}


