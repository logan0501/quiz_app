import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/Screens/home_screen.dart';
import 'dart:convert' as convert;
import 'package:quiz_app/Views/Question.dart';

class QuizScreen extends StatefulWidget {
  String API;
  QuizScreen(this.API);
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String resultmessage = 'Too Hard ! Go to next question';
  Color resultcolor = Colors.orange;
  var buttontext = "SKIP";
  var res = [];
  int count = 1;
  List<Question> questionslist = [];
  var opticon;
  Future<List<dynamic>> getdata() async {
    var url = Uri.parse(widget.API);
    var response = await http.get(url);

    var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;

    return jsonResponse;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata().then((value) {
      value.forEach((element) {
        questionslist.add(Question(
            element['q'],
            [
              element['o1'].toString(),
              element['o2'].toString(),
              element['o3'].toString(),
              element['o4'].toString()
            ],
            element['co'].toString(),
            [Colors.grey, Colors.grey, Colors.grey, Colors.grey],
            [Icons.circle, Icons.circle, Icons.circle, Icons.circle]));
      });
      setState(() {
        res = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: res.length != 0
            ? Container(
                child: Column(
                  children: [
                    Center(
                      child: Image(
                        height: MediaQuery.of(context).size.height * 0.06,
                        image: AssetImage('assets/logo.png'),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            'Number System',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Level 1',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Color(0xff236D72),
                            Color(0xff4D9196).withOpacity(0.97)
                          ])),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('${count}/${questionslist.length}'),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Color(0xffE5E5E5)),
                                alignment: Alignment.center,
                                child: Text(
                                  questionslist.length != 0
                                      ? questionslist[count].que
                                      : "loading",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(height: 1.5),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (index ==
                                            questionslist[count]
                                                .options
                                                .indexOf(questionslist[count]
                                                    .correct_option)) {
                                          setState(() {
                                            questionslist[count].colors[index] =
                                                Colors.green;
                                            resultmessage =
                                                "Awesome! Try another Question";
                                            resultcolor = Colors.green;
                                            questionslist[count].icons[index] =
                                                Icons.done;
                                            buttontext = "NEXT";
                                          });
                                        } else {
                                          setState(() {
                                            questionslist[count].colors[index] =
                                                Colors.red;
                                            resultmessage =
                                                'Too Hard ! Go to next question';
                                            resultcolor = Colors.red;
                                            questionslist[count].icons[index] =
                                                Icons.close;
                                            buttontext = "SKIP";
                                          });
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2,
                                                color: questionslist[count]
                                                    .colors[index]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40)),
                                            color: Color(0xffE5E5E5)),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 10,
                                              backgroundColor:
                                                  questionslist.length != 0
                                                      ? questionslist[count]
                                                          .colors[index]
                                                      : Colors.grey,
                                              child: Icon(
                                                questionslist[count]
                                                    .icons[index],
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              questionslist[count]
                                                  .options[index],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                          resultmessage,
                          style: TextStyle(
                              fontSize: 14,
                              color: resultcolor,
                              fontWeight: FontWeight.bold),
                        )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (count < questionslist.length - 1) {
                            count++;
                            resultmessage = 'Too Hard ! Go to next question';
                            resultcolor = Colors.orange;
                            buttontext = "SKIP";
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondScreen()));
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                        decoration: BoxDecoration(
                            color: resultcolor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Text(
                          buttontext,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Candidate ID : Loganathan_logan05012001@gmail.com',
                          style: TextStyle(fontSize: 10),
                        )),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
