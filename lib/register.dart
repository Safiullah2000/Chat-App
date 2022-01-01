import 'package:firebase/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void Register() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String username = usernameController.text;
      String email = emailController.text;
      String password = passwordController.text;

      try {
        final UserCredential user = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await firestore.collection("users").doc(user.user?.uid).set({
          "email": email,
          "username": username,
        });
        print("User is Registered");
      } catch (e) {
        print("error");
      }
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign Up",
              style: TextStyle(fontSize: 25),
            ),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your username'),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your email'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your password'),
            ),
            ElevatedButton(
              onPressed: () {
                Register();
              },
              child: Text(
                "Register",
                style: TextStyle(fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                });
              },
              child: Text(
                "Already have an account, Log In",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
