// Test the stalker class
// Test over the official Meta account.
import 'package:stalker93/stalker.dart';
import 'package:stalker93/account.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Stalker test', () async {
    var stalker = Stalker(checkEvery: const Duration(seconds: 1));
    stalker.addAccount(Account('meta'));
    stalker.start();
  });
}
