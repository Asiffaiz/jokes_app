import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import 'package:jokes_app/controllers/jokes/sbmited_jokes_controller.dart';
import 'package:jokes_app/models/jokes/jokes.dart';

import 'package:jokes_app/views/pages/upload_joke/upload_joke.dart';

import '../../../config.dart';

class SubmitedJokes extends StatelessWidget {
  SubmitedJokes({Key? key}) : super(key: key);

  void showSnackBar(String title, String message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kPrimaryColor,
        colorText: kBackgroundColor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Submited Jokes",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(UploadJoke());
              },
              icon: Icon(Icons.post_add_rounded)),
        ],
      ),
      body: _buildSubmitedJokes(),
    );
  }

  Widget _buildSubmitedJokes() {
    return Column(
      children: [
        Container(
          child: GetX<SubmitedJokesController>(
            init: Get.put<SubmitedJokesController>(SubmitedJokesController()),
            builder: (SubmitedJokesController _submitedjokesController) {
              if (_submitedjokesController.todos.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: _submitedjokesController.todos.length,
                    itemBuilder: (_, index) {
                      var joke = _submitedjokesController.todos[index];
                      var initialRating = double.parse(joke.rating!);
                      assert(initialRating is double);
                      return Container(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                jokeDetails(joke),
                                SizedBox(height: Config.screenHeight! * 0.03),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: votingRow(initialRating, joke),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Text("jokes list is emty"),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget jokeDetails(JokesModel joke) {
    return Text(
      joke.jokeContent!,
      style: TextStyle(fontSize: 20),
      textAlign: TextAlign.center,
    );
  }

  Widget votingRow(double initialRating, JokesModel joke) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                showSnackBar("", "Sorry,you can't vote your own joke!");
              },
              icon: ImageIcon(
                AssetImage("assets/images/thumb-down.png"),
                color: Color(0xFF3A5A98),
                size: 18,
              ),
            ),
            SizedBox(width: 5),
            Text(joke.votingDown.toString()),
            SizedBox(width: 5),
            IconButton(
              onPressed: () {
                showSnackBar("", "Sorry,you can't vote your own joke!");
              },
              icon: ImageIcon(
                AssetImage("assets/images/thumb-up.png"),
                color: Color(0xFF3A5A98),
                size: 18,
              ),
            ),
            SizedBox(width: 5),
            Text(joke.votingUp.toString()),
          ],
        ),
        ratingBar(initialRating, joke)
      ],
    );
  }

  Widget ratingBar(double initialRating, JokesModel joke) {
    return RatingBar.builder(
      initialRating: initialRating,
      minRating: 1,
      ignoreGestures: true,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 22,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        // final _submitedjokesController = Get.find<SubmitedJokesController>();
        // _submitedjokesController.setRating(joke.jokeId!, rating);
      },
    );
  }
}
