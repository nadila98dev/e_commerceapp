import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerceapp/app/widgets/custom_action_bar.dart';
import 'package:e_commerceapp/app/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection('Products');
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }
              // Collection Data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  padding: EdgeInsets.only(top: 108.9, bottom: 12.0),
                  children: snapshot.data.docs.map((document) {
                    return ProductCard(
                      title: document.data()['name'],
                      ImageUrl: document.data()['images'][0],
                      price: "\$${document.data()['price']}",
                      productId: document.id,
                    );
                  }).toList(),
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            hasTitle: false,
            hasBackground: false,
          ),
        ],
      ),
    );
  }
}
