import 'package:appitron_task/network/network_connection.dart';
import 'package:appitron_task/screen/single_user_screen.dart';
import 'package:appitron_task/screen/update_user_screen.dart';
import 'package:appitron_task/screen/user_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NetworkConnection(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          UserListScreen.routeName: (context) => const UserListScreen(),
          SingleUserScreen.routeName: (context) => const SingleUserScreen(),
          UpdateUserScreen.routeName: (context) =>  UpdateUserScreen(),
        },
      ),
    );
  }
}
