import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../model/OrderDetail.dart';
import '../widget/notfound.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderDetail>(
      builder: (context, OrderDetail, child) {
        return Scaffold(
          body: OrderDetail.basketDrinkOrderDetail.length == 0
              ? NotFound()
              : ListView.builder(
              itemCount: OrderDetail.basketDrinkOrderDetail.length,
              itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFD3D3D3), width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            width: 45.0,
                            height: 73.0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                children: <Widget>[
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(OrderDetail.basketDrinkOrderDetail[index].quantity>98){
                                          Fluttertoast.showToast(
                                              msg: "Invalid order quantity",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.grey,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }else{
                                          OrderDetail.basketDrinkOrderDetail[index].quantity++;
                                          OrderDetail.basketDrinkOrderDetail[index].priceAfterSale;
                                          OrderDetail.tongGia(OrderDetail.totalPrice + OrderDetail.basketDrinkOrderDetail[index].drink.totalDrink());
                                        }
                                      });
                                    },
                                    child: Icon(Icons.keyboard_arrow_up,
                                        color: Color(0xFFD3D3D3)),
                                  ),
                                  Text(
                                    '${OrderDetail.basketDrinkOrderDetail[index].quantity}',
                                    style: TextStyle(fontSize: 15.0, color: Colors.grey),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if(OrderDetail.basketDrinkOrderDetail[index].quantity<2){
                                          Fluttertoast.showToast(
                                              msg: "Invalid order quantity",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.grey,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }else{
                                          OrderDetail.basketDrinkOrderDetail[index].quantity--;
                                          OrderDetail.basketDrinkOrderDetail[index].priceAfterSale;
                                          OrderDetail.tongGia(OrderDetail.totalPrice - OrderDetail.basketDrinkOrderDetail[index].drink.totalDrink());
                                        }
                                      });
                                    },
                                    child: Icon(Icons.keyboard_arrow_down,
                                        color: Color(0xFFD3D3D3)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Container(
                            height: 70.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(OrderDetail.basketDrinkOrderDetail[index].drink.image),
                                    fit: BoxFit.cover
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 5.0,
                                      offset: Offset(0.0, 2.0)
                                  )
                                ]),
                          ),
                          SizedBox(width: 20.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 175.0,
                                child: Text(
                                  OrderDetail.basketDrinkOrderDetail[index].drink.name,
                                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                  softWrap: true,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              SizedBox(height: 5.0),
                              Text(
                                "Price: \$ "+ OrderDetail.basketDrinkOrderDetail[index].drink.price.toString() ,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                "Sale: "+ OrderDetail.basketDrinkOrderDetail[index].drink.sale.toString(),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: GestureDetector(
                              onTap: (){
                                OrderDetail.removeDrink(OrderDetail.basketDrinkOrderDetail[index]);
                              },
                              child: Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
              }),
          bottomNavigationBar: Container(
          height: 220.0,
          padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 5.0
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Subtotal",
                    style: TextStyle(
                        color: Color(0xFF9BA7C6),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$ ${OrderDetail.totalPrice}",
                    style: TextStyle(
                        color: Color(0xFF9BA7C6),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Price after discount",
                    style: TextStyle(
                        color: Color(0xFF9BA7C6),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$ ${OrderDetail.totalPrice}",
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(
                height: 3.0,
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Cart Total",
                    style: TextStyle(
                        color: Color(0xFF9BA7C6),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$ ${OrderDetail.totalPrice}",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                },
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: Center(
                    child: Text(
                      "Proceed to Order",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
          ),
        );
      }
    );
  }
}

