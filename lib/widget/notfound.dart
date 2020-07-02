import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset("images/oops.png", width: 250, height: 250,),
            Text("Rất tiếc, không tìm thấy sản phẩm nào",
              style: TextStyle(fontSize: 20.0),)
          ],
        ),
      ),
    );
  }
}
