import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class QuizScreen extends StatefulWidget {
  String API;
  QuizScreen(this.API);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> res = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    var url = Uri.parse(widget.API);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);

      var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
      jsonResponse.forEach((element) {
        print(element);
        res.add(element);
      });
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                child: Text('1/10'),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xffE5E5E5)),
                      alignment: Alignment.center,
                      child: Text(
                        'Find the missing number in the given patternidfghu 1234',
                        textAlign: TextAlign.left,
                        style: TextStyle(height: 1.5),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        Option(Icons.done),
                        Option(Icons.close),
                        Option(Icons.done),
                        Option(Icons.done),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Too Hard ! Go to next question',
                    style: TextStyle(fontSize: 14),
                  )),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                decoration: BoxDecoration(
                    color: Color(0xff53CE34),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  'SKIP',
                  style: TextStyle(color: Colors.white),
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
        ),
      ),
    );
  }
}

class Option extends StatefulWidget {
  IconData choiceicon;
  Option(this.choiceicon);

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          color: Color(0xffE5E5E5)),
      child: Row(
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: widget.choiceicon == Icons.done
                ? Color(0xff53CE34)
                : Colors.red,
            child: Icon(
              widget.choiceicon,
              color: Colors.white,
              size: 15,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            'Hello',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
