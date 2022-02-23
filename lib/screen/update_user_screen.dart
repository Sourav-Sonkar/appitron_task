import 'package:appitron_task/bloc/update_user_cubit/update_user_cubit.dart';
import 'package:appitron_task/network/models/user_list_model.dart';
import 'package:appitron_task/network/network_connection.dart';
import 'package:appitron_task/utils/wigdet_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserScreen extends StatelessWidget {
  UpdateUserScreen({Key? key}) : super(key: key);
  static const String routeName = '/update-user';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as Data;
    _nameController.text = user.firstName ?? "";
    return BlocProvider(
      create: (context) => UpdateUserCubit(context.read<NetworkConnection>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update User'),
        ),
        body: Column(children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ).paddingForAll(8),
          TextField(
            controller: _jobController,
            decoration: const InputDecoration(
              labelText: 'Job',
            ),
          ).paddingForAll(8),
          BlocConsumer<UpdateUserCubit, UpdateUserState>(
            listener: (context, state) {
              if (state is UpdateUserSuccess) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                    content: Text("Success"),
                    backgroundColor: Colors.green,
                  ));
                Navigator.of(context).pop();
              }
              if (state is UpdateUserFailed) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text(state.error ?? "Something went wrong"),
                  ));
              }
            },
            builder: (context, state) {
              if (state is UpdateUserLoading) {
                return const CircularProgressIndicator().wrapCenter();
              }
              return ElevatedButton(
                  onPressed: () {
                    if (_jobController.text.trim().isEmpty ||
                        _nameController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(const SnackBar(
                            content: Text("Please fill all fields")));
                      return;
                    }
                    context.read<UpdateUserCubit>().updateUser(
                        _nameController.text,
                        _jobController.text,
                        user.id.toString());
                  },
                  child: const Text("Update"));
            },
          ).paddingForAll(8),
        ]),
      ),
    );
  }
}
