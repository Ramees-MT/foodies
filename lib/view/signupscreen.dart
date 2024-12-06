import 'package:flutter/material.dart';
import 'package:foodies/routes/route_names.dart';
import 'package:foodies/utils/constants.dart';
import 'package:foodies/view-model/signup_view_model.dart';
import 'package:foodies/widgets/buttonwidget.dart';
import 'package:foodies/widgets/customtextfieldwidget.dart';
import 'package:foodies/widgets/iconcontainerwidget.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  bool rememberMe = false;
  String initialCountry = 'US';
  PhoneNumber number = PhoneNumber(isoCode: 'US');

  // Add controllers for form fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kbackgroundcolor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Image.asset('assets/images/Group 1.png')),
                const SizedBox(height: 20),
                const Text(
                  "Create a new Account",
                  style: TextStyle(
                      fontSize: 37,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 40),
                // Phone Number TextField with Country Picker and Search
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    phoneNumberController.text = number.phoneNumber ?? '';
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.DIALOG,
                    showFlags: true,
                    useEmoji: true,
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.disabled,
                  initialValue: number,
                  formatInput: true,
                  maxLength: 15,
                  searchBoxDecoration: InputDecoration(
                    hintText: 'Search country',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    contentPadding: const EdgeInsets.all(12.0),
                  ),
                  inputDecoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xff01040F),
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                  ),
                  textStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  selectorTextStyle:
                      TextStyle(color: Colors.white.withOpacity(0.5)),
                ),
                const SizedBox(height: 15),
                // Email TextField
                CustomTextField(
                  controller: emailController,
                  textOpacity: 0.5,
                  hinttext: 'Email',
                  icon: Icons.email,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 15),
                // Full Name TextField
                CustomTextField(
                  controller: nameController,
                  textOpacity: 0.5,
                  hinttext: 'Full Name',
                  icon: Icons.person,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 15),
                // Password TextField
                CustomTextField(
                  controller: passwordController,
                  textOpacity: 0.5,
                  hinttext: 'Password',
                  icon: Icons.lock,
                  textColor: Colors.white,
                  obscureText: true, // Hide password text
                ),
                const SizedBox(height: 15),
                // Remember Me Checkbox
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          rememberMe = !rememberMe;
                        });
                      },
                      child: Container(
                        width: 18.0,
                        height: 18.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.green,
                            width: 2.0,
                          ),
                          color: rememberMe ? Colors.green : Colors.transparent,
                        ),
                        child: rememberMe
                            ? const Icon(
                                Icons.check,
                                size: 16.0,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Remember me',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                // Sign Up Button
                Buttonwidget(
                  buttonText: "Sign up",
                  onPressed: () {
                    print(nameController.text);
                    print(emailController.text);
                    print(passwordController.text);
                    print(phoneNumberController.text);

                    // Call register function
                    context.read<Signupviewmodel>().register(
                          email: emailController.text,
                          username: nameController.text,
                          password: passwordController.text,
                          phone: phoneNumberController.text,
                          context: context,
                        );
                  },
                ),
                // Divider with 'OR'
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
                const SizedBox(height: 30),
                // Social Media Login Options

                const SizedBox(height: 30),
                // Sign in
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.signinPage);
                  },
                  child: const Text(
                    "Already have an account? Sign in",
                    style: TextStyle(color: Colors.white),
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
