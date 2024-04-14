import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:stalker93/account.dart';
import 'package:stalker93/proxy.dart';

// Keeps a stalker engine.
class Stalker {
  final List<Account> _accounts = [];
  final List<ProxyServer> _proxies = [];
}
