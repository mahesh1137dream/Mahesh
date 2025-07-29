import 'package:api_course/appcolor/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:api_course/screens/home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void Login(String email, password) async {
    try {
      Response response = await post(
        Uri.parse('https://krushimahostav.yuvapsvs.com/api/auth/login'),
        body: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${response.body}')),
        );
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An error occurred')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up Api")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email',border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(hintText: 'Password',border: OutlineInputBorder())
            ),
            SizedBox(height: 20),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Login(
                  emailController.text.toString(),
                  passwordController.text.toString(),
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Appcolor.primarycolor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text('Sign Up')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
