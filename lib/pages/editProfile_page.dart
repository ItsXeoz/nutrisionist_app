import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController namaLengkapController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController wController = TextEditingController();
  final TextEditingController hController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize weight controller with a default value
    wController.text = '167';
    namaLengkapController.text = 'Abidzar Giffari';
    genderController.text='Male';
    dobController.text='2024-07-01';
    wController.text='67';
    hController.text='173';
  }

  @override
  void dispose() {
    // Dispose controllers to free resources
    namaLengkapController.dispose();
    genderController.dispose();
    dobController.dispose();
    wController.dispose();
    hController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'Profil',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              buildInputSection('Name', namaLengkapController),
              buildInputSection('Gender', genderController),
              buildInputSection('Date Of Birth', dobController),
              buildInputSection('Weight', wController),
              buildInputSection('Height', hController),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  // Add save functionality
                  print('Name: ${namaLengkapController.text}');
                  print('Gender: ${genderController.text}');
                  print('Date of Birth: ${dobController.text}');
                  print('Weight: ${wController.text}');
                  print('Height: ${hController.text}');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.green[400],
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputSection(String labelText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: '',
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
