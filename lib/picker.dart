import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final String? enteredName;
  final String? enteredDesc;
  final String? enteredEmail;

  const InputText({Key? key, this.enteredName, this.enteredDesc, this.enteredEmail}) : super(key: key);

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();  //init state
    // Initialize the text controllers with provided data if any
    _nameController.text = widget.enteredName ?? '';
    _descriptionController.text = widget.enteredDesc ?? '';
    _emailController.text = widget.enteredEmail ?? '';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text('State Management'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // First Text Field for Name
              TextFormField(
                controller: _nameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Enter Name',
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Second Text Field for Description
              TextFormField(
                controller: _descriptionController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Enter Description',
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Third Text Field for Email
              TextFormField(
                controller: _emailController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Enter Email',
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
  Map<String, String> getEnteredText() {
    return {
      'name': _nameController.text, // the text controllers willl have the entered text and it can be accessed by using the .text property, This basically listens when the state is resumed and stops when its paused
      'description': _descriptionController.text,
      'email': _emailController.text,
    };
  }
  @override
  void dispose() {
    // Clean up the text controllers when the widget is disposed
    _nameController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
