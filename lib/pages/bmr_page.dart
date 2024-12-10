import 'package:flutter/material.dart';

class BmrPage extends StatefulWidget {
  @override
  _BmrPageState createState() => _BmrPageState();
}

class _BmrPageState extends State<BmrPage> {
  String gender = "female";
  int age = 24;
  int weight = 63;
  double height = 170;
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0,
        title: const Text(
          'BMR Calculator',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              backgroundImage: AssetImage('images/profile.png'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                    "Gender",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
            ),
            // Gender selection
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GenderSelection(
                    icon: Icons.female,
                    label: "Female",
                    isSelected: gender == "female",
                    onTap: () => setState(() => gender = "female"),
                    colorLogo: Colors.pink,
                    colorText: Colors.pink,
                  ),
                  GenderSelection(
                    icon: Icons.male,
                    label: "Male",
                    isSelected: gender == "male",
                    onTap: () => setState(() => gender = "male"),
                    colorLogo: Colors.cyan,
                    colorText: Colors.cyan,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Age and Weight Inputs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NumberInput(
                  label: "Age",
                  value: age,
                  onIncrease: () => setState(() => age++),
                  onDecrease: () => setState(() => age--),
                ),
                NumberInput(
                  label: "Weight",
                  value: weight,
                  onIncrease: () => setState(() => weight++),
                  onDecrease: () => setState(() => weight--),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Height Slider
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Height",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: height,
                        min: 100,
                        max: 250,
                        divisions: 150,
                        label: "${height.toStringAsFixed(0)} cm",
                        onChanged: (newValue) =>
                            setState(() => height = newValue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // Activity Level Dropdown
            DropdownButtonFormField(
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
              value: selectedCategory,
              items: category
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7),
                        child: Text(
                          e,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
            ),
            Spacer(),
            // Calculate Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[400],
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                calculateBMR();
              },
              child: Text(
                "Calculate Now",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculateBMR() {
    double bmr;
    if (gender == "male") {
      bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else {
      bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Your BMR is ${bmr.toStringAsFixed(2)}'),
      ),
    );
  }
}

class GenderSelection extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final MaterialColor colorLogo;
  final MaterialColor colorText;

  const GenderSelection({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.colorLogo,
    required this.colorText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: isSelected ? colorLogo : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? colorText : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class NumberInput extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const NumberInput({
    required this.label,
    required this.value,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            IconButton(
              onPressed: onDecrease,
              icon: Icon(Icons.remove),
            ),
            Text(
              value.toString(),
              style: TextStyle(fontSize: 18),
            ),
            IconButton(
              onPressed: onIncrease,
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}

List<String> category = [
  'Sedentary: little or no exercise',
  'Light: exercise 1-3 times/week',
  'Moderate: exercise 4-5 times/week',
  'Active: daily exercise or intense exercise 3-4 times/week',
  'Very Active: intense exercise 6-7 times/week',
  'Extra Active: very intense exercise daily, or physical job',
];
