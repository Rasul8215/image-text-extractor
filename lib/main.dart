import 'package:flutter/material.dart';
import 'package:image_text_extractor/components/image_picker.dart';

void main() {
  runApp(const ImageExtractor());
}

class ImageExtractor extends StatefulWidget {
  const ImageExtractor({super.key});

  @override
  State<ImageExtractor> createState() => _ImageExtractorState();
}

class _ImageExtractorState extends State<ImageExtractor> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ImageExtractorHomePage(),
    );
  }
}