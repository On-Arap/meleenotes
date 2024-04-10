import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:melee_notes/constants/colorsFilter.dart';

class NoteTile extends ListTile {
  final String titleNote;
  final String body;
  final String type;
  final int index;
  final int tileIndex;
  final Function() onSlideDelete;
  final Function() onTapUpdate;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  NoteTile({
    super.key,
    required this.titleNote,
    required this.body,
    required this.type,
    required this.index,
    required this.tileIndex,
    required this.onSlideDelete,
    required this.onTapUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      // child: Slidable(
      //   endActionPane: ActionPane(
      //     extentRatio: 0.3,
      //     motion: const ScrollMotion(),
      //     children: [
      //       SlidableAction(
      //         // An action can be bigger than the others.
      //         flex: 2,
      //         onPressed: (BuildContext context) {
      //           onSlideDelete();
      //         },
      //         backgroundColor: Colors.redAccent.shade700,
      //         foregroundColor: Colors.white,
      //         icon: Icons.archive,
      //         label: 'Delete',
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //     ],
      //   ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: getColorByName(type),
          borderRadius: BorderRadius.circular(3),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade600,
              spreadRadius: 1,
              blurRadius: 15,
              offset: const Offset(5, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  titleNote,
                  style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  GestureDetector(
                    onTap: onTapUpdate,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.edit,
                        color: Colors.grey[300],
                        weight: 2,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: onSlideDelete,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.delete,
                        color: Colors.grey[300],
                        weight: 2,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ReorderableDragStartListener(
                    index: tileIndex,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Icon(
                        Icons.reorder_rounded,
                        color: Colors.grey[300],
                        weight: 2,
                        size: 18,
                      ),
                    ),
                  ),
                ]),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              body,
              style: TextStyle(color: Colors.grey[300], fontSize: 16),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
