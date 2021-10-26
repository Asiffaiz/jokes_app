import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:jokes_app/models/jokes/jokes.dart';
import 'package:jokes_app/services/database.dart';
import 'package:jokes_app/utils/prefs.dart';

class JokesController extends GetxController {
  QuerySnapshot? jokesSnapshot;
  FirebaseAuth auth = FirebaseAuth.instance;

  RxList<JokesModel> todoList = RxList<JokesModel>();
  List<JokesModel> get todos => todoList;
  int vote = 0;

  @override
  void onInit() {
    var userId = Prefs.getString("userId");
    todoList.bindStream(Database().jokesStream(userId));
    //stream coming from firebase
    super.onInit();
  }

  void updateVote(String jokeId, int value) {
    Database.updateVote(jokeId, value);
  }

  void setRating(String jokeId, double rate) {
    var rating = rate.toString();
    Database.updateRating(rating, jokeId);
    update();
  }
}
