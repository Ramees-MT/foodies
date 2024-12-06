import 'package:flutter/material.dart';
import 'package:foodies/view-model/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:foodies/model/profile_model.dart';
import 'package:foodies/services/profile_api_service.dart';
import 'package:foodies/view/addressdetailsscreen.dart';
import 'package:foodies/view/orderdetailspage.dart';
import 'package:foodies/view/signinscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // To work with File

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  // Fetch user details from SharedPreferences or database
  Future<void> _fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? logId = prefs.getString('isLoggedIn');
    if (logId != null) {
      final userId = int.tryParse(logId);
      if (userId != null) {
        Provider.of<ProfileViewModel>(context, listen: false)
            .fetchUserDetails(userId);
      }
    }

    // Load stored profile image (if any) from SharedPreferences
    String? imagePath = prefs.getString('profileImage');
    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  // Method to pick an image from the gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _profileImage = File(pickedFile.path);
      });

      // Store the image path in SharedPreferences for future sessions
      prefs.setString('profileImage', pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    final user = profileViewModel.user;
    final isLoading = profileViewModel.isLoading;
    final errorMessage = profileViewModel.errorMessage;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.greenAccent)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.greenAccent),
        elevation: 0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.greenAccent))
          : errorMessage != null
              ? Center(
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                )
              : user == null
                  ? Center(
                      child: Text(
                        "No user data available.",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    )
                  : SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Picture and Name
                          Center(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: _pickImage, // Open image picker on tap
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: _profileImage != null
                                        ? FileImage(_profileImage!)
                                        : AssetImage('assets/images/profile.png')
                                            as ImageProvider,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  user.username!,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                Text(
                                  user.email!,
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
                            subtitle: user.phone!,
                            icon: Icons.edit,
                          ),
                          Divider(color: Colors.greenAccent.withOpacity(0.5)),
                          SizedBox(height: 10),

                          // Orders Section
                          _buildSectionButton(
                            text: "View All Orders",
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              String? log_id = prefs.getString('isLoggedIn');
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
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              String? log_id = prefs.getString('isLoggedIn');
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 12),
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
      required Function(bool) onChanged}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white70),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.greenAccent,
      ),
    );
  }
}
