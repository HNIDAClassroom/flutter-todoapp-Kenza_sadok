import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import '../services/firestore.dart';
import 'widgets/task_item.dart';
/*
class TaskItem extends StatefulWidget {
  final Task task;
  TaskItem(this.task);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: widget.task.isCompleted,
                  onChanged: (bool? newValue) {
                    if (newValue != null) {
                      firestoreService.updateTaskByTitle(
                          widget.task.title, newValue);
                      setState(() {
                        widget.task.isCompleted = newValue;
                      });
                    }
                  },
                  activeColor: Colors.green,
                  checkColor: Colors.white,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.task.title,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Text(widget.task.description),
                    ],
                  ),
                ),
                const SizedBox(width: 30),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: ${widget.task.date}',
                          textAlign: TextAlign.left),
                      const SizedBox(height: 5),
                      Text('Category: ${widget.task.category.name}',
                          textAlign: TextAlign.left),
                    ],
                  ),
                ),
                Spacer(),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirmez la suppression"),
                          content: Text(
                              "Êtes-vous sûr de vouloir supprimer cette tâche ?"),
                          actions: <Widget>[
                            TextButton(
                              child: Text("Oui"),
                              onPressed: () {
                                // Supprimez la tâche ici
                                firestoreService.deleteTask(widget.task.title);
                                Navigator.of(context)
                                    .pop(); // Ferme la boîte de dialogue
                              },
                            ),
                            TextButton(
                              child: Text("Non"),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Ferme la boîte de dialogue
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/

class TasksList extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();
  TasksList({super.key, required this.tasks});
  final List<Task> tasks;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getTasks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final taskLists = snapshot.data!.docs;
          List<Task> taskItems = [];
          for (int index = 0; index < taskLists.length; index++) {
            DocumentSnapshot document = taskLists[index];
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          /*  String title = data['taskTitle'];
            String description = data['taskDesc'];
            DateTime date = DateTime.parse(data['taskDate']);
            String categoryString = data['taskCategory'];*/
            
            if (data.containsKey('taskTitle') &&
                data.containsKey('taskDesc') &&
                data.containsKey('taskDate') &&
                data.containsKey('taskCategory')) {
              String title = data['taskTitle'];
              String description = data['taskDesc'];
              DateTime date = DateTime.parse(data['taskDate']);
              String categoryString = data['taskCategory'];
              Category category;
              switch (categoryString) {
                case 'personal':
                  category = Category.personal;
                  break;
                case 'work':
                  category = Category.work;
                  break;
                case 'shopping':
                  category = Category.shopping;
                  break;
                default:
                  category = Category.others;
              }
              Task task = Task(
                title: title,
                description: description,
                date: date,
                category: category,
              );
              taskItems.add(task);
            }
          }
          return ListView.builder(
            itemCount: taskItems.length,
            itemBuilder: (ctx, index) {
              return TaskItem(taskItems[index]);
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator(); // Display a loading indicator while waiting for data.
        }
      },
    );
  }
}
