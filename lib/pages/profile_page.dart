import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrisionist_app/pages/login_page.dart';
import 'package:nutrisionist_app/pages/viewProfile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> logout() async {
  final storage = FlutterSecureStorage();
  await storage.delete(key: "auth_token");
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
}


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(color: Colors.green[400]),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'images/profile.png',
                    width: 100,
                  ),
                  Text(
                    'Abidzar Giffari',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => viewProfilePage(),));
                  },
                  leading: const Icon(Icons.person),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile Settings',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                        ),
                      ),
                      const Icon(Icons.navigate_next),
                    ],
                  ),
                ),
                const Divider(),
                ListTile(
                  onTap: logout,
                  leading: const Icon(Icons.logout),
                  title: Text(
                    'Logout',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
