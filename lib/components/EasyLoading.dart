import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

EasyLoading easyLoading() {
  EasyLoading.show(
    status: Intl.getCurrentLocale() == 'pt' ? 'carregando' : 'Loading',
    maskType: EasyLoadingMaskType.black,
  );
}

EasyLoading dismiss() {
  Future.delayed(Duration(seconds: 2), () {
    EasyLoading.dismiss();
  });
}
