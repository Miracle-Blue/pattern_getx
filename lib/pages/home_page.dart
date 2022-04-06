import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pattern_getx/controllers/home_controller.dart';
import 'package:pattern_getx/views/item_home_post.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  static const id = "/home_page";
  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get X"),
      ),
      body: GetX<HomeController>(
        init: HomeController(),
        builder: (_controller) {
          return Stack(
            children: [
              ListView.separated(
                itemCount: _controller.items.length,
                itemBuilder: (ctx, index) {
                  return ItemOfHome(
                    post: _controller.items[index],
                    update: (context) => _controller.openCreateEditPage(controller: _controller,
                        post: _controller.items[index]),
                    delete: (context) =>
                        _controller.apiPostDelete(_controller.items[index]),
                  );
                }, separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.black),
              ),
              _controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () => _controller.openCreateEditPage(controller: _controller),
        child: const Icon(Icons.add),
      ),
    );
  }
}
