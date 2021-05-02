import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerceapp/app/common_widgets/constants.dart';
import 'package:e_commerceapp/app/widgets/custom_action_bar.dart';
import 'package:e_commerceapp/app/widgets/image_swipe.dart';
import 'package:e_commerceapp/app/widgets/product_size.dart';
import 'package:e_commerceapp/services/firestore_service.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  ProductPage({this.productId});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirestoreService _firestoreService = FirestoreService();
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection('Products');

  String _selectedProductSize = "XS";

  Future _addToCart() {
    return _firestoreService.userRef
        .doc(_firestoreService.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  Future _addToSaved() {
    return _firestoreService.userRef
        .doc(_firestoreService.getUserId())
        .collection("Saved")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  final SnackBar _snackBar =
      SnackBar(content: Text('Product added to the cart'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
      ),
      body: Stack(
        children: [
          FutureBuilder(
              future: _productsRef.doc(widget.productId).get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> documentData = snapshot.data.data();

                  List imageList = documentData['images'];
                  List productSize = documentData['size'];

                  _selectedProductSize = productSize[0];

                  return ListView(
                    children: [
                      ImageSwipe(
                        ImageList: imageList,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 24.0, left: 24.0, right: 24.0, bottom: 4.0),
                        child: Text(
                          "${documentData['name']}" ?? 'Product Name',
                          style: Constants.boldHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 24.0),
                        child: Text(
                          "\$${documentData['price']}" ?? 'Price',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 24.0),
                        child: Text(
                          "${documentData['description']}" ?? 'Description',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 24.0),
                        child: Text(
                          'Select size',
                          style: Constants.regularHeading,
                        ),
                      ),
                      ProductSize(
                        productSizes: productSize,
                        onSelected: (size) {
                          _selectedProductSize = size;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await _addToSaved();
                                Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                width: 65.0,
                                height: 65.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFDCDCDC),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                alignment: Alignment.center,
                                child: Image(
                                  image: AssetImage("images/tab_saved.png"),
                                  height: 22.0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  _addToCart();
                                  Scaffold.of(context).showSnackBar(_snackBar);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 16.0),
                                  height: 65.0,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor,
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Add to Cart",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
          CustomActionBar(
            hasTitle: false,
            hasBackground: false,
          )
        ],
      ),
    );
  }
}
