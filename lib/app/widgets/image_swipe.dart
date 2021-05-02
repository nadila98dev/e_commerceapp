import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  final List ImageList;

  ImageSwipe({this.ImageList});

  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int _selectRange = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600.0,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (num) {
              setState(() {
                _selectRange = num;
              });
            },
            children: [
              for (var i = 0; i < widget.ImageList.length; i++)
                Container(
                    child: Image.network(
                  "${widget.ImageList[i]}",
                  fit: BoxFit.cover,
                ))
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.ImageList.length; i++)
                  AnimatedContainer(
                    duration: Duration(microseconds: 300),
                    curve: Curves.easeOutCubic,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      width: _selectRange == i ? 25.0 : 12.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12.0)),
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
