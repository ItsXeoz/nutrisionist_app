import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nutrisionist_app/pages/bmr_page.dart';
import 'package:nutrisionist_app/pages/dailyCalories_page.dart';
import 'package:nutrisionist_app/pages/home_page.dart';

class MainPage extends StatefulWidget {
  final int? bottomNavIdx;
  const MainPage({super.key, this.bottomNavIdx});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController searchController = TextEditingController();
  int myIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.bottomNavIdx != null) {
      myIndex = widget.bottomNavIdx!;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  final List<Widget> tabs = [
    HomePage(),
    DailyCaloriePage(dailyCalorieNeed: 1000),
    BmrPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[myIndex], // Menampilkan halaman sesuai indeks
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.green[400]!,
        animationDuration: const Duration(milliseconds: 300),
        index: myIndex,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.local_fire_department_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.calculate_outlined,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
