import 'package:e_commerceapp/models/cart.dart';
import 'package:e_commerceapp/models/cart_itemss.dart';
import 'package:e_commerceapp/models/productss.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Productss> _cartList = List<Productss>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.1,
        backgroundColor: Colors.blue[700],
        title: Text('Cart'),
      ),
      body: CardItemss(),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text("Total:"),
                subtitle: Text('\$230'),
              ),
            ),
            Expanded(
                child: MaterialButton(
              height: 70.0,
              onPressed: () {},
              child: Text(
                'Check out',
                style: TextStyle(color: Colors.white, fontSize: 19.0),
              ),
              color: Colors.blue[700],
            ))
          ],
        ),
      ),
    );
  }
}
