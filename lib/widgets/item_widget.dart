import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/utils/network_manager.dart';

class ToDoWidget extends StatelessWidget {
  const ToDoWidget({
    Key? key,
    required this.toDoItem,
    required this.handleRefresh,
  }) : super(key: key);

  final ToDoItem toDoItem;
  final Function() handleRefresh;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: toDoItem.isDone ? Colors.grey : Colors.white30,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    toDoItem.title,
                    style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    toDoItem.description,
                    style: const TextStyle(
                      color: Colors.black12,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            if (!toDoItem.isDone)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                onPressed: () async {
                  await NetworkManager()
                      .updateData(toDoItem.copyWith(isDone: true));
                  handleRefresh();
                },
                child: const Icon(
                  Icons.done,
                ),
              ),
            const SizedBox(
              width: 10,
            ),
            if (!toDoItem.isDone)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  await NetworkManager().deleteData(toDoItem);
                  handleRefresh();
                },
                child: const Icon(
                  Icons.delete,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
