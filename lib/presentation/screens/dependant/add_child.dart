import 'package:flutter/material.dart';

class AddChild extends StatefulWidget {
  const AddChild({Key? key}) : super(key: key);

  @override
  _AddChildState createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Add Dependant'), backgroundColor: Colors.yellow[700]),
      body: Form(key: _formKey, child: _buildAddingDependantForm()),
    );
  }

  Widget _buildAddingDependantForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          //dependant name

          //dependant age

          //gender

          //solid food

          //liquid food
        ],
      ),
    );
  }
}
