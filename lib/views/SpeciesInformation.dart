import 'package:audioplayers/audioplayers.dart';
import 'package:biotapajos_app/components/AppBar.dart';
import 'package:biotapajos_app/components/DrawerNavigation.dart';
import 'package:biotapajos_app/components/Texts.dart';
import 'package:biotapajos_app/generated/l10n.dart';
import 'package:biotapajos_app/models/SpecieDetail.dart';
import 'package:biotapajos_app/styles/Color.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class SpeciesInformation extends StatefulWidget {
  @override
  _SpeciesInformationState createState() => _SpeciesInformationState();
}

class _SpeciesInformationState extends State<SpeciesInformation> {
  SpecieDetail specieDetail;
  bool isPlaying = false;
  AudioPlayer audioPlayer = AudioPlayer();
  List<NetworkImage> _createListImages() {
    List<NetworkImage> netWorkImg = [];
    if (specieDetail == null) {
      return null;
    } else {
      specieDetail.img.forEach((element) {
        NetworkImage netImage = NetworkImage(element);
        netWorkImg.add(netImage);
      });
      return netWorkImg;
    }
  }

  _setLanguage() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String lang = _sharedPreferences.get('lang');
    setState(() {
      S.load(Locale.fromSubtags(languageCode: lang));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setLanguage();
  }

  Widget _textNullSafety({@required String data}) {
    if (data != null) {
      return Text(data);
    } else {
      return SizedBox();
    }
  }

  _playSound() async {
    if (!isPlaying) {
      if (specieDetail.sound != null) {
        int result = await audioPlayer.play(specieDetail.sound);
        print(result);
        if (result == 1) {
          setState(() {
            isPlaying = true;
          });
        }
        audioPlayer.onPlayerCompletion.listen((event) {
          setState(() {
            isPlaying = false;
          });
        });
      } else {
        Toast.show("Nao é possivel reproduzir o Som", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } else {
      audioPlayer.stop();
      setState(() {
        isPlaying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final SpecieDetail s = ModalRoute.of(context).settings.arguments;
    specieDetail = s;
    return Scaffold(
      appBar: appBar(title: specieDetail.specie),
      drawer: drawer(context: context),
      body: body(),
    );
  }

  Widget body() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                      height: constraints.maxHeight * 0.40,
                      width: constraints.maxWidth,
                      child: Carousel(images: _createListImages())),
                ),
                Container(
                  width: constraints.maxWidth,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 16.0, bottom: 8.0),
                        child: IconButton(
                            alignment: Alignment.centerLeft,
                            onPressed: () {
                              _playSound();
                            },
                            icon: Icon(
                              Icons.volume_up,
                              size: 30,
                              color: Colors.black,
                            )),
                      ),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              specieDetail.specie,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24,
                                  color: bgCOLOR,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Container(
                      width: constraints.maxWidth,
                      child: Row(
                        children: [
                          Text('${S.of(context).family} ', style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),),
                          Text( specieDetail.family)
                        ],
                      )),
                ),
                if(specieDetail.name != '')...[
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                    child: Container(
                        width: constraints.maxWidth,
                        child: Row(
                          children: [
                            Text('${S.of(context).nameCommon} ', style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                            Text(specieDetail.name.isEmpty ? '...' : specieDetail.name)
                          ],
                        )),
                  ),
                ],
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Container(
                      width: constraints.maxWidth,
                      child: textIcon(
                          child: Icon(Icons.help, color: Colors.black),
                          text: S.of(context).voceSabia,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold))),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Container(
                    width: constraints.maxWidth,
                    child: _textNullSafety(data: specieDetail.youKnow),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Container(
                      width: constraints.maxWidth,
                      child: textIcon(
                          child: Icon(Icons.public, color: Colors.black,),
                          text: S.of(context).comoConhecer,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold))),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Container(
                    width: constraints.maxWidth,
                    child: _textNullSafety(data: specieDetail.locations),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Container(
                      width: constraints.maxWidth,
                      child: textIcon(
                          child: Image.asset('images/sapo.jpeg', width: 30, height: 30,),
                          text: S.of(context).reproducao,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold))),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Container(
                    width: constraints.maxWidth,
                    child: _textNullSafety(data: specieDetail.reproduction),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Container(
                      width: constraints.maxWidth,
                      child: textIcon(
                          child: Icon(Icons.brightness_medium_sharp, color: Colors.black,),
                          text: S.of(context).Atividade,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold))),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Container(
                    width: constraints.maxWidth,
                    child: _textNullSafety(data: specieDetail.activity),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Container(
                      width: constraints.maxWidth,
                      child: textIcon(
                          child: Image.asset('images/regua.png', width: 20, height: 25,),
                          text: S.of(context).size,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold))),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Container(
                    width: constraints.maxWidth,
                    child: _textNullSafety(data: specieDetail.howKnow),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Container(
                      width: constraints.maxWidth,
                      child: textIcon(
                          child: Icon(Icons.invert_colors_on, color: Colors.black),
                          text: S.of(context).cor,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold))),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Container(
                    width: constraints.maxWidth,
                    child: _textNullSafety(data: specieDetail.color),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Container(
                      width: constraints.maxWidth,
                      child: textIcon(
                          child: Image.asset('images/sapo2.jpeg', width: 30, height: 30,),
                          text: S.of(context).specieSimilar,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold))),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Container(
                    width: constraints.maxWidth,
                    child: _textNullSafety(data: specieDetail.specieSimilar),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Container(
                      width: constraints.maxWidth,
                      child: textIcon(
                          child: Image.asset('images/arvore.png', width: 30, height: 25,),
                          text: S.of(context).whereLive,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold))),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 20),
                  child: Container(
                    width: constraints.maxWidth,
                    child: _textNullSafety(data: specieDetail.whereLive),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
