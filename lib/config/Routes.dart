import 'package:biotapajos_app/views/GetCoordinate.dart';
import 'package:biotapajos_app/views/ListSpecies.dart';
import 'package:biotapajos_app/views/Login.dart';
import 'package:biotapajos_app/views/MapView.dart';
import 'package:biotapajos_app/views/PasswordRetrieve.dart';
import 'package:biotapajos_app/views/Profile.dart';
import 'package:biotapajos_app/views/Register.dart';
import 'package:biotapajos_app/views/Species.dart';
import 'package:biotapajos_app/views/SpeciesInformation.dart';
import 'package:biotapajos_app/views/Suggestions.dart';
import 'package:biotapajos_app/views/about_us/submenus_about_us.dart';
import 'package:biotapajos_app/views/actualities/list_actualities.dart';
import 'package:biotapajos_app/views/actualities/list_report.dart';
import 'package:biotapajos_app/views/actualities/submenus_actualities.dart';
import 'package:biotapajos_app/views/ecological_trails/submenus_ecological_trails.dart';
import 'package:biotapajos_app/views/home.dart';

import '../main.dart';

routes() {
  return {
    '/home': (context) => Home(),
    '/login': (context) => Login(),
    '/register': (context) => Register(),
    '/map': (context) => MapView(),
    '/suges': (context) => SuggestionsScreen(),
    '/species': (context) => Species(),
    '/species/list': (context) => ListSpecies(),
    '/species/list/information': (context) => SpeciesInformation(),
    '/retieve': (context) => PasswordRetrieve(),
    '/coordinates': (context) => GetCoordinate(),
    '/profile': (context) => Profile(),
    '/trails': (context) => SubMenusEcologicalTrails(),
    '/actualities': (context) => ListActualities(),
    '/report': (context) => ListReport(),
    '/actualities_menus': (context) => SubMenusActualities(),
    '/about': (context) => SubMenusAboutUs(),
    '/': (context) => InitialScreen(),
  };
}
