import 'package:cloud_firestore/cloud_firestore.dart';

class Movies {
  final String titles;
  final String keywords;
  final String posters;
  final bool likes;
  final DocumentReference? reference;

  Movies.fromMap(Map<String, dynamic> mapping, {this.reference})
      : titles = mapping["titles"],
        keywords = mapping["keywords"],
        posters = mapping["posters"],
        likes = mapping["likes"];

  Movies.fromSnapShot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  @override
  String toString() => "Movie<$titles : $keywords>";
}
