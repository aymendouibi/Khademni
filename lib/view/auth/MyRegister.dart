import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoire/constant/widgets/textfield.dart';
import 'package:memoire/view/auth/MyLogin.dart';

import '../../constant/firebase.dart';
import '../../constant/widgets/logo.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key key}) : super(key: key);

  @override
  State<MyRegister> createState() => _RegisterState();
}

class _RegisterState extends State<MyRegister> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _numberController = TextEditingController();

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
              const SizedBox(
                height: 19,
              ),
              MyTextField(
                    controller: _nameController,
                    hint: "Full name",
                  ),
                   const SizedBox(
                height: 19,
              ),
             TextField(
               keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.black),
      autofocus: false,
      decoration: InputDecoration(
          hintText: "Enter Number",
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 212, 0, 0)),
          ),
          hintStyle:
              TextStyle(color: Color(0xFF5B0000), ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          filled: true,
          fillColor: Color.fromARGB(255, 243, 243, 243)),
      controller: _numberController,
      
    )
                  
                ],
              ),
            ),
           
            const Spacer(),
            InkWell(
              child: RichText(
                text:  TextSpan(
                  children: [
                    TextSpan(
                        text: 'Already a member? ',
                        style: TextStyle(
                          color: Get.isDarkMode? Colors.white:Colors.black,
                          fontSize: 16,
                        )),
                    const TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              onTap: () {
                Get.to(MyLogin());
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                authController.register(_emailController.text.trim(),
                    _passwordController.text.trim(),
                    _nameController.text.trim(),
                    int.parse(_numberController.text.trim())
                    );
                    
              },
              child: Text("Sign Up".tr),
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
