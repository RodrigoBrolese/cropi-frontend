import 'package:cropi/src/app/bloc/bloc.dart';
import 'package:cropi/src/features/login/login.dart';
import 'package:cropi/src/features/notification/notification.dart';
import 'package:cropi/src/features/plantations/plantations_list/view/plantations_list_page.dart';
import 'package:cropi/src/features/plantations/plantations_show/plantations_show.dart';
import 'package:cropi/src/features/register/register.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/plantations/plantations_create/plantations_create.dart';

class Route {
  const Route({
    required this.path,
    required this.name,
    required this.child,
  });

  final String path;
  final String name;
  final Widget child;
}

List<Route> menuRoutes = [
  const Route(path: '/plantations', name: 'home', child: PlantationsPage()),
];

GoRouter router = GoRouter(initialLocation: '/login', observers: [], routes: [
  GoRoute(
    path: '/',
    builder: (context, state) {
      return const LoginPage();
    },
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) {
      return const LoginPage();
    },
  ),
  ShellRoute(
    builder: (context, state, child) {
      if (context.read<AppBloc>().state.user == null) {
        return const LoginPage();
      }

      return child;
    },
    routes: [
      ...menuRoutes.map((route) => GoRoute(
            path: route.path,
            name: route.name,
            builder: (context, state) {
              return route.child;
            },
          )),
      GoRoute(
          path: '/plantations/create',
          builder: (context, state) {
            return const PlantationsCreatePage();
          }),
      GoRoute(
          path: '/plantations/create/success',
          builder: (context, state) {
            return const PlantationsCreateSuccessPage();
          }),
      GoRoute(
          path: '/plantations/:id',
          builder: (context, state) {
            return PlantationsShowPage(
                plantationId: state.pathParameters['id']!);
          }),
      GoRoute(
        path: '/notifications',
        builder: (context, state) {
          return const NotificationPage();
        },
      )
    ],
  ),
  GoRoute(
    path: '/register',
    builder: (context, state) {
      return const RegisterPage();
    },
  ),
  GoRoute(
    path: '/register/success',
    builder: (context, state) {
      return const RegisterSuccessPage();
    },
  ),
]);
