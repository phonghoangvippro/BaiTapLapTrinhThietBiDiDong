import 'package:flutter/material.dart';

class TextDetail extends StatelessWidget {
  const TextDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Text Detail',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // hàng 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'The',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(width: 10),
                    Text(
                      'quick',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),

                    SizedBox(width: 10),
                    Text(
                      'Brown',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.yellow[800],
                      ),
                    ),
                  ],
                ),

                // hàng 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'fox',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'jumps',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        letterSpacing: 5,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'over',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // Hàng 3
                Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'the',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'lazy',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'dog',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}