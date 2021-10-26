import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:jokes_app/models/jokes/jokes.dart';

class Database {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<UserModel> getUser(String uid) async {
  //   try {
  //     DocumentSnapshot _doc =
  //         await _firestore.collection("users").document(uid).get();

  //     return UserModel.fromDocumentSnapshot(documentSnapshot: _doc);
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  static Future<void> addJoke(String jokeContent, String uid) async {
    var reference = FirebaseFirestore.instance.collection("jokes");
    var id = reference.doc().id;
    reference.doc(id).set({
      'created_at': Timestamp.now(),
      'joke_text': jokeContent,
      'rating': "3.0",
      'voting_up': 0,
      'voting_down': 0,
      'joke_id': id,
      'uid': uid,
      // 'isLiked': 'No'
    }).catchError((e) {
      print(e);
    });
  }

  Stream<List<JokesModel>> jokesStream(String uid) {
    return _firestore
        .collection("jokes")
        // .orderBy("dateCreated", descending: true)
        .where("uid", isNotEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<JokesModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(JokesModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<JokesModel>> submitedJokesStream(String uid) {
    return _firestore
        .collection("jokes")
        // .orderBy("dateCreated", descending: true)

        .snapshots()
        .map((QuerySnapshot query) {
      List<JokesModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(JokesModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  static Future<void> updateVote(String jokeId, int tag) async {
    try {
      var field = "voting_up";
      if (tag < 0) {
        field = "voting_down";
      }
      var userId = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance
          .collection("jokes")
          .doc(jokeId)
          .collection("users")
          .where("user_id", isEqualTo: userId)
          .get()
          .then((value) {
        if (value.docs.length == 0) {
          _firestore
              .collection("jokes")
              .doc(jokeId)
              .update({field: FieldValue.increment(1)});

          _firestore
              .collection("jokes")
              .doc(jokeId)
              .collection("users")
              .doc()
              .set({
            'is_like': tag == 1,
            'user_id': userId,
          });
        } else {
          var doc = value.docs[0];
          if (doc["is_like"] && tag == -1) {
            _firestore.collection("jokes").doc(jokeId).update({
              field: FieldValue.increment(1),
              'voting_down': FieldValue.increment(1)
            });

            _firestore.collection("jokes").doc(jokeId).get().then((joke) {
              if (joke["voting_up"] > 0) {
                _firestore
                    .collection("jokes")
                    .doc(jokeId)
                    .update({'voting_up': FieldValue.increment(-1)});
              }
            });

            _firestore
                .collection("jokes")
                .doc(jokeId)
                .collection("users")
                .doc(doc.id)
                .update({"is_like": false});
          } else if (!doc["is_like"] && tag == 1) {
            _firestore
                .collection("jokes")
                .doc(jokeId)
                .update({field: FieldValue.increment(1)});

            _firestore.collection("jokes").doc(jokeId).get().then((joke) {
              if (joke["voting_down"] > 0) {
                _firestore
                    .collection("jokes")
                    .doc(jokeId)
                    .update({'voting_down': FieldValue.increment(-1)});
              }
            });

            _firestore
                .collection("jokes")
                .doc(jokeId)
                .collection("users")
                .doc(doc.id)
                .update({"is_like": true});
          }
        }
        print("object");
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<void> updateRating(String newRating, String jokeId) async {
    var rate = newRating.toString();
    try {
      _firestore.collection("jokes").doc(jokeId).update({"rating": rate});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Future<void> updateTodo(bool newValue, String uid, String todoId) async {
  //   try {
  //     _firestore
  //         .collection("users")
  //         .document(uid)
  //         .collection("todos")
  //         .document(todoId)
  //         .updateData({"done": newValue});
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }
}
