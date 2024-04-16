// AccountHistoryView - account history view activity

import 'package:flutter/material.dart';
import 'package:stalker93/account.dart';

class AccountHistoryView extends StatelessWidget {
  final Account account;

  const AccountHistoryView({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: account.states.length,
      itemBuilder: (context, index) {
        return ListTile(
          subtitle: Text(account.states[index].recordedAt.toString()),
          title: Text(
              'Followers: ${account.states[index].followers}, Following: ${account.states[index].following}, Posts: ${account.states[index].postCount}'),
        );
      },
    );
  }
}
