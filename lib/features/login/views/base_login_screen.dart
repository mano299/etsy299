import 'package:flutter/material.dart';

import 'login_screen.dart';

class BaseLoginScreen extends StatelessWidget {
  const BaseLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0Xff302A35),
        centerTitle: true,
        title: Text('You', style: TextStyle(fontSize: 26)),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Get the most out of Esty',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            'Sign in to contact sellers , track your purchases and get personalized recommendations.',
            style: TextStyle(fontSize: 20),
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            ),
            child: Text(
              'Sign in',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
