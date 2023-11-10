import 'package:flutter/material.dart';
import '../services/firestore.dart';
import '../models/task.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(this.task, {super.key});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(16.0),
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.add_task_rounded),
                    SizedBox(width: 10),
                    Flexible(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task.title,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text(task.description),
                      ],
                    )),
                    Flexible(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task.title,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text(task.description),
                      ],
                    )),
                  ],
                )
              ],
            )));
  }
}
