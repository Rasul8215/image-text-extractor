

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ImageExtractorHomePage extends StatefulWidget {
  const ImageExtractorHomePage({super.key});

  @override
  State<ImageExtractorHomePage> createState() => _ImageExtractorHomePageState();
}

class _ImageExtractorHomePageState extends State<ImageExtractorHomePage> {
  String? selectedImagePath;
  String? processedText;

  Future processText() async {
    TextRecognizer recogniceText = TextRecognizer();
    RecognizedText recognizedText = await recogniceText.processImage(
      InputImage.fromFilePath(selectedImagePath.toString())
    );
    String text = recognizedText.text;
    String singleLineText = text.toString().replaceAll('\n', ' ').replaceAll('\t', ' ');
    setState(() {
      processedText = singleLineText;
    });
  }

  Future getImageFromcamera() async {
    setState(() {
      processedText = null;
      selectedImagePath= null;
    });
    ImagePicker pickImage = ImagePicker();
    XFile? pickedImagePath = await pickImage.pickImage(source: ImageSource.camera);
    setState(() {
      selectedImagePath = pickedImagePath!.path;
    });
    processText();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Image Text Extractor"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () => getImageFromcamera(),
                  icon: const  Icon(Icons.camera),
                  label: const Text("choose image")
                ),
                const SizedBox(height: 20,),
                LayoutBuilder(
                  builder: (context, constraints) {
                  Orientation orientation = MediaQuery.of(context).orientation;
                  double height = orientation == Orientation.portrait ? 300 : 150;
                  return Container(
                    width: double.infinity,
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16)
                      ),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0
                      )
                    ),
                    margin: const EdgeInsets.all(5),
                    child: Center(child: selectedImagePath != null ?
                      Image.file(File(selectedImagePath.toString()),
                      fit: BoxFit.cover,
                      )
                    : const Text("Please choose image")),
                  );
                },),
                const SizedBox(height: 20,),
                if(processedText != null)
                  SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16)
                        ),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0
                        )
                      ),
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(16),
                      child: processedText != null ?
                      Text(processedText!) :
                      const Center(child: Text("Please choose image")),
                    ),
                  )
              ],
            ),
          ),
        ),
      )
    );
  }
}