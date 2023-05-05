import 'package:example/counter_screen.dart';
import 'package:example/wishfly_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int index = 0;

  final screens = const [CounterScreen(), WishflyScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter"),
        backgroundColor: Colors.black,
      ),
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        currentIndex: index,
        onTap: (i) {
          setState(() => index = i);
        },
        items: const [
          BottomNavigationBarItem(
            label: "Counter",
            icon: Icon(Icons.plus_one, color: Colors.black),
          ),
          BottomNavigationBarItem(
            label: "Features",
            icon: Icon(Icons.feedback, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
