import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timed_feeder/fixed/constants.dart';
import 'package:timed_feeder/fixed/text_styles.dart';

class AddChild extends StatefulWidget {
  const AddChild({Key? key}) : super(key: key);

  @override
  _AddChildState createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  final _formKey = GlobalKey<FormState>();
  final Constants _constants = Constants();
  List<String> genderList = ['Male', 'Female'];
  TextEditingController _dependantName = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _solidFoodController = TextEditingController();
  TextEditingController _liquidFoodController = TextEditingController();
  String? _gender;
  Size? _size;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Text('Add Dependant'), backgroundColor: Colors.yellow[700]),
      body: Form(key: _formKey, child: _buildAddingDependantForm()),
    );
  }

  Widget _buildAddingDependantForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: [
            //dependant name
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: _dependantName,
                decoration: InputDecoration(
                  filled: true,
                  labelText: _constants.dependantName,
                  fillColor: Colors.grey[100],
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                validator: (_) {},
              ),
            ),
            //dependant age
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: _age,
                decoration: InputDecoration(
                  filled: true,
                  labelText: _constants.age,
                  fillColor: Colors.grey[100],
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                validator: (_) {},
              ),
            ),
            //gender
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    value: _gender,
                    hint: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(_constants.gender),
                    ),
                    onChanged: (val) {
                      setState(() {
                        FocusScope.of(context).requestFocus(FocusNode());

                        _gender = val.toString();
                      });
                    },
                    selectedItemBuilder: (_) {
                      return genderList
                          .map((item) => Center(
                                child: Text(item, style: textStyle1),
                              ))
                          .toList();
                    },
                    items: genderList
                        .map((item) =>
                            DropdownMenuItem(value: item, child: Text(item)))
                        .toList(),
                  ),
                ),
              ),
            ),

            //solid food
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Solid Foods', style: textStyle1),
                  ),
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text(
                          'Daily servings number',
                          style: textStyle3,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _solidFoodController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            labelText: _constants.solidFeeds,
                            alignLabelWithHint: true,
                            fillColor: Colors.grey[100],
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(50)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          validator: (_) {},
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              setState(() {
                                _solidFoodController.text = val;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
            //liquid food
          ],
        ),
      ),
    );
  }
}
