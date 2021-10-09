import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './src/screens/display_information_screen.dart';
import './src/blocs/application_bloc.dart';
import './src/screens/home_screen.dart';
import 'package:provider/provider.dart';
import './src/screens/add_information.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: AddInformation(),
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          DisplayInformationScreen.routName: (context) => DisplayInformationScreen(),
        }
      ),
    );
  }
}

