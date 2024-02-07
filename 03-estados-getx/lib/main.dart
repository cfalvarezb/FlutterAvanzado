import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:estados/pages/page1.dart';
import 'pages/page2.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'page1',
      // routes: {
      //   'page1' : (_) => const Page1(),
      //   'page2' : (_) => const Page2()
      // },
      getPages: [
        GetPage(name: '/page1', page: ()=> Page1()),
        GetPage(name: '/page2', page: ()=> Page2()),
      ],
    );
  }
}