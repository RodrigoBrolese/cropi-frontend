import 'package:flutter/material.dart';
import 'package:cropi/src/features/notification/bloc/bloc.dart';

class NotificationBody extends StatelessWidget {
  const NotificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        if (state is NotificationInitial) {
          context.read<NotificationBloc>().add(const LoadNotificationEvent());
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return state.notifications.isEmpty
            ? const Center(
                child: Text('Não há notificações'),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  var notification = state.notifications[index];
                  return Card(
                    child: ListTile(
                      title: Text(notification['message'] ?? 'Erro'),
                      subtitle: Text(notification['create_date'] ?? 'Erro'),
                    ),
                  );
                },
              );
      },
    );
  }
}
