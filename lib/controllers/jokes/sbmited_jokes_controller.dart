import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:jokes_app/models/jokes/jokes.dart';
import 'package:jokes_app/services/database.dart';

class SubmitedJokesController extends GetxController {
  QuerySnapshot? jokesSnapshot;
  FirebaseAuth auth = FirebaseAuth.instance;

  RxList<JokesModel> submitedJokesList = RxList<JokesModel>();
  List<JokesModel> get todos => submitedJokesList;
  int vote = 0;

  @override
  void onInit() {
    submitedJokesList
        .bindStream(Database().submitedJokesStream(auth.currentUser!.uid));
    super.onInit(); //stream coming from firebase
  }

  void setRating(String jokeId, double rate) {
    var rating = rate.toString();
    Database.updateRating(rating, jokeId);
    update();
  }

  Future getJoke() async {
    return await FirebaseFirestore.instance.collection("jokes").get();
  }

  Future getSubmitedJoke() async {
    return await FirebaseFirestore.instance
        .collection("jokes")
        .where("uid", isEqualTo: auth.currentUser!.uid)
        .get();
  }
}
