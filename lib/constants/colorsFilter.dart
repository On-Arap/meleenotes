import 'package:flutter/material.dart';

final List<Map<dynamic, dynamic>> colorList = [
  {'color': Colors.grey[800], 'name': 'grey'},
  {'color': Colors.blue[800], 'name': 'blue'},
  {'color': Colors.green[800], 'name': 'green'},
  {'color': Colors.red[800], 'name': 'red'},
  {'color': Colors.amber[800], 'name': 'amber'},
  {'color': Colors.purple[800], 'name': 'purple'},
  {'color': Colors.pink[800], 'name': 'pink'},
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
