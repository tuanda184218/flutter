import 'package:flutter/material.dart';
import 'package:flutter_application_1/myHomePage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hello World!"),
        ),
        body: Body());
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String name = "";
  TextEditingController controller = new TextEditingController();

  void click() {
    this.name = controller.text;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyHomePage(this.name)));
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
                controller: this.controller,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Type your name:",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 5, color: Colors.black)),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.done),
                      splashColor: Colors.blueGrey,
                      tooltip: "Submit",
                      onPressed: this.click,
                    )))));
  }
}
