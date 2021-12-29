import 'dart:io';
import 'package:biotapajos_app/components/Buttons.dart';
import 'package:biotapajos_app/components/DrawerNavigation.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/styles/Color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _controller = TextEditingController();
  SharedPreferences _sharedPreferences;
  String _userName = ' ';
  String _email = '';
  ImagePicker imagePicker = ImagePicker();
  File tmp;
  File image;
  bool toggle = false;
  bool changed = false;
  bool loading = false;
  String id;
  String urlImage;
  Drawer _drawer;

  _setLanguage() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String lang = _sharedPreferences.get('lang');
    setState(() {
      S.load(Locale.fromSubtags(languageCode: lang));
    });
  }

  _getUserName() async {
    User userCurrent = await _auth.currentUser;
    String userId = userCurrent.uid;
    setState(() {
      id = userId;
    });

    setState(() {
      _userName = userCurrent.displayName;
      urlImage = userCurrent.photoURL;
      _email = userCurrent.email;
      _controller.text = _userName;
    });
  }

  _getImage() async {
    final PickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      File img = File(PickedFile.path);

      //await CompressImage.compress(
      //  imageSrc: img.absolute.path, desiredQuality: 40);
      setState(() {
        image = img;
      });

      String fileName = image.path.split('/').last;
      _uploadImage(fileName: fileName);
    }
  }

  _uploadImage({String fileName}) {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference root = storage.ref();
    Reference arq = root.child('users').child(fileName);
    String oldUrl = _auth.currentUser.photoURL;
    if (image != null) {
      setState(() {
        loading = true;
      });
      arq.putFile(image).then((value) async {
        String url = await value.ref.getDownloadURL();
        _saveUrl(url: url);

        storage.refFromURL(oldUrl).delete();

        setState(() {
          loading = false;
        });

        Toast.show(S.of(context).atualizado, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }).catchError((error) {
        Toast.show(S.of(context).falhaAtualizar, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      });
    }
  }

  _saveUrl({String url}) {
    print(_auth.currentUser.uid);
    _db
        .collection('users')
        .doc(_auth.currentUser.uid)
        .update({'url': url}).then((value) {
      _auth.currentUser.updateProfile(photoURL: url).then((value) {
        setState(() {
          _drawer = drawer(context: context);
        });
      });
    });
  }

  _changeLang(String language) async {
    if (language == 'Português') {
      await _sharedPreferences.setString('lang', 'pt');
      await S.load(Locale.fromSubtags(languageCode: 'pt'));

      setState(() {
        _drawer = drawer(context: context);
      });
    } else {
      await _sharedPreferences.setString('lang', 'en');
      await S.load(Locale.fromSubtags(languageCode: 'en'));
      setState(() {
        _drawer = drawer(context: context);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setLanguage();
    _getUserName();
    Future(() {
      _drawer = drawer(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      drawer: _drawer,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [header(constraints), body()],
          );
        },
      ),
    );
  }

  Widget header(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth,
      height: 180,
      child: Stack(
        children: [
          Container(
            width: constraints.maxWidth,
            height: 130,
            color: PRIMARY,
          ),
          Positioned(
              left: 100,
              top: -15,
              child: Container(
                height: 100,
                width: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/BioCheck_Horizontal.png'))),
              )),
          Positioned(
            top: 75,
            left: 32,
            child: _chooseImage(),
          )
        ],
      ),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.only(top: 64.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            loading != false
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(),
            TextField(
              onChanged: (value) {
                setState(() {
                  changed = true;
                });
              },
              textAlign: TextAlign.center,
              controller: _controller,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              ),
            ),
            Text(_email),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: btDropDown(
                  context: context,
                  title: S.of(context).idioma,
                  call: (language) {
                    _changeLang(language);
                  }),
            ),
            changed == true
                ? Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(1),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(PRIMARY)),
                      onPressed: () {
                        _db
                            .collection('users')
                            .doc(_auth.currentUser.uid)
                            .update({'name': _controller.text.trim()}).then(
                                (value) {
                          _auth.currentUser
                              .updateProfile(
                                  displayName: _controller.text.trim())
                              .then((value) {
                            setState(() {
                              changed = false;
                              _drawer = drawer(context: context);
                            });
                            Toast.show(S.of(context).atualizado, context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                          });
                        });
                      },
                      child: Text(S.of(context).salvar),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _chooseImage({name, thumbnail}) {
    return GestureDetector(
        onTap: () {
          _getImage();
        },
        child: image == null
            ? _cachedImage(name: name, thumbnail: thumbnail)
            : Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(width: 4, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.file(
                    image,
                    fit: BoxFit.cover,
                  ),
                )));
  }

  Widget _cachedImage({thumbnail, name}) {
    return urlImage == null
        ? Container(
            decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(width: 4, color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(100))),
            width: 100,
            height: 100,
            child: Icon(
              Icons.person,
              size: 64,
              color: Colors.white,
            ))
        : Container(
            decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(width: 4, color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(100))),
            width: 100,
            height: 100,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(urlImage),
                  minRadius: 30,
                  maxRadius: 40,
                )));
  }
}
