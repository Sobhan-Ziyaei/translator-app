import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator_app/api/translation_api.dart';
import 'package:translator_app/gen/assets.gen.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool textScanning = false;
  String scannedText = '';
  String translatedText = '';
  XFile? imageFile;
  static final Map<String, String> word = {};
  bool isTranslating = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.mic),
        onPressed: () {},
      ),
      body: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        elevation: 20,
        margin: const EdgeInsets.all(8),
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 5),
                Text(
                  "تشخیص متن" " (OCR)",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                imageFile == null
                    ? Text(
                        'با استفاده از این تکنولوژی می‌توانید به راحتی لغات موجود درون تصاویر را با دوربین موبایل خود اسکن کرده و آن‌ها را ترجمه کنید و یا در نرم‌افزارهای دیگر استفاده نمایید',
                        style: theme.textTheme.bodySmall,
                      )
                    : const SizedBox(height: 1),
                imageFile == null
                    ? const SizedBox(height: 5)
                    : const SizedBox(height: 0),
                imageFile == null
                    ? Assets.images.scanning.image(width: 200, height: 200)
                    : Image.file(
                        File(imageFile!.path),
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                      ),
                textScanning == null
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        height: imageFile == null ? 100 : 175,
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          elevation: 20,
                          margin: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                scannedText,
                                maxLines: 9,
                                style: theme.textTheme.bodySmall,
                              ),
                              Text(
                                translatedText,
                                maxLines: 9,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: MaterialButton(
                          onPressed: () {
                            getImage(ImageSource.camera);
                          },
                          color: Colors.blue,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.camera, color: Colors.white),
                              const SizedBox(width: 15),
                              Text(
                                'اسکن از دوربین',
                                style: theme.textTheme.titleSmall,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: MaterialButton(
                          onPressed: () {
                            getImage(ImageSource.gallery);
                          },
                          color: Colors.blue,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.image, color: Colors.white),
                              const SizedBox(width: 15),
                              Text(
                                'اسکن از گالری',
                                style: theme.textTheme.titleSmall,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          textScanning = true;
          imageFile = pickedImage;
        });

        getRecognisedText(pickedImage);
      }
    } catch (ex) {
      setState(() {
        textScanning = false;
        imageFile = null;
        scannedText = 'Error While Scanning';
      });
    }
  }

  Future<void> getRecognisedText(XFile image) async {
    word.clear();
    scannedText = '';
    translatedText = '';
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        word.addAll({line.text: 'none'});
        scannedText = '$scannedText${line.text}\n';
      }
    }
    print(word);
    textScanning = false;
    setState(() {});
    translatedFunc();
  }

  Future<void> translatedFunc() async {
    setState(() {
      isTranslating = true;
    });
    for (var wordKey in word.keys) {
      final wordTranslated =
          await TranslationApi.translate(wordKey, 'en', 'fa');
      print(wordTranslated);
      word.update(wordKey, (value) => wordTranslated);
    }
    print(word);

    for (var wordValue in word.values) {
      print(wordValue);
      translatedText = "$translatedText$wordValue\n";
    }
    isTranslating = false;
    setState(() {});
  }
}
