import 'package:appitron_task/network/models/user_list_model.dart';
import 'package:appitron_task/screen/update_user_screen.dart';
import 'package:flutter/material.dart';

class SingleUserScreen extends StatelessWidget {
  const SingleUserScreen({Key? key}) : super(key: key);
  static const String routeName = '/single-user';

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as Data;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User info'),
        actions: [
          IconButton(
            icon: const Icon(Icons.mode_edit),
            onPressed: () {
              Navigator.pushNamed(context, UpdateUserScreen.routeName,
                  arguments: user);
            },
          ),
        ],
      ),
      body: ListTile(
        title: Text((user.firstName ?? "") + " " + (user.lastName ?? "")),
        subtitle: Text(user.email ?? ""),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatar ?? ""),
        ),
        trailing: Text("Id: ${user.id}"),
      ),
    );
  }
}
