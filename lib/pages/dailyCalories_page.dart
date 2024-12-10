import 'package:flutter/material.dart';

class DailyCaloriePage extends StatefulWidget {
  final double dailyCalorieNeed;

  DailyCaloriePage({required this.dailyCalorieNeed});

  @override
  _DailyCaloriePageState createState() => _DailyCaloriePageState();
}

class _DailyCaloriePageState extends State<DailyCaloriePage> {
  double consumedCalories = 0;
  final TextEditingController foodController = TextEditingController();
  final TextEditingController calorieController = TextEditingController();

  void addCalories() {
    if (foodController.text.isNotEmpty && calorieController.text.isNotEmpty) {
      double addedCalories = double.tryParse(calorieController.text) ?? 0;
      setState(() {
        consumedCalories += addedCalories;
      });
      foodController.clear();
      calorieController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Calories added successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Calorie Tracker'),
        backgroundColor: Colors.green[400],
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Your daily calorie need: ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Progress bar
            Container(
              height: 100,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    "Consumed: ${consumedCalories.toStringAsFixed(0)} / ${widget.dailyCalorieNeed.toStringAsFixed(0)} kcal",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: consumedCalories / widget.dailyCalorieNeed,
                    minHeight: 10,
                    backgroundColor: Colors.grey[300],
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Form to add food and calories
            Text(
              "Add Consumed Food:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: foodController,
              decoration: InputDecoration(
                labelText: "Food Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: calorieController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Calories (kcal)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Add calories button
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[400],
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {},
              child: Text(
                "Calculate Now",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            // Reset progress button
          ],
        ),
      ),
    );
  }
}
