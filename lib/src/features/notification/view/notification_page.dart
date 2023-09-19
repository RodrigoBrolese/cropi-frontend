import 'package:cropi/src/widgets/templates/layout.dart';
import 'package:flutter/material.dart';
import 'package:cropi/src/features/notification/bloc/bloc.dart';
import 'package:cropi/src/features/notification/widgets/notification_body.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const NotificationPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc(),
      child: const Scaffold(
        body: NotificationView(),
      ),
    );
  }
}

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Layout(
      body: NotificationBody(),
      title: 'Notificações',
      showBackButton: true,
      hideNotifications: true,
    );
  }
}
