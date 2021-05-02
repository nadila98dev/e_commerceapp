import 'package:e_commerceapp/app/common_widgets/constants.dart';
import 'package:e_commerceapp/app/home/product_page.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final Function onPressed;
  final String ImageUrl;
  final String title;
  final String price;

  ProductCard(
      {this.productId, this.onPressed, this.ImageUrl, this.title, this.price});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductPage(
                      productId: productId,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
        margin: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: [
            Container(
              width: 400.0,
              child: ClipRect(
                child: Image.network(
                  "$ImageUrl",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: Constants.regularHeading),
                    Text(
                      price,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
