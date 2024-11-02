import 'package:flutter/material.dart';
import 'package:foodies/view-model/signin_view_model.dart';
import 'package:provider/provider.dart'; // Add this import
import 'package:foodies/utils/constants.dart';
import 'package:foodies/view/signupscreen.dart';
import 'package:foodies/widgets/buttonwidget.dart';
import 'package:foodies/widgets/customcntnrwidget.dart';
 // Import the view model

class Signinscreen extends StatefulWidget {
  const Signinscreen({super.key});

  @override
  State<Signinscreen> createState() => _SigninscreenState();
}

class _SigninscreenState extends State<Signinscreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SigninViewModel>(context); // Access the view model

    return SafeArea(
      child: Scaffold(
        backgroundColor: kbackgroundcolor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Image.asset('assets/images/Group 2 (1).png')),

                const SizedBox(height: 20),

                const Text(
                  "Let's You In",
                  style: TextStyle(
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 40),

                // Email TextField
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    prefixIcon: const Icon(Icons.email, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 15),

                // Password TextField
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  obscureText: true,
                ),

                Buttonwidget(
                  buttonText: "Signin",
                  onPressed: () {
                    // Call login function
                    viewModel.login(
                      email: emailController.text,
                      password: passwordController.text,
                      context: context,
                    );
                  },
                ),

                const SizedBox(height: 30),

                Row(
                  children: const [
                    Expanded(
                      child: Divider(thickness: 1, color: Colors.grey),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'or',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Divider(thickness: 1, color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Social Media Buttons
                Customcntnrwidget(
                  text: 'Continue with Facebook',
                  imagepath: 'assets/images/facebook (2).png',
                ),
                const SizedBox(height: 15),
                Customcntnrwidget(
                  text: 'Continue with Google',
                  imagepath: 'assets/images/google (1).png',
                  ontap: () {
                    // Call Google sign-in function
                    viewModel.signinWithGoogle(context);
                  },
                ),
                const SizedBox(height: 15),
                Customcntnrwidget(
                  text: 'Continue with Apple',
                  imagepath: 'assets/images/apple-logo (1).png',
                ),

                const SizedBox(height: 30),

                const SizedBox(height: 30),

                // Create new account
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signupscreen(),
                      ),
                    );
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: 'Create new account? ',
                      style: TextStyle(color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
