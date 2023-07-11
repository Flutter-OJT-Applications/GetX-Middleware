import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../services/todo/todo_service.dart';
import '../commons/common_widget.dart';

class TodoDetailScreen extends StatelessWidget{

  const TodoDetailScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoService>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(controller.detailModel.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Card(
            color: Colors.blue.shade200,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Todo', style: CommonWidget.titleText(),),
                  const Divider(height: 15, color: Colors.black),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Title', style: CommonWidget.secondaryTitleText()),
                        const SizedBox(height: 10,),
                        Text(controller.detailModel.title)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.createdUser.name??'', style: CommonWidget.secondaryTitleText()),
                        Text(DateFormat('yyyy-MM-dd').format(controller.detailModel.createdAt??DateTime.now()))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Description', style: CommonWidget.secondaryTitleText()),
                            Text(controller.detailModel.description)
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },);
  }
}