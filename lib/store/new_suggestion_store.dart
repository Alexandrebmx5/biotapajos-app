import 'dart:io';

import 'package:biotapajos_app/components/EasyLoading.dart';
import 'package:biotapajos_app/models/suggestions.dart';
import 'package:mobx/mobx.dart';

part 'new_suggestion_store.g.dart';

class NewSuggestionStore = _NewSuggestionStore with _$NewSuggestionStore;

abstract class _NewSuggestionStore with Store {

  _NewSuggestionStore({this.suggestions});

  final Suggestions suggestions;

  @observable
  String name;

  @action
  void setNome(String value) => name = value;

  @observable
  String email;

  @action
  void setEmail(String value) => email = value;

  @observable
  String behavior;

  @action
  void setBehavior(String value) => behavior = value;

  @observable
  File fileUrl;

  @action
  void setFileUrl(File value) => fileUrl = value;

  @observable
  String comment;

  @action
  void setComment(String value) => comment = value;

  @observable
  String date;

  @action
  void setDate(String value) => date = value;

  @observable
  String time;

  @action
  void setTime(String value) => time = value;

  @observable
  String environment;

  @action
  void setEnvironment(String value) => environment = value;

  @observable
  String lat;

  @action
  void setLat(String value) => lat = value;

  @observable
  String long;

  @action
  void setLong(String value) => long = value;

  @observable
  String location;

  @action
  void setLocation(String value) => location = value;

  @observable
  String nameSpecie;

  @action
  void setNameSpecie(String value) => nameSpecie = value;

  @observable
  String sightedPlace;

  @action
  void setSightedPlace(String value) => sightedPlace = value;


  @computed
  bool get formValid => true;

  @computed
  Function get sendPressed => formValid ? _send : null;

  @observable
  bool loading = false;

  @observable
  String error;

  @observable
  bool saved = false;

  @action
  Future<void> _send() async {

    suggestions.nome = name;
    suggestions.email = email;
    suggestions.behavior = behavior;
    suggestions.fileUrl = fileUrl;
    suggestions.lat = lat;
    suggestions.long = long;
    suggestions.location = location;
    suggestions.nameSpecie = nameSpecie;
    suggestions.date = date;
    suggestions.time = time;
    suggestions.sightedPlace = sightedPlace;
    suggestions.environment = environment;
    suggestions.comment = comment;

    loading = true;

    easyLoading();
    try {
      await Suggestions().save(suggestions);
      saved = true;
    } catch (e) {
      error = e;
    }
    dismiss();
    loading = false;
  }



}