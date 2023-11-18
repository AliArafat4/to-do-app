import 'package:flutter/material.dart';
import 'package:to_do/db/supabase_db.dart';
import 'package:to_do/models/to_do_model.dart';
import 'package:to_do/screens/widgets/custom_text_field.dart';

void addToDoBottomSheet(
    BuildContext context, List<ToDo> todoList, Function loadData) {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String> status = ["Not completed", "Completed"];
  String selectedStatus = "Not completed";
  bool fieldIsEmpty = false;
  showModalBottomSheet(
    context: context,
    useSafeArea: true,
    isDismissible: true,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(hint: 'Title', controller: titleController),
              CustomTextField(
                  hint: 'Description',
                  lines: 7,
                  controller: descriptionController),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    2,
                    (index) => Row(
                      children: [
                        Radio(
                            value: status[index],
                            groupValue: selectedStatus,
                            onChanged: (value) {
                              selectedStatus = value!;
                              setState(() {});
                            }),
                        Text(status[index]),
                      ],
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (titleController.text.trim().isNotEmpty &&
                        descriptionController.text.trim().isNotEmpty) {
                      fieldIsEmpty = false;
                      addToDos(ToDo(
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          completed:
                              (selectedStatus == "Completed") ? true : false,
                          id: todoList.isNotEmpty ? todoList.last.id + 1 : 1,
                          createdAt: "${DateTime.now()}"));
                      await loadData.call();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Added successfully")));
                    } else {
                      //TODO: ERROR
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * .55),
                          content: const Text("Please fill the fields")));
                    }
                  },
                  child: const Text("Add"))
            ],
          ),
        );
      });
    },
  );
}
