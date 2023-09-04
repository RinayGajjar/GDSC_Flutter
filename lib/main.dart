import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController(); //ability to create all the variable once
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose(); //disposing the controllers to empty the space
    _password.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: InputDecoration(hintText: 'Enter your email here'),
          ),
          TextField(
            controller: _password, //assigining texts to the controller
            obscureText: true, //creating privacy for password
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType
                .emailAddress, //creating at the rate sign for email only in the keyboard
            decoration: InputDecoration(hintText: 'Enter your password here'),
          ),
          TextButton(
            onPressed: () async {
              //function that the button when will do when its pressed
              await Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
              );
              final email = _email.text;
              final password = _password.text;
              final UserCredential = await FirebaseAuth
                  .instance //creating user who would enter hus email or password...
                  .createUserWithEmailAndPassword(
                      email: email, password: password);
              print(UserCredential);
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
