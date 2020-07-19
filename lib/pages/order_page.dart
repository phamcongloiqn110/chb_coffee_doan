import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../model/OrderDetail.dart';
import '../widget/notfound.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'table_page.dart';


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
                  if(OrderDetail.basketDrinkOrderDetail[index].drink.isSale){
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
                                                msg: "Số lượng đặt không vượt quá 99",
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
                                            OrderDetail.tongGia(OrderDetail.totalPriceAfterSale + OrderDetail.basketDrinkOrderDetail[index].drink.totalDrink());
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
                                                msg: "Số lượng đặt không nhỏ hơn 1",
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
                                            OrderDetail.tongGia(OrderDetail.totalPriceAfterSale - OrderDetail.basketDrinkOrderDetail[index].drink.totalDrink());
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
                                  "Giá gốc: \$"+ OrderDetail.basketDrinkOrderDetail[index].drink.price.toString() ,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: 2 ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  "Giá sale: "+ OrderDetail.basketDrinkOrderDetail[index].priceAfterSale.toString()+" VND",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.lightBlue,
                                      fontWeight: FontWeight.w700),
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
                  }
                  else{
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
                                                msg: "Số lượng đặt không vượt quá 99",
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
                                            OrderDetail.tongGia(OrderDetail.totalPriceAfterSale + OrderDetail.basketDrinkOrderDetail[index].drink.totalDrink());
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
                                                msg: "Số lượng đặt không nhỏ hơn 1",
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
                                            OrderDetail.tongGia(OrderDetail.totalPriceAfterSale - OrderDetail.basketDrinkOrderDetail[index].drink.totalDrink());
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
                                  "Giá: "+ OrderDetail.basketDrinkOrderDetail[index].drink.price.toString()+" VND",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.lightBlue,
                                      fontWeight: FontWeight.bold ),
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
                  }
              }),
          bottomNavigationBar: Container(
            height: 155.0,
            padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                top: 5.0
            ),
            child: Column(
              children: <Widget>[
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
                      "Tổng tiền",
                      style: TextStyle(
                          color: Color(0xFF9BA7C6),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                       "${OrderDetail.totalPriceAfterSale} VND",
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
                  onTap: OrderDetail.basketDrinkOrderDetail.length !=0 ? () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context){
                        return Scaffold(
                          appBar: AppBar(
                            title: Text("Chọn bàn", style: TextStyle(
                                color: Colors.black
                            ),),
                            backgroundColor: Colors.white10,
                            elevation: 0,
                            centerTitle: true,
                          ),
                          body: TablePage(),
                        );
                      },
                    ));
                  } : null,
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: Center(
                      child: Text(
                        "Đặt chỗ",
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

