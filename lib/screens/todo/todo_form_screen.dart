import 'package:flutter/material.dart';

import '../../models/todo/todo_model.dart';
import '../commons/common_widget.dart';

class TodoFormScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final FormSubmitCallback onSubmit;
  final bool isUpdate;

  const TodoFormScreen(
      {super.key,
      required this.formKey,
      required this.titleController,
      required this.descriptionController,
      required this.isUpdate,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(isUpdate ? 'Update Todo' : 'Create Todo',
                  style: CommonWidget.titleText()),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: titleController,
                decoration: CommonWidget.inputStyle(placeholder: 'Enter title'),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Title cannot be empty";
                  }
                  if(value.length < 4){
                    return "Title must be at least 4 characters";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: descriptionController,
                maxLines: 4,
                decoration:
                    CommonWidget.inputStyle(placeholder: 'Enter description',),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Description cannot be empty";
                  }
                  if(value.length < 10){
                    return "Description must be at least 10 characters";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        onSubmit(TodoModel(
                          title: titleController.text,
                          description: descriptionController.text,
                        ));
                      }
                    },
                    style: CommonWidget.primaryButtonStyle(),
                    child: Text(isUpdate ? "Update" : "Create"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
