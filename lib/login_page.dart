import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String storedValue = "";
  String storedValue1 = "";

  @override
  void initState() {
    super.initState();
    storevalue();
  }

  storevalue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      storedValue = prefs.getString('username') ?? 'DefaultUsername';
      storedValue1 = prefs.getString('password') ?? 'Defaulpassword';
    });
  }

  saveValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', userNameController.text);
    prefs.setString('password', passwordController.text);
    storevalue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Shared Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userNameController,
              decoration: const InputDecoration(hintText: 'Enter Username'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: 'Enter Password'),
              obscureText: true,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(height: 16.0),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              onPressed: saveValue,
              child: const Text('Login'),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('shared to local: $storedValue'),
            const SizedBox(
              height: 10,
            ),
            Text('shared to local: $storedValue1'),
          ],
        ),
      ),
    );
  }
}