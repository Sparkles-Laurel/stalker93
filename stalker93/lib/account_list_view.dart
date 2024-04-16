// account_list_view - Account List View activity

import 'package:flutter/material.dart';
import 'package:stalker93/account.dart';

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
              Navigator.pushNamed(context, '/account',
                  arguments: accounts[index]);
            });
      },
    );
  }
}
