import 'package:flutter/material.dart';
import 'package:iknoweverything/Pages/question_answers.dart';

void main(){
  runApp(IknowEverything());
}

class IknowEverything extends StatelessWidget {
  const IknowEverything({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      title: "I Know Everything",
      home: QuestionAnswerPage(),
    );
  }
}
