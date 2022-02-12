import 'package:flutter/material.dart';
import 'package:timed_feeder/presentation/widgets/ripple_button.dart';

class HomeScreen extends StatefulWidget {
  final title;
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.yellow[700],
        ),
        body: _buildHomeScreen());
  }

  Widget _buildHomeScreen() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //A button to add a child
          Center(
            child: RippleButton(
              size: 0.3,
            ),
          )
          //A list of added children
        ],
      ),
    );
  }
}
