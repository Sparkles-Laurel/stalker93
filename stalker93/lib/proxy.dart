// proxy.dart - keeps proxy server related types.

import 'dart:io';
import 'dart:async';
import 'dart:convert';

// keeps data about a proxy server
class ProxyServer {
  String? host;
  int? port;
  String? username;
  String? password;

  ProxyServer(this.host, this.port, this.username, this.password);
  ProxyServer.parse(String proxyString) {
    var parts = proxyString.split(':');
    this.host = parts[0];
    this.port = int.parse(parts[1]);
    username = parts[2];
    password = parts[3];
  }
}
