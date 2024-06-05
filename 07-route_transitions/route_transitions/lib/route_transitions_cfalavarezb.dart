import 'package:flutter/material.dart';

/// Tipos de animaciones
enum AnimationType { normal, fadeIn, @Deprecated("Example of Deprecated") exampleDeprecated }

/// Main class, [context] es el BuildContext de la aplicacion en ese momento
/// [child] es el widget a navegar, [animation] es el tipo de animacion
///
class RouteTransitionCfalavarezb {
  final BuildContext context;
  final Widget child;
  final AnimationType animation;
  final Duration duration;
  final bool replacement;

  RouteTransitionCfalavarezb(
      {required this.context,
      required this.child,
      this.animation = AnimationType.normal,
      this.duration = const Duration(milliseconds: 300),
      this.replacement = false}) {
    switch (animation) {
      case AnimationType.normal:
        _normalTransition();
        break;
      case AnimationType.fadeIn:
        _fadeInTransition();
        break;
      default:
    }
  }

  /// Push normal de la pagina
  void _pushPage(Route route) => Navigator.push(context, route);

  /// Push replacement de la pagina
  void _pushReplacementPage(Route route) =>
      Navigator.pushReplacement(context, route);

  /// Code of normal transition
  void _normalTransition() {
    final route = MaterialPageRoute(builder: (_) => child);

    (replacement) ? _pushReplacementPage(route) : _pushPage(route);
  }

  /// Controller FadeIn Transition
  void _fadeInTransition() {
    final route = PageRouteBuilder(
      pageBuilder: (_, __, ___) => child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        );
      },
    );

    (replacement) ? _pushReplacementPage(route) : _pushPage(route);
  }
}
