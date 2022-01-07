// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_suggestion_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewSuggestionStore on _NewSuggestionStore, Store {
  Computed<bool> _$formValidComputed;

  @override
  bool get formValid =>
      (_$formValidComputed ??= Computed<bool>(() => super.formValid,
              name: '_NewSuggestionStore.formValid'))
          .value;
  Computed<Function> _$sendPressedComputed;

  @override
  Function get sendPressed =>
      (_$sendPressedComputed ??= Computed<Function>(() => super.sendPressed,
              name: '_NewSuggestionStore.sendPressed'))
          .value;

  final _$nameAtom = Atom(name: '_NewSuggestionStore.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$emailAtom = Atom(name: '_NewSuggestionStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$behaviorAtom = Atom(name: '_NewSuggestionStore.behavior');

  @override
  String get behavior {
    _$behaviorAtom.reportRead();
    return super.behavior;
  }

  @override
  set behavior(String value) {
    _$behaviorAtom.reportWrite(value, super.behavior, () {
      super.behavior = value;
    });
  }

  final _$fileUrlAtom = Atom(name: '_NewSuggestionStore.fileUrl');

  @override
  File get fileUrl {
    _$fileUrlAtom.reportRead();
    return super.fileUrl;
  }

  @override
  set fileUrl(File value) {
    _$fileUrlAtom.reportWrite(value, super.fileUrl, () {
      super.fileUrl = value;
    });
  }

  final _$commentAtom = Atom(name: '_NewSuggestionStore.comment');

  @override
  String get comment {
    _$commentAtom.reportRead();
    return super.comment;
  }

  @override
  set comment(String value) {
    _$commentAtom.reportWrite(value, super.comment, () {
      super.comment = value;
    });
  }

  final _$dateAtom = Atom(name: '_NewSuggestionStore.date');

  @override
  String get date {
    _$dateAtom.reportRead();
    return super.date;
  }

  @override
  set date(String value) {
    _$dateAtom.reportWrite(value, super.date, () {
      super.date = value;
    });
  }

  final _$timeAtom = Atom(name: '_NewSuggestionStore.time');

  @override
  String get time {
    _$timeAtom.reportRead();
    return super.time;
  }

  @override
  set time(String value) {
    _$timeAtom.reportWrite(value, super.time, () {
      super.time = value;
    });
  }

  final _$environmentAtom = Atom(name: '_NewSuggestionStore.environment');

  @override
  String get environment {
    _$environmentAtom.reportRead();
    return super.environment;
  }

  @override
  set environment(String value) {
    _$environmentAtom.reportWrite(value, super.environment, () {
      super.environment = value;
    });
  }

  final _$latAtom = Atom(name: '_NewSuggestionStore.lat');

  @override
  String get lat {
    _$latAtom.reportRead();
    return super.lat;
  }

  @override
  set lat(String value) {
    _$latAtom.reportWrite(value, super.lat, () {
      super.lat = value;
    });
  }

  final _$longAtom = Atom(name: '_NewSuggestionStore.long');

  @override
  String get long {
    _$longAtom.reportRead();
    return super.long;
  }

  @override
  set long(String value) {
    _$longAtom.reportWrite(value, super.long, () {
      super.long = value;
    });
  }

  final _$locationAtom = Atom(name: '_NewSuggestionStore.location');

  @override
  String get location {
    _$locationAtom.reportRead();
    return super.location;
  }

  @override
  set location(String value) {
    _$locationAtom.reportWrite(value, super.location, () {
      super.location = value;
    });
  }

  final _$nameSpecieAtom = Atom(name: '_NewSuggestionStore.nameSpecie');

  @override
  String get nameSpecie {
    _$nameSpecieAtom.reportRead();
    return super.nameSpecie;
  }

  @override
  set nameSpecie(String value) {
    _$nameSpecieAtom.reportWrite(value, super.nameSpecie, () {
      super.nameSpecie = value;
    });
  }

  final _$sightedPlaceAtom = Atom(name: '_NewSuggestionStore.sightedPlace');

  @override
  String get sightedPlace {
    _$sightedPlaceAtom.reportRead();
    return super.sightedPlace;
  }

  @override
  set sightedPlace(String value) {
    _$sightedPlaceAtom.reportWrite(value, super.sightedPlace, () {
      super.sightedPlace = value;
    });
  }

  final _$loadingAtom = Atom(name: '_NewSuggestionStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$errorAtom = Atom(name: '_NewSuggestionStore.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$savedAtom = Atom(name: '_NewSuggestionStore.saved');

  @override
  bool get saved {
    _$savedAtom.reportRead();
    return super.saved;
  }

  @override
  set saved(bool value) {
    _$savedAtom.reportWrite(value, super.saved, () {
      super.saved = value;
    });
  }

  final _$_sendAsyncAction = AsyncAction('_NewSuggestionStore._send');

  @override
  Future<void> _send() {
    return _$_sendAsyncAction.run(() => super._send());
  }

  final _$_NewSuggestionStoreActionController =
      ActionController(name: '_NewSuggestionStore');

  @override
  void setNome(String value) {
    final _$actionInfo = _$_NewSuggestionStoreActionController.startAction(
        name: '_NewSuggestionStore.setNome');
    try {
      return super.setNome(value);
    } finally {
      _$_NewSuggestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_NewSuggestionStoreActionController.startAction(
        name: '_NewSuggestionStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_NewSuggestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBehavior(String value) {
    final _$actionInfo = _$_NewSuggestionStoreActionController.startAction(
        name: '_NewSuggestionStore.setBehavior');
    try {
      return super.setBehavior(value);
    } finally {
      _$_NewSuggestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFileUrl(File value) {
    final _$actionInfo = _$_NewSuggestionStoreActionController.startAction(
        name: '_NewSuggestionStore.setFileUrl');
    try {
      return super.setFileUrl(value);
    } finally {
      _$_NewSuggestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setComment(String value) {
    final _$actionInfo = _$_NewSuggestionStoreActionController.startAction(
        name: '_NewSuggestionStore.setComment');
    try {
      return super.setComment(value);
    } finally {
      _$_NewSuggestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDate(String value) {
    final _$actionInfo = _$_NewSuggestionStoreActionController.startAction(
        name: '_NewSuggestionStore.setDate');
    try {
      return super.setDate(value);
    } finally {
      _$_NewSuggestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTime(String value) {
    final _$actionInfo = _$_NewSuggestionStoreActionController.startAction(
        name: '_NewSuggestionStore.setTime');
    try {
      return super.setTime(value);
    } finally {
      _$_NewSuggestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEnvironment(String value) {
    final _$actionInfo = _$_NewSuggestionStoreActionController.startAction(
        name: '_NewSuggestionStore.setEnvironment');
    try {
      return super.setEnvironment(value);
    } finally {
      _$_NewSuggestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLat(String value) {
    final _$actionInfo = _$_NewSuggestionStoreActionController.startAction(
        name: '_NewSuggestionStore.setLat');
    try {
      return super.setLat(value);
    } finally {
      _$_NewSuggestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLong(String value) {
    final _$actionInfo = _$_NewSuggestionStoreActionController.startAction(
        name: '_NewSuggestionStore.setLong');
    try {
      return super.setLong(value);
    } finally {
      _$_NewSuggestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLocation(String value) {
    final _$actionInfo = _$_NewSuggestionStoreActionController.startAction(
        name: '_NewSuggestionStore.setLocation');
    try {
      return super.setLocation(value);
    } finally {
      _$_NewSuggestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNameSpecie(String value) {
    final _$actionInfo = _$_NewSuggestionStoreActionController.startAction(
        name: '_NewSuggestionStore.setNameSpecie');
    try {
      return super.setNameSpecie(value);
    } finally {
      _$_NewSuggestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSightedPlace(String value) {
    final _$actionInfo = _$_NewSuggestionStoreActionController.startAction(
        name: '_NewSuggestionStore.setSightedPlace');
    try {
      return super.setSightedPlace(value);
    } finally {
      _$_NewSuggestionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
email: ${email},
behavior: ${behavior},
fileUrl: ${fileUrl},
comment: ${comment},
date: ${date},
time: ${time},
environment: ${environment},
lat: ${lat},
long: ${long},
location: ${location},
nameSpecie: ${nameSpecie},
sightedPlace: ${sightedPlace},
loading: ${loading},
error: ${error},
saved: ${saved},
formValid: ${formValid},
sendPressed: ${sendPressed}
    ''';
  }
}
