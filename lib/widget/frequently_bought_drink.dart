import 'package:bhccoffee/model/Drink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class BoughtDrinks extends StatefulWidget {

  final Drink _drink;

  BoughtDrinks(this._drink);

  @override
  _BoughtDrinksState createState() => _BoughtDrinksState();
}

class _BoughtDrinksState extends State<BoughtDrinks> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Stack(
          children: <Widget>[
            Container(
              height: 275.0,
              width: MediaQuery.of(context).size.width,
              child: Image.network(widget._drink.image, fit: BoxFit.cover),
            ),
            Positioned(
              left: 0.0,
              bottom: 0.0,
              child: Container(
                height: 102.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(0, 0, 0, 100),
                      Color.fromRGBO(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter
                  )
                ),
              ),
            ),
            Positioned(
              left: 10.0,
              bottom: 25.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: 200.0,
                        child: Text(
                          widget._drink.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 170.0,
                    child: Column(
                      children: <Widget>[
                        Text(
                          (FlutterMoneyFormatter(amount: widget._drink.price)
                              .fastCalc(type: FastCalcType.addition, amount: 1.111)
                              .fastCalc(type: FastCalcType.substraction, amount: 2.222)).output.withoutFractionDigits +" VND",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
  }
}
