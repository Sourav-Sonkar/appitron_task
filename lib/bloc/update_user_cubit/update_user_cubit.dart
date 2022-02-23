import 'package:appitron_task/network/models/request_status.dart';
import 'package:appitron_task/network/network_connection.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit(NetworkConnection networkConnection)
      : _networkConnection = networkConnection,
        super(UpdateUserInitial());
  final NetworkConnection _networkConnection;

  void updateUser(String name, String job, String id) {
    if (state is UpdateUserLoading) return;
    emit(UpdateUserLoading());
    _networkConnection.updateUser(name, job, id).then((value) {
      if (value.status == RequestStatus.SUCCESS) {
        emit(UpdateUserSuccess());
      } else {
        emit(UpdateUserFailed(error: value.message));
      }
    }).catchError((error) {
      emit(UpdateUserFailed());
    });
  }
}
