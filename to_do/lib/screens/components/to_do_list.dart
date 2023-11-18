import 'package:flutter/material.dart';
import 'package:to_do/db/supabase_db.dart';
import 'package:to_do/models/to_do_model.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key, required this.todoList, required this.index}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
  final List<ToDo> todoList;
  final int index;
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(right: 8, left: 16),
      leading: Checkbox(
          onChanged: (value) {
            widget.todoList[widget.index].completed = !widget.todoList[widget.index].completed!;
            updateToDos(widget.todoList[widget.index]);
            setState(() {});
          },
          value: widget.todoList[widget.index].completed),
      title: Text("${widget.todoList[widget.index].title}",
          style: TextStyle(
              decoration: (widget.todoList[widget.index].completed!)
                  ? TextDecoration.lineThrough
                  : TextDecoration.none)),
      subtitle: Text(
        "${widget.todoList[widget.index].description}",
        style: TextStyle(
            decoration: (widget.todoList[widget.index].completed!)
                ? TextDecoration.lineThrough
                : TextDecoration.none),
      ),
    );
  }
}
