import 'package:cloud_firestore/cloud_firestore.dart';

class JokesModel {
  String? jokeContent;
  String? jokeId;
  Timestamp? dateCreated;
  String? rating;

  int? votingUp;
  int? votingDown;
  // String? isLiked;

  JokesModel(
    this.jokeContent,
    this.jokeId,
    this.dateCreated,
    this.votingUp,
    this.votingDown,
  );

  JokesModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    jokeId = documentSnapshot.id;
    jokeContent = documentSnapshot["joke_text"];
    dateCreated = documentSnapshot["created_at"];
    rating = documentSnapshot["rating"];
    votingUp = documentSnapshot["voting_up"];
    votingDown = documentSnapshot["voting_down"];
    jokeId = documentSnapshot["joke_id"];
    // isLiked = documentSnapshot["isLiked"];
  }
}
