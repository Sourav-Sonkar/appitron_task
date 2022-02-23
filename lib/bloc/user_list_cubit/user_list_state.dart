part of 'user_list_cubit.dart';

@immutable
abstract class UserListState {}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListLoaded extends UserListState {
  final UserListModel? userListModel;

  UserListLoaded(this.userListModel);
}

class UserListFailed extends UserListState {
  final String? error;

  UserListFailed(this.error);
}
