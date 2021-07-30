import 'package:flutter/material.dart';

class Question {
  String que;
  List<String> options;
  List<Color> colors;
  List<IconData> icons;
  String correct_option;
  Question(this.que, this.options, this.correct_option, this.colors,this.icons);
  String getQuestion() {
    return que;
  }

  String correctAns() {
    return correct_option;
  }
}
