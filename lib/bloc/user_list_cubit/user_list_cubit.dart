import 'package:appitron_task/network/models/request_status.dart';
import 'package:appitron_task/network/models/user_list_model.dart';
import 'package:appitron_task/network/network_connection.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  final NetworkConnection _networkConnection;
  UserListCubit(NetworkConnection networkConnection)
      : _networkConnection = networkConnection,
        super(UserListInitial());

  void getUserList() {
    if (state is UserListLoading) return;
    emit(UserListLoading());
    _networkConnection.getUserList().then((result) {
      if (result.status == RequestStatus.SUCCESS) {
        emit(UserListLoaded(result.body));
      }else{
        emit(UserListFailed(result.message??'Something went wrong'));
      }
    }).catchError((error) {
      emit(UserListFailed(error));
    });
  }
}
