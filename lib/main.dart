import 'package:flutter/material.dart';
import 'package:intercom_flutter/intercom_flutter.dart';

void main() async {
  // initialize the flutter binding.
  WidgetsFlutterBinding.ensureInitialized();
  // initialize the Intercom.
  // make sure to add keys from your Intercom workspace.
  await Intercom.initialize(
    'appIdHere',
    iosApiKey: 'iosKeyHere',
    androidApiKey: 'androidKeyHere',
  );
  runApp(
    const MaterialApp(
      home: App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Issue 118'),
      ),
      body: Center(
        child: Column(
          children: [
            if (_isLoggedIn) ...[
              // user is logged in
              // display open messenger and logout button
              // open messenger
              ElevatedButton(
                onPressed: () async {
                  await Intercom.displayMessenger();
                },
                child: const Text("Open Messenger"),
              ),
              // display logout button
              ElevatedButton(
                onPressed: () async {
                  await Intercom.logout();
                  setState(() {
                    _isLoggedIn = false;
                  });
                },
                child: const Text("Logout"),
              ),
            ] else ...[
              // display login button
              ElevatedButton(
                onPressed: () async {
                  await Intercom.registerUnidentifiedUser();
                  setState(() {
                    _isLoggedIn = true;
                  });
                },
                child: const Text("Login"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
