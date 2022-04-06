import 'package:flutter/material.dart';
import 'package:http_todo_service/http_todo_service.dart';
import 'package:pattern_getx/controllers/home_controller.dart';

class CreateEditPage extends StatelessWidget {
  const CreateEditPage({Key? key, this.controller, this.post}) : super(key: key);

  static const id = "/create_edit_page";
  final HomeController? controller;
  final Post? post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post != null ? "Edit Post" : "Create Post"),
        actions: [
          TextButton(
            onPressed: () {
              post != null
                  ? controller!.apiPostEdit(post!)
                  : controller!.apiPostCreate();
            },
            child: Text(
              post != null ? "Save" : "Create",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: post != null
                  ? (controller!.titleController..text = post!.title!)
                  : controller!.titleController,
              decoration: const InputDecoration(
                hintText: "Title",
              ),
            ),
            TextField(
              controller: post != null
                  ? (controller!.bodyController..text = post!.body!)
                  : controller!.bodyController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Body",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
