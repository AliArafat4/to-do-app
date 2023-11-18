import 'package:flutter/material.dart';
import 'package:to_do/db/supabase_db.dart';
import 'package:to_do/models/to_do_model.dart';
import 'package:to_do/screens/widgets/custom_text_field.dart';

void addToDoBottomSheet(BuildContext context, List<ToDo> todoList, Function loadData) {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  showModalBottomSheet(
    context: context,
    useSafeArea: true,
    isDismissible: true,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(hint: 'Title', controller: titleController),
            CustomTextField(hint: 'Description', lines: 7, controller: descriptionController),
            ElevatedButton(
                onPressed: () async {
                  if (titleController.text.trim().isNotEmpty &&
                      descriptionController.text.trim().isNotEmpty) {
                    addToDos(ToDo(
                        title: titleController.text.trim(),
                        description: descriptionController.text.trim(),
                        completed: false,
                        id: todoList.last.id + 1,
                        createdAt: "${DateTime.now()}"));
                    await loadData.call();
                  } else {
                    //TODO: ERROR
                  }
                },
                child: const Text("Add"))
          ],
        ),
      );
    },
  );
}
