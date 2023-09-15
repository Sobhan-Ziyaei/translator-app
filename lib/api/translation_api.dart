import 'package:translator/translator.dart';
import 'package:http/http.dart' as http;
import 'package:html_unescape/html_unescape.dart';


class TranslationApi{

  static Future<String> translate(String msg , String fromLanguageCode , String toLanguageCode) async{

    final translation = await GoogleTranslator().translate(msg,from: fromLanguageCode , to: toLanguageCode) ;

    return translation.text ;
  }

}