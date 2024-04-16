import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:logger/logger.dart';
import 'package:stalker93/account.dart';
import 'package:stalker93/proxy.dart';
import 'package:stalker93/scraper.dart';

// Keeps a stalker engine.
class Stalker {
  final List<Account> _accounts = [];
  final List<ProxyServer> _proxies = [];
  bool _isRunning = false;
  Duration _checkEvery;
  Logger _logger = Logger();

  Stalker({Duration checkEvery = const Duration(minutes: 10)})
      : _checkEvery = checkEvery {
    _isRunning = false;
    _logger = Logger();
  }

  // Adds an account to the stalker.
  void addAccount(Account account) {
    _accounts.add(account);
  }

  // Adds a proxy server to the stalker.
  void addProxy(ProxyServer proxy) {
    _proxies.add(proxy);
  }

  bool get isRunning => _isRunning;
  List<Account> get accounts => _accounts;

  // Spawns a thread that stalks a single account.
  Future<void> _stalkAccount(Account account) async {
    // if there are any proxies listed, pick a random one.
    ProxyServer? proxy;
    if (_proxies.isNotEmpty) {
      var random = Random();
      proxy = _proxies[random.nextInt(_proxies.length)];
    }

    // Stalks the account.
    while (_isRunning) {
      // Stalks the account using the proxy server.
      // Create a new HttpClient object.
      var client = HttpClient();
      // Set the proxy server if one is going to be used.
      if (proxy != null) {
        client.findProxy = (uri) {
          return 'PROXY ${proxy!.host}:${proxy.port}';
        };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return true;
        };
      }
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

      // initialize a scraper engine.
      var scraper = Scraper();
      // scrape the followers count
      followers = scraper.scrapeFollowers(responseBody);
      // scrape the following count
      following = scraper.scrapeFollowing(responseBody);
      // scrape the posts count
      posts = scraper.scrapePosts(responseBody);

      // Record the account state.
      account.recordState(followers, following, posts);
    }
  }

  // the lifecycle function that will be
  // periodically called when the stalker is running.
  void _stalkerLoop() {
    // for each account, stalk the account.

    List<Future<void>> stalkers = [];
    for (var account in _accounts) {
      stalkers.add(_stalkAccount(account));
    }

    Future.wait(stalkers).then((_) {
      if (_isRunning) {
        // Schedule the next loop.
        Future.delayed(_checkEvery, _stalkerLoop).then((_) {});
      }
    });
  }

  // Starts the stalker.
  void start() {
    _isRunning = true;

    while (_isRunning) {
      _stalkerLoop();
    }
  }
}
