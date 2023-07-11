import 'package:authentications/services/todo/todo_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/todo/todo_model.dart';
import '../commons/common_widget.dart';
import '../commons/todo_tile.dart';
import '../todo/todo_form_screen.dart';

class HomeScreen extends GetView<TodoService> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo - Application"),
        actions: [
          IconButton(onPressed: () async{
            await controller.authService.logout();
            Get.offNamed('/login');
          }, icon: const Icon(Icons.logout))
        ],
      ),
      body: Obx(
            () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text('Todo List', style: CommonWidget.titleText()),
            ),
            Expanded(
              child: controller.isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : controller.todoList.isEmpty
                  ? const Center(
                child: Center(child: Text('No todo list!')),
              )
                  : SingleChildScrollView(
                controller: controller.scrollController,
                child: Column(
                  children: [
                    ...controller.todoList.map((e) => _todo(e)).toList(),
                    controller.isLoadMore ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ):const SizedBox(width: 0,)
                  ],
                ),
              ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateBottomSheet,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _todo(TodoModel todo) {
    return TodoTile(
      id: todo.id!,
      onTap: (id) async{
        final data = await controller.getTodoById(id);
        if(data == null) return;
        controller.detailModel = data;
        final createdUser = await controller.userService.userRepository.getById(data.userId);
        if(createdUser == null) return;
        controller.createdUser = createdUser;
        Get.toNamed('/todo-details');
      },
      icon: Icon(
        Icons.task,
        size: 35,
        color: CommonWidget.appColors,
      ),
      title: todo.title,
      description: todo.description,
      trailing: [
        controller.authService.principal.id == todo.userId ?
        CircleAvatar(
          radius: 18,
          child: IconButton(
            onPressed: () {
              _showUpdateBottomSheet(todo);
            },
            icon: const Icon(
              Icons.edit,
              size: 18,
            ),
          ),
        ):
        const SizedBox(width: 0,),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.pink,
            child: IconButton(
              onPressed: () {
                _openConfirmDelete(todo.id!);
              },
              icon: const Icon(
                Icons.delete,
                size: 18,
              ),
            ),
          ),
        )
      ],
    );
  }

  void _showCreateBottomSheet() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: Get.mediaQuery.viewInsets.bottom),
            child: TodoFormScreen(
              formKey: controller.formKey,
              titleController: controller.titleController,
              descriptionController: controller.descriptionController,
              isUpdate: false,
              onSubmit: (model) async {

                await controller.createTodo(model);
                Get.back();
              },
            ),
          ),
        ),
      ),
    ).whenComplete(() {
      controller.titleController.clear();
      controller.descriptionController.clear();
    });
  }

  void _showUpdateBottomSheet(TodoModel todo) {
    controller.titleController.text = todo.title;
    controller.descriptionController.text = todo.description;

    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: Get.mediaQuery.viewInsets.bottom),
            child: TodoFormScreen(
              formKey: controller.formKey,
              titleController: controller.titleController,
              descriptionController: controller.descriptionController,
              isUpdate: true,
              onSubmit: (model) async {
                model.id = todo.id;
                await controller.updateTodo(todo.id!, model);
                Get.back();
              },
            ),
          ),
        ),
      ),
    ).whenComplete(() {
      controller.titleController.clear();
      controller.descriptionController.clear();
    });
  }

  void _openConfirmDelete(int id) {
    Get.dialog(Dialog(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Are you sure you want to delete todo!',
                      style: CommonWidget.secondaryTitleText()),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: CommonWidget.secondaryButtonStyle(),
                          child: const Text('Cancel')),
                      ElevatedButton(
                          onPressed: () async {
                            bool isDeleted = await controller.deleteTodo(id);
                            if (isDeleted) {
                              controller.todoList
                                  .removeWhere((todo) => todo.id == id);
                            }
                            Get.back();
                          },
                          style: CommonWidget.dangerButtonStyle(),
                          child: const Text('Delete')),
                    ],
                  ),
                )
              ],
            ))));
  }
}