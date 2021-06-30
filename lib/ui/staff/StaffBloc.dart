import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/data/network/ApiManager.dart';
import 'package:flutter_demo_app/data/network/CustomException.dart';
import 'package:flutter_demo_app/data/network/Response.dart';
import 'package:flutter_demo_app/models/index.dart';
import 'package:flutter_demo_app/ui/staff/StaffUIStates.dart';

class StaffBloc extends Cubit<StaffUIStates> {
  List<Staff> _staffList = [];
  List<Staff> _filterStaffList = [];

  StaffBloc() : super(StaffUIStates()) {
    getStaffList();
  }

  Future<void> getStaffList() async {
    try {
      emit(ApiHandling(ApiResponse.loading()));
      var staffResponse = await ApiManager.getStaffList();
      _staffList.clear();
      _staffList.addAll(staffResponse.result);
      if (_staffList.isEmpty) {
        emit(ApiHandling(ApiResponse.empty()));
      } else {
        emit(ApiHandling(ApiResponse.completed(_staffList)));
      }
    } on UnknownHostException catch (e) {
      emit(
          ApiHandling(ApiResponse.offline(title: e.title, message: e.message)));
    } on InternalServerErrorExceptions catch (e) {
      emit(ApiHandling(ApiResponse.error(title: e.title, message: e.message)));
    } on UnAuthorizedException catch (e) {
      emit(ApiHandling(ApiResponse.error(title: e.title, message: e.message)));
    } on ApiSideExceptions catch (e) {
      emit(ApiHandling(ApiResponse.error(title: e.title, message: e.message)));
    }
  }

  Future<void> refreshStaffList([isRefreshing = false]) async {
    try {
      if (isRefreshing) {
        emit(ApiHandling(ApiResponse.loading()));
      }
      var staffResponse = await ApiManager.getStaffList();
      _staffList.clear();
      _staffList.addAll(staffResponse.result);
      if (_staffList.isEmpty) {
        emit(ApiHandling(ApiResponse.empty()));
      } else {
        emit(ApiHandling(ApiResponse.completed(_staffList)));
      }
    } catch (e) {
      emit(RefreshError(e.toString()));
      emit(ApiHandling(ApiResponse.completed(_staffList)));
    }
  }

  Future<void> searchByNameStaffList(String searchValue) async {
    if (searchValue.isEmpty) {
      _filterStaffList = _staffList;
    } else {
      _filterStaffList = _staffList
          .where((u) =>
              (u.firstName.toLowerCase().contains(searchValue.toLowerCase()) ||
                  u.lastName.toLowerCase().contains(searchValue.toLowerCase())))
          .toList();
    }
    emit(ApiHandling(ApiResponse.completed(_filterStaffList)));
  }
}
