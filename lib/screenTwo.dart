
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class SecondScreen extends StatefulWidget {
  final String helloValue;

  SecondScreen({required this.helloValue});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int _clickCount = 0;

  void _saveImage() async {
    setState(() {
      _clickCount++; // Increment click count
    });

    final directory = await getTemporaryDirectory();
    String filePath = '${directory.path}/$_clickCount.jpg';

    String assetPath = 'assets/images/oregon.jpg'; //place where the asset is

    // Load the image as bytes
    ByteData bytes = await rootBundle.load(assetPath);
    Uint8List imageData = bytes.buffer.asUint8List();

    final result = await ImageGallerySaver.saveImage( //save to gallery
      imageData,
      name: filePath,
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Image saved at: $filePath"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Screen'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Hello, ${widget.helloValue}', // Display the value from the parent screen
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/oregon.jpg',
              height: 200,
              scale: 2.5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveImage,
              child: Text('Download'),
            ),
          ],
        ),
      ),
    );
  }
}
