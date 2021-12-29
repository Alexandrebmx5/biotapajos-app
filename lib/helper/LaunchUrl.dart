import 'package:biotapajos_app/generated/l10n.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL({String url, context}) async => await canLaunch(url)
    ? await launch(url)
    : Toast.show(S.of(context).erroGenerico, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
