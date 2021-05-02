import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerceapp/app/home/product_page.dart';
import 'package:e_commerceapp/app/widgets/custom_action_bar.dart';
import 'package:e_commerceapp/services/firestore_service.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirestoreService _firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firestoreService.userRef
                .doc(_firestoreService.getUserId())
                .collection("Cart")
                .get(),
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
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                        productId: document.id,
                                      )));
                        },
                        child: FutureBuilder(
                            future: _firestoreService.productsRef
                                .doc(document.id)
                                .get(),
                            builder: (context, productSnap) {
                              if (productSnap.hasError) {
                                return Container(
                                  child: Center(
                                    child: Text("${productSnap.error}"),
                                  ),
                                );
                              }
                              if (productSnap.connectionState ==
                                  ConnectionState.done) {
                                Map _productMap = productSnap.data.data();
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                    horizontal: 24.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 90,
                                        child: ClipRect(
                                          child: Image.network(
                                            "${_productMap['images'][0]}",
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: 16.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${_productMap['name']}",
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: Text(
                                                "\$${_productMap['price']}",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Text(
                                              "Size: ${document.data()['size']}",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }));
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
          ),
        ],
      ),
    );
  }
}
