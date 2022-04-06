import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_todo_service/http_todo_service.dart';
import 'package:pattern_getx/pages/create_edit_page.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var items = <Post>[].obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    apiPostLoadList();
  }

  @override
  void onClose() {
    titleController.dispose();
    bodyController.dispose();
    super.onClose();
  }

  void apiPostLoadList() async {
    isLoading.value = true;

    var response = await HttpService.GET(
      HttpService.API_LIST,
      HttpService.paramsEmpty(),
    );

    if (response != null) {
      items.value = HttpService.parsePostList(response);
    } else {
      items.value = [];
    }

    isLoading.value = false;
  }

  void apiPostDelete(Post post) async {
    isLoading.value = true;

    await HttpService.DEL(
      HttpService.API_DELETE + post.id.toString(),
      HttpService.paramsEmpty(),
    );

    apiPostLoadList();
  }

  void apiPostCreate(BuildContext context) async {
    isLoading.value = true;

    Post newPost = Post();

    newPost.title = titleController.text.trim().toString();
    newPost.body = bodyController.text.trim().toString();

    var response = await HttpService.POST(
      HttpService.API_CREATE,
      HttpService.paramsCreate(newPost),
    );

    isLoading.value = false;

    titleController.clear();
    bodyController.clear();

    if (response != null) {
      Get.back(result: true);
    }
  }

  Future<void> apiPostEdit(BuildContext context, Post post) async {
    isLoading.value = true;

    post.title = titleController.text.trim().toString();
    post.body = bodyController.text.trim().toString();

    await HttpService.PUT(
      HttpService.API_CREATE,
      HttpService.paramsUpdate(post),
    );

    isLoading.value = false;

    titleController.clear();
    bodyController.clear();

    Get.back(result: true);
  }

  void openCreateEditPage({required HomeController controller, Post? post}) async {
    var _result;

    if (post == null) {
      _result = await Get.to(() => CreateEditPage(controller: controller));
    } else {
      _result = await Get.to(() => CreateEditPage(controller: controller, post: post));
    }

    if (_result == true) {
      apiPostLoadList();
    }
  }
}
