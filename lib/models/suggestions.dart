import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Suggestions {

  String id;
  String nome;
  String email;
  String behavior;
  File fileUrl;
  String lat;
  String long;
  String approved;
  String location;
  String nameSpecie;
  String date;
  String time;
  String sightedPlace;
  String environment;
  String comment;
  Timestamp created;

  Suggestions(
      {this.id,
      this.nome,
      this.email,
      this.behavior,
      this.fileUrl,
      this.lat,
      this.long,
      this.approved,
      this.location,
      this.nameSpecie,
      this.date,
      this.time,
      this.sightedPlace,
      this.environment,
      this.comment,
      this.created});

  Reference get storageRef =>
      FirebaseStorage.instance.ref().child('suggestions').child(id);

  Future<void> save(Suggestions suggestions) async {

    Map<String, dynamic> data = {
      'approved': false,
      'behavior': suggestions.behavior,
      'comment': suggestions.comment,
      'created': FieldValue.serverTimestamp(),
      'date': suggestions.date,
      'email_user': suggestions.email,
      'environment': suggestions.environment,
      'lat': suggestions.lat,
      'location': suggestions.lat,
      'long': suggestions.long,
      'name_specie': suggestions.nameSpecie,
      'name_user': suggestions.nome,
      'sighted_place': suggestions.sightedPlace,
      'time': suggestions.time,
    };

    if(suggestions.id == null){

      final doc = await FirebaseFirestore.instance.collection('suggestions').add(data);


      String uploadImage = '';

        if (suggestions.fileUrl != null) {
          final UploadTask task = storageRef.child(suggestions.nome).putFile(suggestions.fileUrl);
          final TaskSnapshot snapshot = await task;
          final String url = await snapshot.ref.getDownloadURL();
          uploadImage = url;
        }

        DocumentReference firestoreRef = FirebaseFirestore.instance
            .collection('suggestions')
            .doc(doc.id);

        await firestoreRef.update({
          'file_url': uploadImage,
        });
    }
  }

  @override
  String toString() {
    return 'Suggestions{id: $id, nome: $nome, email: $email, behavior: $behavior, fileUrl: $fileUrl, lat: $lat, long: $long, approved: $approved, location: $location, nameSpecie: $nameSpecie, date: $date, time: $time, sightedPlace: $sightedPlace, environment: $environment, comment: $comment, created: $created}';
  }
}