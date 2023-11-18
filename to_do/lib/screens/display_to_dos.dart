import 'package:flutter/material.dart';
import 'package:to_do/db/supabase_db.dart';
import 'package:to_do/models/to_do_model.dart';
import 'package:to_do/screens/components/to_do_list.dart';

import 'components/add_to_do_bottom_sheet.dart';
import 'components/confirm_dismiss_dialog.dart';

class DisplayToDos extends StatefulWidget {
  const DisplayToDos({
    super.key,
  });

  @override
  State<DisplayToDos> createState() => _DisplayToDosState();
}

bool isDone = false;
int selectedIndex = -1;

class _DisplayToDosState extends State<DisplayToDos> {
  List<ToDo> todoList = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    todoList = await getToDos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My TO-DO"),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
              onPressed: () {
                addToDoBottomSheet(context, todoList, getData);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              //TODO: CHANGE VAL IN DB
              todoList[index].completed = !todoList[index].completed!;
              updateToDos(todoList[index]);
              setState(() {});
            },
            child: Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) =>
                  confirmDismissDialog(context, index, todoList[index].title!),
              onDismissed: (direction) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${todoList[index].title} deleted successfully")));

                deleteToDos(todoList[index]);
                getData();
              },
              child: ToDoList(index: index, todoList: todoList),
            ),
          );
        },
      ),
    );
  }
}
