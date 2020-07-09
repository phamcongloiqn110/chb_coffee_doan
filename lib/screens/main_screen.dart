import '../pages/order_page.dart';
import '../pages/table_page.dart';
import '../pages/menu_page.dart';
import '../pages/home_page.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentTapIndex = 0;
  int currentTab = 0;

  List<Widget> pages;
  Widget currentPage;

  HomePage homePage;
  MenuPage menuPage;
  OrderPage orderPage;
  TablePage tablePage;

  @override
  void initState() {
    super.initState();
    homePage = HomePage();
    menuPage = MenuPage();
    orderPage = OrderPage();
    tablePage = TablePage();

    pages = [homePage, menuPage, orderPage, tablePage];
    currentPage = homePage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          currentTab == 0
              ? "Trang chủ"
              : currentTab == 1
              ? "Menu"
              : currentTab == 2 ? "Giỏ hàng" : "Bàn",
          style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (int index){
          setState(() {
            currentTab = index;
            currentPage = pages[index];
          });
        },
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Trang chủ")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              title: Text("Menu")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text("Giỏ hàng")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.table_chart),
              title: Text("Bàn")
          )
        ]
      ),
      body: currentPage,
    );
  }
}
