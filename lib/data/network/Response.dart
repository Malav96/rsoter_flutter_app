import 'package:flutter_demo_app/utils/UtilsLibrary.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String title = '';
  String message = '';

  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.hideLoading() : status = Status.HIDE_LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error({this.title = '', this.message = ''})
      : status = Status.ERROR;

  ApiResponse.empty(
      {this.title = error_message_no_records_title,
      this.message = error_message_no_records_msg})
      : status = Status.EMPTY;

  ApiResponse.offline({this.title = '', this.message = ''})
      : status = Status.OFFLINE;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR, EMPTY, OFFLINE, HIDE_LOADING }
