//import 'package:custom_transition_route/helpers/route_transitions.dart';
import 'package:custom_transition_route/pages/page2.dart';
import 'package:flutter/material.dart';
import 'package:route_transitions_cfalavarezb/route_transitions_cfalavarezb.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: MaterialButton(
          color: Colors.white,
          onPressed: () {
            //Navigator.push(context, MaterialPageRoute(builder: (_) => const Page2() ));
            //Navigator.pushNamed(context, 'page2');

            RouteTransitionCfalavarezb(
              context: context,
              child: const Page2(),
              animation: AnimationType.fadeIn,
              //duration: const Duration( seconds: 2 )
              replacement: false
            );
          },
          child: const Text('Go to page 2')
        )
      ),
    );
  }
}