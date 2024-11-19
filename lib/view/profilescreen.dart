import 'package:flutter/material.dart';
import 'package:foodies/view/addressdetailsscreen.dart';
import 'package:foodies/view/orderdetailspage.dart';
import 'package:foodies/view/signinscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.greenAccent)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.greenAccent),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture and Name
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/ney.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "John Doe",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                  Text(
                    "johndoe@example.com",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Account Information Section
            Text(
              "Account Information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            SizedBox(height: 10),
            _buildInfoTile(
              title: "Phone Number",
              subtitle: "+1 234 567 890",
              icon: Icons.edit,
            ),
            _buildInfoTile(
              title: "Date of Birth",
              subtitle: "January 1, 1990",
              icon: Icons.edit,
            ),
            Divider(color: Colors.greenAccent.withOpacity(0.5)),
            SizedBox(height: 10),

            // Orders Section
            _buildSectionButton(
              text: "View All Orders",
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? log_id = await prefs.getString('isLoggedIn');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailsPage(
                      userId: int.tryParse(log_id!)!,
                    ),
                  ),
                );
              },
            ),

            Divider(color: Colors.greenAccent.withOpacity(0.5)),
            SizedBox(height: 10),

            // Address Section
            _buildSectionButton(
              text: "View Address",
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? log_id = await prefs.getString('isLoggedIn');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Addressdetails(
                      userId: int.tryParse(log_id!)!,
                    ),
                  ),
                );
              },
            ),

            Divider(color: Colors.greenAccent.withOpacity(0.5)),
            SizedBox(height: 10),

            // Settings Section
            Text(
              "Settings",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            SizedBox(height: 10),
            _buildSettingsTile(
              title: "Change Password",
              icon: Icons.arrow_forward_ios,
              onTap: () {
                // Navigate to Change Password Page
              },
            ),
            _buildSwitchTile(
              title: "Notifications",
              value: true,
              onChanged: (bool value) {
                // Toggle notification preference
              },
            ),
            _buildSettingsTile(
              title: "Payment Methods",
              icon: Icons.arrow_forward_ios,
              onTap: () {
                // Navigate to Payment Methods Page
              },
            ),

            SizedBox(height: 20),

            // Logout Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  // Perform logout action
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signinscreen(),
                      ));
                },
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(
      {required String title, required String subtitle, IconData? icon}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white70),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.white54),
      ),
      trailing: icon != null ? Icon(icon, color: Colors.greenAccent) : null,
    );
  }

  Widget _buildSectionButton(
      {required String text, required VoidCallback onPressed}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.greenAccent,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text),
      ),
    );
  }

  Widget _buildSettingsTile(
      {required String title, IconData? icon, required VoidCallback onTap}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white70),
      ),
      trailing: icon != null ? Icon(icon, color: Colors.greenAccent) : null,
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(
      {required String title,
      required bool value,
      required ValueChanged<bool> onChanged}) {
    return SwitchListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white70),
      ),
      value: value,
      activeColor: Colors.greenAccent,
      onChanged: onChanged,
    );
  }
}
