import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:jokes_app/controllers/jokes/jokes_controller.dart';
import 'package:jokes_app/models/jokes/jokes.dart';
import '../../../config.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Jokes",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            child: GetX<JokesController>(
              init: Get.put<JokesController>(JokesController()),
              builder: (JokesController _jokesController) {
                if (_jokesController.todos.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: _jokesController.todos.length,
                      itemBuilder: (_, index) {
                        var joke = _jokesController.todos[index];
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
      ),
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
    final _jokesController = Get.find<JokesController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                _jokesController.updateVote(joke.jokeId!, -1);
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
                _jokesController.updateVote(joke.jokeId!, 1);
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
    final _jokesController = Get.find<JokesController>();
    return RatingBar.builder(
      initialRating: initialRating,
      minRating: 1,
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
        _jokesController.setRating(joke.jokeId!, rating);
      },
    );
  }
}
