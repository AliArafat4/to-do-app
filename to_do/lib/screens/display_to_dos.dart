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
  Future? futureToDo;
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    todoList = await getToDos();
    futureToDo = getToDos();
    Future.delayed(const Duration(milliseconds: 200), () => setState(() {}));
  }

  void data() async {
    todoList = await getToDos();
    futureToDo = getToDos();
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
      body: FutureBuilder(
          future: futureToDo,
          builder: (context, snapshot) {
            print("object");
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      snapshot.data![index].completed =
                          !snapshot.data![index].completed!;
                      updateToDos(snapshot.data![index]);
                      setState(() {});
                    },
                    child: Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) => confirmDismissDialog(
                          context, index, snapshot.data![index].title!),
                      onDismissed: (direction) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "${snapshot.data![index].title} deleted successfully")));

                        deleteToDos(snapshot.data![index]);
                        data();
                      },
                      child: ToDoList(index: index, todoList: snapshot.data!),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
