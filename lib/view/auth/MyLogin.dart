import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoire/view/auth/MyRegister.dart';

import '../../constant/firebase.dart';
import '../../constant/widgets/logo.dart';
import '../../constant/widgets/textfield.dart';

class MyLogin extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            MyLogo(
              fontSize: 25,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
              child: Column(
                children: [
                  MyTextField(
                    controller: _emailController,
                    hint: "Email",
                  ),
                   const SizedBox(
                height: 19,
              ),
              MyTextField(
                controller: _passwordController,
                hint: 'Password',
                obscure: true,
              ),
                ],
              ),
            ),
           
            const Spacer(),
            InkWell(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'New? ',
                        style: TextStyle(
                          color: Get.isDarkMode? Colors.white:Colors.black,
                          fontSize: 16,
                        )),
                    const TextSpan(
                        text: 'Register',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              onTap: () {
                Get.to(MyRegister());
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                authController.login(_emailController.text.trim(),
                    _passwordController.text.trim());
              },
              child:  Text("Sign in".tr),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 211, 211, 211),
              ),
              onPressed: () {
                authController.signInWithGoogle();
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/google.png',
                    height: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Continue with Google",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
