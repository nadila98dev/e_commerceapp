import 'package:e_commerceapp/app/home/product_details.dart';
import 'package:flutter/material.dart';

class Productss extends StatefulWidget {
  @override
  _ProductssState createState() => _ProductssState();
}

class _ProductssState extends State<Productss> {
  var product_list = [
    {
      "name": "Abbie Oversize",
      "picture": "images/products/abbie.png",
      "old_price": 100,
      "price": 50,
    },
    {
      "name": "Harriet Tier",
      "picture": "images/products/harriet.jpg",
      "old_price": 150,
      "price": 50,
    },
    {
      "name": "Leona Top",
      "picture": "images/products/leona.jpg",
      "old_price": 150,
      "price": 50,
    },
    {
      "name": "Leona Top",
      "picture": "images/products/leona.jpg",
      "old_price": 150,
      "price": 50,
    },
    {
      "name": "Leona Top",
      "picture": "images/products/leona.jpg",
      "old_price": 150,
      "price": 50,
    },
    {
      "name": "Leona Top",
      "picture": "images/products/leona.jpg",
      "old_price": 150,
      "price": 50,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Single_prod(
            prod_name: product_list[index]['name'],
            prod_pricture: product_list[index]['picture'],
            prod_old_price: product_list[index]['old_price'],
            prod_price: product_list[index]['price'],
          );
        });
  }
}

class Single_prod extends StatelessWidget {
  Single_prod(
      {this.prod_name,
      this.prod_pricture,
      this.prod_old_price,
      this.prod_price});
  final prod_name;
  final prod_pricture;
  final prod_old_price;
  final prod_price;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: Text("Hero 1"),
        child: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => new ProductDetails(
                      product_detail_name: prod_name,
                      product_detail_price: prod_price,
                      product_detail_old_price: prod_old_price,
                      product_detail_picture: prod_pricture,
                    ))),
            child: GridTile(
              footer: Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          prod_name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                      ),
                      Text(
                        "\$${prod_price}",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      )
                    ],
                  )),
              child: Image.asset(
                prod_pricture,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
