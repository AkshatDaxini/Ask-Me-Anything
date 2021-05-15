import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iknoweverything/Model/answer.dart';

class QuestionAnswerPage extends StatefulWidget {
  const QuestionAnswerPage({Key key}) : super(key: key);
  @override
  _QuestionAnswerPageState createState() => _QuestionAnswerPageState();
}

class _QuestionAnswerPageState extends State<QuestionAnswerPage> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  TextEditingController _questionFieldController = TextEditingController();
  Answer _currentAnswer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("I know Everything")),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextField(
                controller: _questionFieldController,
                decoration: InputDecoration(
                  labelText: "Ask a question",
                  border:OutlineInputBorder(),
                ),
              ),
          ),
          SizedBox(height: 20,),
          if(_currentAnswer != null)
            Stack(
              children: [
                Container(
                    height: 300,
                    width: 400,
                    child: Image.network(_currentAnswer.image,fit: BoxFit.cover,),
                  ),
                Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(_currentAnswer.answer.toUpperCase(),
                        style:TextStyle(
                          color: Colors.white,
                        fontSize: 24.0
                      ),),
                    )
                ),
              ],
            ),
          if(_currentAnswer != null)
            SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _handleGetAnswers, child:Text("Ask")),
              SizedBox(width: 20,),
              ElevatedButton(onPressed: _reset, child: Text("Reset")),
            ],
          ),
        ],
      ),
    );
  }

  _handleGetAnswers() async {
    if(!_questionFieldController.value.text.isEmpty){
      if(_questionFieldController.value.text.endsWith('?')){
        try{
          // var url = 'https://yesno.wtf/api';
          var response = await http.get(Uri.https("yesno.wtf","api"));
          if(response.statusCode == 200 && response.body != null){
            Map<String , dynamic> responseBody = jsonDecode(response.body);
            Answer answer = Answer.fromMap(responseBody);
            setState(() {
              _currentAnswer = answer;
            });
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Something went Wrong"),
            ));
          }
        }catch(err ,stacktrace){
          print(err);
          print(stacktrace);
        }
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Must end with ?"),
        ));
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please ask a question"),
      ));
    }
  }

  _reset(){
    setState(() {
      _questionFieldController.clear();
      _currentAnswer = null;
    });
  }
}
