// account_list_view - Account List View activity

import 'package:flutter/material.dart';
import 'package:stalker93/account.dart';
import 'package:stalker93/account_history_view.dart';

class AccountListView extends StatelessWidget {
  final List<Account> accounts;

  const AccountListView({super.key, required this.accounts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text(accounts[index].username!),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AccountHistoryView(account: accounts[index]);
              }));
            });
      },
    );
  }
}
