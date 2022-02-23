import 'package:appitron_task/bloc/user_list_cubit/user_list_cubit.dart';
import 'package:appitron_task/network/network_connection.dart';
import 'package:appitron_task/screen/single_user_screen.dart';
import 'package:appitron_task/utils/wigdet_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserListCubit(context.read<NetworkConnection>())..getUserList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("User List"),
          centerTitle: true,
        ),
        body: BlocConsumer<UserListCubit, UserListState>(
          listener: (context, state) {
            if (state is UserListFailed) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text(state.error ?? "Something went wrong"),
                  backgroundColor: Colors.red,
                  action: SnackBarAction(
                    label: "Retry",
                    onPressed: () =>
                        context.read<UserListCubit>().getUserList(),
                  ),
                ));
            }
          },
          builder: (context, state) {
            if (state is UserListLoading) {
              return const CircularProgressIndicator().wrapCenter();
            }

            if (state is UserListLoaded) {
              return ListView.builder(
                itemCount: state.userListModel?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => Navigator.of(context).pushNamed(
                      SingleUserScreen.routeName,
                      arguments: state.userListModel?.data![index],
                    ),
                    trailing: CircleAvatar(
                      backgroundImage: NetworkImage(
                          state.userListModel?.data?.elementAt(index).avatar ??
                              ""),
                    ),
                    title:
                        Text(state.userListModel?.data?[index].firstName ?? ""),
                  );
                },
              );
            }
            if (state is UserListFailed) {
              return const Text("Unable to load data").wrapCenter();
            }
            return const Text("User List").wrapCenter();
          },
        ),
      ),
    );
  }
}
