import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:stalker93/account.dart';
import 'package:stalker93/proxy.dart';

// Keeps a stalker engine.
class Stalker {
  final List<Account> _accounts = [];
  final List<ProxyServer> _proxies = [];
  bool _isRunning = false;

  Stalker();

  // Adds an account to the stalker.
  void addAccount(Account account) {
    _accounts.add(account);
  }

  // Adds a proxy server to the stalker.
  void addProxy(ProxyServer proxy) {
    _proxies.add(proxy);
  }

  bool get isRunning => _isRunning;

  // Spawns a thread that stalks a single account.
  Future<void> _stalkAccount(Account account) async {
    // Randomly selects a proxy server.
    var random = Random();
    var proxy = _proxies[random.nextInt(_proxies.length)];

    // Stalks the account.
    while (_isRunning) {
      // Stalks the account using the proxy server.
      // Create a new HttpClient object.
      var client = HttpClient();
      // Set the proxy server.
      client.findProxy = (uri) {
        return 'PROXY ${proxy.host}:${proxy.port}';
      };
      // periodically checks the account from Instagram.
      // build an account url
      var url = 'https://www.instagram.com/${account.username}/';
      // Create a new HttpClientRequest object.
      var request = await client.getUrl(Uri.parse(url));
      // Send the request.
      var response = await request.close();
      // Read the response.
      var responseBody = await response.transform(utf8.decoder).join();

      // fetch the additional resources it needs.
      // Parse the response body.
      var followers = 0, following = 0, posts = 0;
      // Parse the response body.
      // Extract the followers, following, and posts.
      // find the followers
      // good luck while parsing the ReactJS output
      var followersMatch = RegExp(r'"edge_followed_by":{"count":(\d+)}')
          .firstMatch(responseBody);
    }
  }

  // Starts the stalker.
  void start() {}
}
