import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              'Une fruite rouge',
              textAlign: TextAlign.center,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset('images/mlkit_logo.png'),
                ),
                Expanded(
                  flex: 1,
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Label: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: ('null'),
                        ),
                        TextSpan(
                            text: '\n Index: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: ('0'),
                        ),
                        TextSpan(
                            text: '\n Confidence: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: ('0'),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Expanded(
                  flex: 1,
                  child: PhotoButton(
                    iconImage: Icon(Icons.camera),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: PhotoButton(
                    iconImage: Icon(Icons.collections),
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

class PhotoButton extends StatelessWidget {
  final Icon iconImage;

  const PhotoButton({
    required this.iconImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const ShapeDecoration(
        color: Colors.blue,
        shape: CircleBorder(),
      ),
      child: IconButton(
        onPressed: () {},
        icon: iconImage,
        color: Colors.white,
      ),
    );
  }
}
