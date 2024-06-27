import 'package:flutter/material.dart';
import 'dart:io';
import 'package:signature/signature.dart';
import 'package:photo_view/photo_view.dart';

class EditStatusPage extends StatefulWidget {
  final String imagePath;

  const EditStatusPage({Key? key, required this.imagePath}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditStatusPageState createState() => _EditStatusPageState();
}

class _EditStatusPageState extends State<EditStatusPage> {
  final SignatureController _signatureController = SignatureController(penStrokeWidth: 5, penColor: Colors.black);
  bool _isDrawing = false;
  final TextEditingController _textController = TextEditingController();
  bool _isEditingText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Status'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // Save and share the edited status
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          PhotoView(
            imageProvider: FileImage(File(widget.imagePath)),
          ),
          if (_isDrawing)
            Positioned.fill(
              child: Signature(
                controller: _signatureController,
                backgroundColor: Colors.transparent,
              ),
            ),
          if (_isEditingText)
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: TextField(
                controller: _textController,
                autofocus: true,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter text',
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                onSubmitted: (text) {
                  setState(() {
                    _isEditingText = false;
                  });
                },
              ),
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.brush),
            onPressed: () {
              setState(() {
                _isDrawing = !_isDrawing;
              });
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.text_fields),
            onPressed: () {
              setState(() {
                _isEditingText = true;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _signatureController.dispose();
    _textController.dispose();
    super.dispose();
  }
}