import 'package:animate_do/animate_do.dart';
import 'package:biotapajos_app/components/Buttons.dart';
import 'package:biotapajos_app/components/CustomAnimation.dart';
import 'package:biotapajos_app/config/Auth.dart';
import 'package:biotapajos_app/config/Routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'generated/l10n.dart';
import 'styles/Color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configLoading();
  runApp(MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = PRIMARY
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BioCheck Tapajós',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: routes(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        builder: EasyLoading.init());
  }
}

class InitialScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return Stack(
        children: <Widget>[
          SplashScreen(
            seconds: 4,
            navigateAfterSeconds: MyHomePage(),
            loaderColor: Colors.white,
          ),
          Container(color: Colors.white),
          Center(
              child: Container(
                width: 150,
                height: 150,
                child: Hero(
                    tag: 'charizard',
                    transitionOnUserGestures: true,
                    child: Image.asset('images/logo_no_bg.png')),
              )
          ),
        ],
      );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences _sharedPreferences = null;

  _getPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  _setLanguage() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String lang = _sharedPreferences.get('lang');
    setState(() {
      S.load(Locale.fromSubtags(languageCode: lang));
    });
  }

  _checkLoged() {
    if (Auth.isLoged()) {
      Future(() {
        Navigator.pushNamed(context, '/home');
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setLanguage();
    _checkLoged();
    _getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          FadeInUp(
            child: Image.asset(
              'images/logo_no_bg.png',
              width: MediaQuery.of(context).size.width * 0.40,
              height: MediaQuery.of(context).size.height * 0.40,
            ),
          ),
          FadeInUp(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.60,
              decoration: BoxDecoration(
                  color: PRIMARY,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Text(
                      S.of(context).bemVindo,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: btInitial(
                        context: context,
                        title: S.of(context).criarUmaConta,
                        call: () {
                          Navigator.pushNamed(context, '/register');
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: btInitial(
                        context: context,
                        title: S.of(context).entrar,
                        call: () {
                          Navigator.pushNamed(context, '/login');
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: btDropDown(
                        context: context,
                        title: S.of(context).idioma,
                        call: (String language) {
                          if (language == 'Português') {
                            setState(() {
                              S.load(
                                Locale.fromSubtags(languageCode: 'pt'),
                              );
                            });
                            _sharedPreferences.setString('lang', 'pt');
                          } else {
                            setState(() {
                              S.load(Locale.fromSubtags(languageCode: 'en'));
                            });
                            _sharedPreferences.setString('lang', 'en');
                          }
                        }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
