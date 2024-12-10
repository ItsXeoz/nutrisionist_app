import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrisionist_app/pages/editProfile_page.dart';

class viewProfilePage extends StatelessWidget {
  const viewProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Text('Preview Profile',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w500
            )),
      ),
      body: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'images/profile.png',
                width: 100,
              ),
            ),
            const SizedBox(height: 15),
            myReusableWidget('Name', 'Abidzar Giffari'),
            myReusableWidget('Email', 'abidzar@gmail.com'),
            myReusableWidget('Gender', 'Male'),
            myReusableWidget('Date of Birth', '2004-08-23'),
            myReusableWidget('Weigth', '67'),
            myReusableWidget('Height', '173'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(),));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[400],
              ),
              child: const Text(
                'Edit Profile',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget myReusableWidget(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 0.25),
          ),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
