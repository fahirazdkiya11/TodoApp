import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_item.dart';
import 'package:todo_app/pages/from_page.dart';
import 'package:todo_app/pages/todo_done.dart';
import 'package:todo_app/utils/network_manager.dart';
import 'package:todo_app/widgets/item_widget.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  List<ToDoItem> todos = [];
  bool isLoading = false;
  int totalDone = 0;

  void refreshData() {
    setState(() {
      isLoading = true;
    });
    // Ini buat ambil/ get data ynag sudah selesai
    NetworkManager().getToDoIsDone(true).then((value) {
      totalDone = value.length;
      setState(() {});
      // ambil data yang belum selesai
      NetworkManager().getToDoIsDone(false).then((value) {
        todos = value;
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Engine ToDo List',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black38,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'To do List kamu ...',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ToDoDonePage();
                    }));
                  },
                  child: Text(
                    'List selesai : $totalDone',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: todos.isEmpty
                        ? const Center(
                            child: Text('To Do List Masih Kosong !'),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return ToDoWidget(
                                 toDoItem: todos[index],
                                handleRefresh: refreshData,
                              );
                            },
                            itemCount: todos.length,
                          ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const FormPage();
          }));
          refreshData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
