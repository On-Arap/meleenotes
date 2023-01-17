import 'package:flutter/material.dart';

final List<Map<dynamic, dynamic>> colorList = [
  {'color': Colors.grey[800], 'name': 'grey'},
  {'color': Color(0xFF337357), 'name': 'green'},
  {'color': Color(0xFFAC0606), 'name': 'red'},
  {'color': Color(0xFF454ADE), 'name': 'blue'},
  {'color': Color(0xFFE08E45), 'name': 'amber'},
  // {'color': Color(0xFF35012C), 'name': 'purple'},
  {'color': Color(0xFFBD4089), 'name': 'pink'},
];

Color? getColorByName(String name) {
  var color = Colors.grey[800];

  colorList.forEach((col) {
    if (col['name'] == name) {
      color = col['color'];
    }
  });
  return color;
}

getColorNames() {
  return colorList.map((e) => (e['name'].toString())).toList();
}
