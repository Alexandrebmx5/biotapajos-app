import 'dart:io';
import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/components/DrawerNavigation.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/models/suggestions.dart';
import 'package:biotapajos_app/store/new_suggestion_store.dart';
import 'package:biotapajos_app/styles/Color.dart';
import 'package:biotapajos_app/views/GetCoordinate.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuggestionsScreen extends StatefulWidget {
  @override
  _SuggestionsScreenState createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  File _file;
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

  final NewSuggestionStore store =
      NewSuggestionStore(suggestions: Suggestions());

  GlobalKey btnKey2;
  GlobalKey btnKey3;

  _pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _file = File(result.files.single.path);
        store.setFileUrl(_file);
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setLanguage();
    btnKey2 = GlobalKey();
    btnKey3 = GlobalKey();
    _name = _auth.currentUser.displayName;
    _email = _auth.currentUser.email;


    when((_) => store.saved == true, () {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Dados atualizados com sucesso!'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Ok',
                style: TextStyle(color: PRIMARY),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    _coordinates = args;

    store.setNome(_name);
    store.setEmail(_email);
    store.setLat(_coordinates?.latitude.toString() ?? '');
    store.setLong(_coordinates?.longitude.toString() ?? '');

    return Scaffold(
      appBar: appBar(title: S.of(context).sugestao),
      drawer: drawer(context: context),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(child: body()),
    );
  }

  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: Text('Adicione uma imagem e uma coordenada: *', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Row(
            children: [
              ElevatedButton.icon(
                  key: btnKey2,
                  style: ButtonStyle(
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: (){
                    _pickFile();
                  },
                  icon: Icon(
                    Icons.upload_file,
                    color: Colors.grey,
                  ),
                  label: Text(
                    _file == null
                        ? 'Enviar foto'
                        : S.of(context).adicionado,
                    style: TextStyle(color: Colors.grey),
                  )),
              SizedBox(width: 10),
              ElevatedButton.icon(
                  key: btnKey3,
                  style: ButtonStyle(
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (context) => GetCoordinate());
                  },
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.grey,
                  ),
                  label: Text(
                    _coordinates == null
                        ? 'Enviar coordenadas'
                        : S.of(context).adicionado,
                    style: TextStyle(color: Colors.grey),
                  )),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
          child: Material(
            elevation: 4,
            child: TextField(
              onChanged: store.setNameSpecie,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 12),
                border: InputBorder.none,
                hintText: 'Nome da Espécie',
              ),
              keyboardType: TextInputType.multiline,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
          child: Material(
            elevation: 4,
            child: TextField(
              onChanged: store.setLocation,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 12),
                border: InputBorder.none,
                hintText: 'Local Ex: FLONA Tapajós',
              ),
              keyboardType: TextInputType.multiline,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
          child: Material(
            elevation: 4,
            child: TextField(
              onChanged: store.setDate,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 12),
                border: InputBorder.none,
                hintText: 'Data do ocorrido Ex: DD/MM/AAAA',
              ),
              keyboardType: TextInputType.multiline,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
          child: Material(
            elevation: 4,
            child: TextField(
              onChanged: store.setTime,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 12),
                border: InputBorder.none,
                hintText: 'Hora do ocorrido Ex: HH:MM',
              ),
              keyboardType: TextInputType.multiline,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: Text('Ambiente:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        ),
        Observer(builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: 'Florestado',
                    onChanged: store.setEnvironment,
                    groupValue: store.environment,
                    activeColor: PRIMARY,
                  ),
                  Text('Florestado'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Urbano',
                    onChanged: store.setEnvironment,
                    groupValue: store.environment,
                    activeColor: PRIMARY,
                  ),
                  Text('Urbano'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Praia',
                    onChanged: store.setEnvironment,
                    groupValue: store.environment,
                    activeColor: PRIMARY,
                  ),
                  Text('Praia'),
                ],
              ),
            ],
          );
        }),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: Text('Local onde o animal foi avistado:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        ),
        Observer(builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: 'Folhagem no chão',
                    onChanged: store.setSightedPlace,
                    groupValue: store.sightedPlace,
                    activeColor: PRIMARY,
                  ),
                  Text('Folhagem no chão'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Chão limpo',
                    onChanged: store.setSightedPlace,
                    groupValue: store.sightedPlace,
                    activeColor: PRIMARY,
                  ),
                  Text('Chão limpo'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Galhos baixos de árvore',
                    onChanged: store.setSightedPlace,
                    groupValue: store.sightedPlace,
                    activeColor: PRIMARY,
                  ),
                  Text('Galhos baixos de árvore'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Galhos altos de árvore',
                    onChanged: store.setSightedPlace,
                    groupValue: store.sightedPlace,
                    activeColor: PRIMARY,
                  ),
                  Text('Galhos altos de árvore'),
                ],
              ),
            ],
          );
        }),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: Text('Comportamento:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        ),
        Observer(builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: 'Cantando',
                    onChanged: store.setBehavior,
                    groupValue: store.behavior,
                    activeColor: PRIMARY,
                  ),
                  Text('Cantando'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Se alimentandoo',
                    onChanged: store.setBehavior,
                    groupValue: store.behavior,
                    activeColor: PRIMARY,
                  ),
                  Text('Se alimentando'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Escondido',
                    onChanged: store.setBehavior,
                    groupValue: store.behavior,
                    activeColor: PRIMARY,
                  ),
                  Text('Escondido'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Se deslocando',
                    onChanged: store.setBehavior,
                    groupValue: store.behavior,
                    activeColor: PRIMARY,
                  ),
                  Text('Se deslocando'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Interagindo com outro animal',
                    onChanged: store.setBehavior,
                    groupValue: store.behavior,
                    activeColor: PRIMARY,
                  ),
                  Text('Interagindo com outro animal'),
                ],
              ),
            ],
          );
        }),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
          child: Material(
            elevation: 4,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.20,
              child: TextField(
                onChanged: store.setComment,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 12),
                  border: InputBorder.none,
                  hintText: 'Deixe seu comentário',
                ),
                keyboardType: TextInputType.multiline,
                minLines: 1, //Normal textInputField will be displayed
                maxLines: 3,
                // when user presses enter it will adapt to it
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 20),
          child: Text('Obs.: Foto e coordenadas são obrigatórios', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: store.sendPressed,
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
        SizedBox(height: 300),
      ],
    );
  }
}
