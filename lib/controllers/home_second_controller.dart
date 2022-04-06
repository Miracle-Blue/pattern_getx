import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_todo_service/http_todo_service.dart';
import 'package:pattern_getx/pages/create_edit_page.dart';

class HomeSecondController extends GetxController {
  var isLoading = false;
  var items = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  void isLoad(bool load) {
    isLoading = load;
    update();
  }

  void apiPostLoadList() async {
    isLoad(true);

    var response = await HttpService.GET(
      HttpService.API_LIST,
      HttpService.paramsEmpty(),
    );

    if (response != null) {
      items = HttpService.parsePostList(response);
    } else {
      items = [];
    }

    isLoad(false);
  }

  void apiPostDelete(Post post) async {
    isLoad(true);

    await HttpService.DEL(
      HttpService.API_DELETE + post.id.toString(),
      HttpService.paramsEmpty(),
    );

    apiPostLoadList();
  }

  void apiPostCreate(BuildContext context) async {
    isLoad(true);

    Post newPost = Post();

    newPost.title = titleController.text.trim().toString();
    newPost.body = bodyController.text.trim().toString();

    var response = await HttpService.POST(
      HttpService.API_CREATE,
      HttpService.paramsCreate(newPost),
    );

    isLoad(false);

    titleController.clear();
    bodyController.clear();

    if (response != null) {
      Get.back(result: true);
    }
  }

  Future<void> apiPostEdit(BuildContext context, Post post) async {
    isLoad(true);

    post.title = titleController.text.trim().toString();
    post.body = bodyController.text.trim().toString();

    await HttpService.PUT(
      HttpService.API_CREATE,
      HttpService.paramsUpdate(post),
    );

    isLoad(false);

    titleController.clear();
    bodyController.clear();

    Get.back(result: true);
  }

  void openCreateEditPage({required HomeSecondController homeSecondController, Post? post}) async {
    var _result;

    if (post == null) {
      _result = await Get.to(CreateEditPage());
    } else {
      _result = await Get.to(CreateEditPage(post: post));
    }

    if (_result == true) {
      apiPostLoadList();
    }
  }
}