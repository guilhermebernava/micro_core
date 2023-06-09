import 'package:flutter/material.dart';
import 'package:micro_core/app/micro_app.dart';
import 'package:micro_core/app/utils.dart';

mixin BaseApp {
  List<MicroApp> get microApps;
  Map<String, WidgetBuilderArgs> get baseRoutes;
  final Map<String, WidgetBuilderArgs> routes = {};

  void registerRoutes() {
    if (baseRoutes.isNotEmpty) routes.addAll(baseRoutes);
    if (microApps.isNotEmpty) {
      for (var app in microApps) {
        routes.addAll(app.routes);
      }
    }
  }

  void registerInjections() {
    if (microApps.isNotEmpty) {
      for (var app in microApps) {
        app.injectionRegister();
      }
    }
  }

  Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    final routeName = routeSettings.name;
    final args = routeSettings.arguments;

    final route = routes[routeName];
    if (route == null) return null;

    return PageRouteBuilder(
      settings: routeSettings,
      pageBuilder: (ctx, __, ___) => route(ctx, args),
      transitionDuration: Duration(milliseconds: 600),
      transitionsBuilder: (_, a, __, c) => FadeTransition(
        opacity: a,
        child: c,
      ),
    );
  }
}
