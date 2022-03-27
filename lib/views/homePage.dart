import 'dart:async';
import 'package:final_620710821/models/quiz.dart';
import 'package:final_620710821/service/api.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Quiz>? quiz_list;
  int c = 0;
  int wrongGuess = 0;


  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    List list = await Api().fetch('quizzes');
    setState(() {
      quiz_list = list.map((item) => Quiz.fromJson(item)).toList();
    });
  }

  void guess(String choice) {
   {
      setState(() {
        if (quiz_list![c].answer == choice) {
          c++;
        } else {
          wrongGuess++;
        }
      });
    };
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: quiz_list != null && c < quiz_list!.length-1
          ? buildQuiz()
          : quiz_list != null && c == quiz_list!.length-1
          ? buildTryAgain()
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildTryAgain() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('จบเกม'),
            Text('ทายผิด ${wrongGuess} ครั้ง'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    wrongGuess = 0;
                    c = 0;
                    quiz_list = null;
                    _fetch();
                  });
                },
                child: Text('เริ่มเกมใหม่'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildQuiz() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(quiz_list![c].image, fit: BoxFit.cover),
            Column(
              children: [
                for (int i = 0; i < quiz_list![c].choice_list.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () =>
                                guess(quiz_list![c].choice_list[i].toString()),
                            child: Text(quiz_list![c].choice_list[i]),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}