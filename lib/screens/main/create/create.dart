import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ocr(),
      child: const Text('OCR'),
    );
  }
}

Future<void> ocr() async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    final File file = File(result.files.single.path.toString());
    final inputImage = InputImage.fromFile(file);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    final String text = recognizedText.text;
    print(text);
    textRecognizer.close();
  }
}
