import 'dart:io';
import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/components/DrawerNavigation.dart';
import 'package:biotapajos_app/components/EasyLoading.dart';
import 'package:biotapajos_app/components/Empty.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/styles/Color.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Suggestions extends StatefulWidget {
  @override
  _SuggestionsState createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _controller = TextEditingController();
  File _file;
  bool _loaded = false;
  LatLng _coordinates;
  String _name = '';
  String _email = '';
  _setLanguage() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String lang = _sharedPreferences.get('lang');
    setState(() {
      S.load(Locale.fromSubtags(languageCode: lang));
    });
  }

  GlobalKey btnKey2;

  _pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _file = File(result.files.single.path);
        _loaded = true;
      });
    } else {
      // User canceled the picker
    }
  }

  _save() {
    if (_file == null && _coordinates != null) {
      _saveCoordinates();
    } else {
      String _fileName = _file.path.split('/').last;
      _uploadFile(arqName: _fileName);
    }
  }

  _uploadFile({String arqName}) {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference root = storage.ref();
    Reference arq = root.child('suggestions').child(arqName);

    if (arqName != null) {
      easyLoading();
      arq.putFile(_file).then((value) async {
        String url = await value.ref.getDownloadURL();

        await _saveUrl(url: url);
      }).catchError((error) {
        EasyLoading.dismiss();
        Toast.show(S.of(context).salvoFalha, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      });
    }
  }

  _saveCoordinates() {
    easyLoading();

    Map<String, dynamic> data = {};
    if (_coordinates != null) {
      data.addAll({'name': _name});
      data.addAll({'email': _email});
      data.addAll({'lat': _coordinates.latitude});
      data.addAll({'long': _coordinates.longitude});
    }
    if (_controller.text.isNotEmpty) {
      data.addAll({'text': _controller.text.trim()});
    }

    if (data.isNotEmpty) {
      _db.collection('suggestions').add(data).then((value) {
        EasyLoading.dismiss();

        Toast.show(S.of(context).salvoSucesso, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      });
    } else {
      EasyLoading.dismiss();
      Toast.show(S.of(context).salvoFalha, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  _saveUrl({String url}) {
    Map<String, dynamic> data = {};
    if (url != null) {
      data.addAll({'name': _name});
      data.addAll({'email': _email});
      data.addAll({'fileUrl': url});
    }
    if (_controller.text.isNotEmpty) {
      data.addAll({'text': _controller.text.trim()});
    }

    if (data.isNotEmpty) {
      _db.collection('suggestions').add(data).then((value) {
        EasyLoading.dismiss();
        _file = null;
        Toast.show(S.of(context).salvoSucesso, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      });
    } else {
      _file = null;
      EasyLoading.dismiss();
      Toast.show(S.of(context).salvoFalha, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setLanguage();
    btnKey2 = GlobalKey();
    _name = _auth.currentUser.displayName;
    _email = _auth.currentUser.email;
  }

  void stateChanged(bool isShow) {
    // nothing to do now
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    _coordinates = args;
    if (_coordinates != null) _loaded = true;
    return Scaffold(
      appBar: appBar(title: S.of(context).sugestao),
      drawer: drawer(context: context),
      resizeToAvoidBottomInset: false,
      body: bodyConstruction(),
    );
  }

  Widget body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              elevation: 4,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.30,
                child: TextField(
                  controller: _controller,

                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12),
                    border: InputBorder.none,
                    hintText: S.of(context).hintSugestao,
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 1, //Normal textInputField will be displayed
                  maxLines: 5,
                  // when user presses enter it will adapt to it
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                    key: btnKey2,
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    onPressed: (customBackground),
                    icon: Icon(
                      Icons.upload_file,
                      color: Colors.grey,
                    ),
                    label: Text(
                      _loaded == false
                          ? S.of(context).enviarArqivo
                          : S.of(context).adicionado,
                      style: TextStyle(color: Colors.grey),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _save();
                  },
                  child: Text(S.of(context).salvar),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.only(left: 32.0, right: 32.0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(PRIMARY)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void customBackground() {
    PopupMenu menu = PopupMenu(
        context: context,
        backgroundColor: PRIMARY,
        lineColor: Colors.white,

        // maxColumn: 2,
        items: [
          MenuItem(
              title: S.of(context).arquivos,
              image: Icon(
                Icons.file_copy,
                color: Colors.white,
              )),
          MenuItem(
              title: S.of(context).coordenadas,
              image: Icon(
                Icons.location_on,
                color: Colors.white,
              ))
        ],
        onClickMenu: (data) {
          menuSelected(data.menuTitle);
        },
        stateChanged: stateChanged,
        onDismiss: () {});
    menu.show(widgetKey: btnKey2);
  }

  menuSelected(String menuItem) {
    switch (menuItem) {
      case 'Arquivos':
        _pickFile();
        break;
      case 'Files':
        break;
      case 'Coordenadas':
        Navigator.pushNamed(context, '/coordinates');
        break;
      default:
    }
  }

  Widget bodyConstruction() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          notFinished(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.height * 0.35),
          Text(
            S.of(context).emConstrucao,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          )
        ],
      ),
    );
  }
}
