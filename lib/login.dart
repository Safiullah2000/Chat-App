import 'package:firebase/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String username = "";

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void Login() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String email = emailController.text;
      String password = passwordController.text;

      try {
        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: email, password: password);

        final DocumentSnapshot snapshot =
            await firestore.collection("users").doc(user.user?.uid).get();

        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        print("User is logged in");

        print(data["username"]);

        username = data["username"];

        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        });

        print(data["email"]);
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
              "Sign In",
              style: TextStyle(
                fontSize: 25,
              ),
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
                Login();
              },
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
