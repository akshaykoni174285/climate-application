import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text('About'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF5E81AC),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0x3BBF616A), Color(0x3BEBCB8B)],
          ),
        ),
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'Hello, \n Developed this small weather app using flutter and dart that shows some essential properties of climate at runtime\n',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFECEFF4),
                      fontFamily: 'Nothing',
                      letterSpacing: 1,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    color: Color(0x3BFFFFFF),
                  ),
                  margin: EdgeInsets.fromLTRB(20, 100, 20, 20),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
