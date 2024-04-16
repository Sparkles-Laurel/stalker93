import 'package:flutter/material.dart';
import 'package:stalker93/stalker.dart';
import 'package:stalker93/account_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'stalker93',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.greenAccent).copyWith(
          brightness: MediaQuery.of(context).platformBrightness,
        ),
        primarySwatch: Colors.green,
        // use platform color scheme (light/dark mode)
        useMaterial3: true,
      ),
      home: const MyHomePage(
          title: 'stalker93', subtitle: 'A stalker for the shameless.'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextEditingController _usernameController = TextEditingController();
  final Stalker _stalker = Stalker();
  bool _isStalking = false;
  void _initStalker() {
    // _stalker.start();
    _isStalking = !_isStalking;
  }

  void _showAccountList(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AccountListView(accounts: _stalker.accounts);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Text(widget.subtitle,
              style: Theme.of(context).textTheme.titleSmall),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // let there be a text input for account username
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter username',
              ),
              controller: _usernameController,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _initStalker,
        tooltip: _isStalking ? 'Stop stalking' : 'Start stalking',
        child: Icon(_isStalking ? Icons.stop : Icons.play_arrow),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
