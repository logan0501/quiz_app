import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:quiz_app/Screens/quiz_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<dynamic> res = [];

  Future<List<dynamic>> getdata() async {
    var url = Uri.parse('http://perceptiondraft.com/api/gbas00721-cat.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);

      var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
      return jsonResponse;
    }
    return [];
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
              SizedBox(height: 20),
              Center(
                child: Text('Available Quiz'),
              ),
              Expanded(
                  child: FutureBuilder(
                future: getdata(),
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return Text('loading');
                  }
                  List<dynamic> post = snapshots.data as List<dynamic>;
                  res = post;
                  return ListView.builder(
                      itemCount: post.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 2,
                                  offset: Offset(0, 2),
                                )
                              ],
                              color: Color(0xffE5E5E5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                  child: Image.network(post[index]['img']),
                                  margin: EdgeInsets.all(7),
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    post[index]['name'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Text('Difficulty : Basic'),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        '100',
                                        style: TextStyle(
                                            color: Colors.lightGreen,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(' / 20,000 Questions'),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      });
                },
              )),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              QuizScreen(res.elementAt(0)['apilink'])));
                },
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  decoration: BoxDecoration(
                      color: Color(0xff53CE34),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text(
                    'Instant Quiz',
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
        ),
      ),
    );
  }
}
