import 'package:flutter/cupertino.dart';

class PdfFiles {
  String _file_url;

  PdfFiles({@required String file_url}) {
    this._file_url = file_url;
  }

  String get file_url => _file_url;

  set file_url(String file_url) {
    _file_url = file_url;
  }
}
