import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:translator_app/api/translation_api.dart';
import 'package:translator_app/api/translations.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class FirstScreen extends StatefulWidget {
  FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  TextEditingController _controller = TextEditingController();
  List<String> source = [
    'انگلیسی',
    'اسپانیایی',
    'فرانسوی',
    'آلمانی',
    'ایتالیایی',
    'روسی',
    'فارسی',
  ];
  List<String> destination = [
    'فارسی',
    'روسی',
    'ایتالیایی',
    'آلمانی',
    'فرانسوی',
    'اسپانیایی',
    'انگلیسی',
  ];
  String selectedSource = 'انگلیسی';
  String selectedDestination = 'فارسی';
  String language1 = Translations.languageList.first;

  String language2 = Translations.languageList.last;

  String resultValue = '';

  TextToSpeech tts = TextToSpeech();

  stt.SpeechToText speech = stt.SpeechToText();
  bool _isListening = false;

  String text = '';

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Colors.blue,
        endRadius: 40,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_off_outlined),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            elevation: 20,
            margin: const EdgeInsets.all(8),
            child: Container(
              margin: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('زبان مبدا', style: theme.textTheme.bodySmall),
                      Text('زبان مقصد', style: theme.textTheme.bodySmall),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // for destination
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 80,
                        height: 48,
                        margin: const EdgeInsets.all(16),
                        child: DropdownButtonFormField<String>(
                          style: theme.textTheme.bodySmall,
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.white),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.white),
                            ),
                            fillColor: Colors.grey[200],
                          ),
                          value: selectedDestination,
                          items: destination
                              .map(
                                (item) => DropdownMenuItem<String>(
                                  value: item,
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Text(
                                    item,
                                    style: theme.textTheme.bodySmall,
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (item) {
                            setState(() {
                              selectedDestination = item!;
                              String? res = Translations.languageMap[item];
                              language1 = res!;
                              print(language1);
                            });
                          },
                        ),
                      ),
                      //for destination
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 80,
                        height: 48,
                        margin: const EdgeInsets.all(16),
                        child: DropdownButtonFormField<String>(
                          style: theme.textTheme.bodySmall,
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.white),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.white),
                            ),
                            fillColor: Colors.grey[200],
                          ),
                          value: selectedSource,
                          items: destination
                              .map(
                                (item) => DropdownMenuItem<String>(
                                  value: item,
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Text(
                                    item,
                                    style: theme.textTheme.bodySmall,
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (item) {
                            setState(() {
                              selectedSource = item!;
                              String? res = Translations.languageMap[item];
                              language2 = res!;
                              print(language2);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: SizedBox(
                      width: 400,
                      height: 140,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 16, right: 16, left: 16),
                        child: TextField(
                          style: theme.textTheme.bodyMedium,
                          controller: _controller,
                          keyboardType: TextInputType.multiline,
                          autofocus: false,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            labelStyle: theme.textTheme.bodySmall,
                            hintStyle: theme.textTheme.bodySmall?.copyWith(
                                color:
                                    const Color.fromARGB(255, 131, 128, 128)),
                            hintText: 'متن خود را وارد نمایید',
                            icon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _controller.text = '';
                                  },
                                  child: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                InkWell(
                                  onTap: () {
                                    String text = _controller.text;
                                    String lan = 'en-Us';
                                    tts.setLanguage(lan);
                                    tts.speak(text);
                                  },
                                  child: const Icon(
                                    Icons.volume_up_rounded,
                                    color: Colors.blue,
                                  ),
                                )
                              ],
                            ),
                          ),
                          onChanged: (text) {},
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      translateFunc();
                    },
                    height: 60,
                    minWidth: 300,
                    color: Colors.blue,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'ترجمه کن',
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 75,
                        height: 150,
                        child: Center(
                          child: Text(resultValue,
                              style: theme.textTheme.bodyMedium),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> listen() async {
    if (!_isListening) {
      bool available = await speech.initialize();
      if (available) {
        setState(() {
          _isListening = true;
        });
        speech.listen(
          onResult: (result) {
            setState(() {
              text = result.recognizedWords;
              _controller.text = text;
            });
          },
        );
      } else {
        setState(() {
          _isListening = false;
        });
        await speech.stop();
      }
    } else {
      setState(() {
        _isListening = false;
      });
      await speech.stop();
    }
  }

  Future<void> translateFunc() async {
    final fromLanguageCode = Translations.getLanguageCode(language1);
    final toLanguageCode = Translations.getLanguageCode(language2);

    String message = _controller.text;
    final result = await TranslationApi.translate(
        message, fromLanguageCode, toLanguageCode);
    setState(() {
      resultValue = result;
    });
  }
}
