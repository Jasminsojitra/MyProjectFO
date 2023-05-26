import 'package:festum_evento/Languague/ge.dart';
import 'package:festum_evento/Languague/hi.dart';
import 'package:festum_evento/Languague/us.dart';
import 'package:get/get.dart';

class LocaleString extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {

    'en_US':us,
    'hi_IN':hi,
    'ger_GE':ge,

  };
}