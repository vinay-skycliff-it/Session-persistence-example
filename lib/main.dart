import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _luckyNumber = "lucky_number";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Session Persistence Demo',
      home: SessionPersistenceDemo(),
    );
  }
}

class SessionPersistenceDemo extends StatefulWidget {
  const SessionPersistenceDemo({super.key});

  @override
  SessionPersistenceDemoState createState() => SessionPersistenceDemoState();
}

class SessionPersistenceDemoState extends State<SessionPersistenceDemo> {
  late final SharedPreferences prefs;
  final controller = TextEditingController();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();
    fetchLuckyNumber();
  }

  void fetchLuckyNumber() {
    final result = prefs.getString(_luckyNumber);
    controller.text = result ?? "";
  }

  Future<void> saveLuckyNumber(String value) async {
    await prefs.setString(_luckyNumber, value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Persistence Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Lucky number",
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              onChanged: saveLuckyNumber,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: "Enter lucky number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
