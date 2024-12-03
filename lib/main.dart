import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticate() async {
    bool isAuthenticated = false;

    try {
      isAuthenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to access',
        options: const AuthenticationOptions(
            biometricOnly: true, // Allow only biometric authentication
            sensitiveTransaction: true,
            stickyAuth: true),
      );
      if (isAuthenticated) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Authenticated'),
            content: Text('You have been authenticated successfully!'),
          ),
        );
      }
    } catch (e) {
      print('Error during authentication: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF192359),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF192359),
        title: Text('Biometric Authentication'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Use your Fingerprint to log into the App!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                onPressed: _authenticate,
                icon: Icon(Icons.fingerprint),
                label: Text('Authenticate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
