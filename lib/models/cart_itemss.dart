import 'package:flutter/material.dart';

class CardItemss extends StatefulWidget {
  @override
  _CardItemssState createState() => _CardItemssState();
}

class _CardItemssState extends State<CardItemss> {
  var products_on_the_cart = [
    {
      "name": "Abbie Oversize",
      "picture": "images/products/abbie.png",
      "old_price": 100,
      "price": 50,
      "size": "XL",
      "color": "Red",
      "quantity": 1,
    },
    {
      "name": "Harriet Tier",
      "picture": "images/products/harriet.jpg",
      "old_price": 150,
      "price": 50,
      "size": "XS",
      "color": "Blue",
      "quantity": 1,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products_on_the_cart.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
            cart_prod_name: products_on_the_cart[index]['name'],
            cart_prod_pricture: products_on_the_cart[index]['picture'],
            cart_prod_price: products_on_the_cart[index]['price'],
            cart_prod_color: products_on_the_cart[index]['color'],
            cart_prod_size: products_on_the_cart[index]['size'],
            cart_prod_qty: products_on_the_cart[index]['quantity'],
          );
        });
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_pricture;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_qty;

  Single_cart_product(
      {this.cart_prod_name,
      this.cart_prod_pricture,
      this.cart_prod_price,
      this.cart_prod_size,
      this.cart_prod_color,
      this.cart_prod_qty});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          cart_prod_pricture,
          width: 80.0,
          height: 80.0,
        ),
        title: Text(cart_prod_name),
        subtitle: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Size:"),
                ),
                Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      cart_prod_size,
                      style: TextStyle(color: Colors.red),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                  child: Text("Color:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    cart_prod_color,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text("\$${cart_prod_price}",
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            )
          ],
        ),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Column(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_drop_up, color: Colors.red),
                  iconSize: 50,
                  onPressed: () {}),
              Text(
                '$cart_prod_qty',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              IconButton(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.red,
                  ),
                  iconSize: 50,
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
