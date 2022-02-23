import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:appitron_task/network/models/request_status.dart';
import 'package:appitron_task/network/models/user_list_model.dart';
import 'package:appitron_task/network/models/user_update_model.dart';
import 'package:http/http.dart' as http;

class NetworkConnection {
  static const _baseUrl = "reqres.in";
  final http.Client _httpClient;

  NetworkConnection({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<RequestStatus<UserListModel>> getUserList() async {
    try {
      final uri = Uri.https(_baseUrl, '/api/users');
      final response = await _httpClient.get(uri);
      if (response.statusCode == 200) {
        final res = UserListModel.fromJson(jsonDecode(response.body));
        return RequestStatus<UserListModel>(RequestStatus.SUCCESS, null, res);
      } else {
        return RequestStatus<UserListModel>(
            RequestStatus.FAILURE, "Something went wrong", null);
      }
    } catch (e) {
      return _commonCatchBlock<UserListModel>(e);
    }
  }

  Future<RequestStatus<UserUpdateModel>> updateUser(
      String name, String job, String id) async {
    try {
      final uri = Uri.https(_baseUrl, '/api/users/{$id}');
      final response = await _httpClient.put(uri, body: {
        "name": name,
        "job": job,
      });
      if (response.statusCode == 200) {
        return RequestStatus(RequestStatus.SUCCESS, null,
            UserUpdateModel.fromJson(jsonDecode(response.body)));
      } else {
        return RequestStatus(
            RequestStatus.FAILURE, "Something went wrong", null);
      }
    } catch (e) {
      return _commonCatchBlock(e);
    }
  }

  RequestStatus<T> _commonCatchBlock<T>(e) {
    if (e is TimeoutException || e is SocketException) {
      return RequestStatus<T>(
          RequestStatus.FAILURE, 'Check internet connection', null);
    }
    //print(e);
    return RequestStatus<T>(
        RequestStatus.FAILURE, 'Something went wrong', null);
  }
}
