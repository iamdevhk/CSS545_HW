import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'screenTwo.dart';



class ImagePickerDisplay extends StatefulWidget {
  final String? enteredName;

  const ImagePickerDisplay({Key? key, this.enteredName}) : super(key: key);

  @override
  State<ImagePickerDisplay> createState() => _ImagePickerDisplayState();
}

class _ImagePickerDisplayState extends State<ImagePickerDisplay> {
  final ImagePicker picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();

  File? image;
  File? imageTemp;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.enteredName ?? '';
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        imageTemp = File(image.path);
        setState(() {
          debugPrint('$imageTemp');
        });
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text('Image from Gallery'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Image Picked From Gallery',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            imageTemp != null
                ? Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.file(
                imageTemp!,
                fit: BoxFit.cover,
              ),
            )
                : const Text(' No Image Preview'),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('Select Image'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToNextScreen(context); //on press call nextscreen
              },
              child: const Text('Download Image'),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _nameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Enter Name',
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  //function to call next screen
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondScreen(helloValue: _nameController.text)));
  }
}
