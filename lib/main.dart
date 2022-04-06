import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:pattern_getx/pages/create_edit_page.dart';
import 'package:pattern_getx/pages/home_page.dart';
import 'package:pattern_getx/services/bind_service.dart';
import 'package:pattern_getx/services/di_service.dart';

Future main() async {
  await DIService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pattern GetX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      initialBinding: ControllersBinding(),
      getPages: [
        GetPage(
          name: HomePage.id,
          page: () => HomePage(),
          binding: ControllersBinding(),
        ),
        GetPage(
          name: CreateEditPage.id,
          page: () => const CreateEditPage(),
          binding: ControllersBinding(),
        )
      ],
    );
  }
}
