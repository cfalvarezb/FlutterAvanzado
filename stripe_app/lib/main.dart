import 'package:flutter/material.dart';
import 'package:stripe_app/pages/complete_pay_page.dart';
import 'package:stripe_app/pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StripeApp',
      initialRoute: 'home',
      routes: {
        'home': ( _ ) => const HomePage(),
        'complete_pay':( _ ) => const CompletePayPage()
      },
      theme: ThemeData.light().copyWith(
        primaryColor: const Color(0xff284879),
        scaffoldBackgroundColor: const Color(0xff21232A)
      ),
    );
  }
}