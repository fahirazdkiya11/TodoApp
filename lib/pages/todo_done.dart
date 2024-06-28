import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/utils/network_manager.dart';
import 'package:todo_app/widgets/item_widget.dart';

class ToDoDonePage extends StatefulWidget {
  const ToDoDonePage({super.key});

  @override
  State<ToDoDonePage> createState() => _ToDoDonePageState();
}

class _ToDoDonePageState extends State<ToDoDonePage> {
  List<ToDoItem> todos = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    NetworkManager().getToDoIsDone(true).then((value) {
      todos = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To Do List Done',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'To Do Done',
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todoItem = todos[index];
                    return ToDoWidget(toDoItem: todoItem, handleRefresh: () {});
                  }),
            )
          ],
        ),
      ),
    );
  }
}