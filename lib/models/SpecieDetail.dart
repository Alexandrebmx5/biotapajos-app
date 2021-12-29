class SpecieDetail {
  String _specie;
  String _family;
  String _youKnow;
  String _howKnow;
  String _locations;
  String _reproduction;
  String _active;
  String _id;
  String _name;
  String _lat;
  String _long;
  List _img;
  String _sound;
  String _color;

  SpecieDetail(
      {String name,
      String specie,
      String family,
      String youKnow,
      String howKnow,
      String locations,
      String reproduction,
      String active,
      String id,
      String lat,
      String long,
      List img,
      String sound,
      String color}) {
    this._name = name;
    this._id = id;
    this._specie = specie;
    this._family = family;
    this._youKnow = youKnow;
    this._howKnow = howKnow;
    this._locations = locations;
    this._reproduction = reproduction;
    this._active = active;
    this._lat = lat;
    this._long = long;
    this._img = img;
    this.sound = sound;
    this._color = color;
  }

  String get id => _id;

  set id(String id) {
    _id = id;
  }

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  String get active => _active;
  set active(String active) {
    _active = active;
  }

  String get reproduction => _reproduction;

  set reproduction(String reproduction) {
    _reproduction = reproduction;
  }

  String get locations => _locations;

  set locations(String locations) {
    _locations = locations;
  }

  String get howKnow => _howKnow;

  set howKnow(String howKnow) {
    _howKnow = howKnow;
  }

  String get youKnow => _youKnow;

  set youKnow(String youKnow) {
    _youKnow = youKnow;
  }

  String get family => _family;

  set family(String family) {
    _family = family;
  }

  String get specie => _specie;

  set specie(String specie) {
    _specie = specie;
  }

  String get sound => _sound;

  set sound(String sound) {
    _sound = sound;
  }

  String get lat => _lat;

  set lat(String lat) {
    _lat = lat;
  }

  String get long => _long;

  set long(String long) {
    _long = long;
  }

  List get img => _img;

  set img(List img) {
    _img = img;
  }

  String get color => _color;

  set color(String color) {
    _color = color;
  }

//end
}
