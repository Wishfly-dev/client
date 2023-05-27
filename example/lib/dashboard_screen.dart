import 'package:example/counter_screen.dart';
import 'package:example/wishfly_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  const DashboardScreen({required this.toggleTheme, super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int index = 0;

  final screens = [const CounterScreen(), const WishflyScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.brightness_4,
              color: Colors.white,
            ),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedLabelStyle:
            const TextStyle(color: Colors.white, fontSize: 14),
        currentIndex: index,
        onTap: (i) {
          setState(() => index = i);
        },
        items: [
          BottomNavigationBarItem(
            label: "Counter",
            icon: Icon(
              Icons.plus_one,
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            ),
          ),
          BottomNavigationBarItem(
            label: "Features",
            icon: Icon(
              Icons.feedback,
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
