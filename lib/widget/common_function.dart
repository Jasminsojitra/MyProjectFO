import 'package:flutter/material.dart';

SnackBar SnackbarWidget(text){
  return SnackBar(content: Text(text),backgroundColor: Colors.black,duration: Duration(seconds: 2),);
}
