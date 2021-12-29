import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

getLanguage() async {
  SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
  String lang = _sharedPreferences.get('lang');
  return Locale.fromSubtags(languageCode: lang);
}
