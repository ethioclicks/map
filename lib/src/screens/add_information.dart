import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

import './home_screen.dart';
//import './display_information_screen.dart';

class AddInformation extends StatefulWidget {
  @override
  State<AddInformation> createState() => _AddInformationState();
}

class _AddInformationState extends State<AddInformation> {
  // TextEditingController _nameController = TextEditingController();
  // TextEditingController _colorController = TextEditingController();
  // TextEditingController _modelController = TextEditingController();

  // void _onSaved(){
  //   DisplayInformationScreen(_nameController, _colorController, _modelController);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Location'),
      ),
      body: Column(
        children: [
          Form(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Car\'s display name'),
                  //controller: _nameController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Color'),
                  //controller: _colorController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Model'),
                 // controller: _modelController,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    child: Text('Next'),
                    onPressed: (){
                      Navigator.of(context).pushNamed(HomeScreen.routeName);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
