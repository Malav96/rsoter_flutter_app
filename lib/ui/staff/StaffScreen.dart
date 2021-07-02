import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/data/network/Response.dart';
import 'package:flutter_demo_app/models/index.dart';
import 'package:flutter_demo_app/ui/staff/StaffBloc.dart';
import 'package:flutter_demo_app/ui/staff/StaffUIStates.dart';
import 'package:flutter_demo_app/ui/staff/addoredit/AddOrEditStaffScreen.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:flutter_demo_app/widget/WidgetLibrary.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class StaffScreen extends StatelessWidget {
  static late StaffBloc _staffBloc;
  late BuildContext _buildContext;
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  static searchByStaffList(String value) {
    _staffBloc.searchByNameStaffList(value);
  }

  static onAddMenuButtonClick() {
    _staffBloc.redirectToAddOrEditStaffScreen(null, true);
  }

  @override
  Widget build(BuildContext context) {
    this._buildContext = context;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: COLOR_VIEW_BACKGROUND,
        body: BlocProvider(
          create: (BuildContext context) {
            _staffBloc = StaffBloc();
            return _staffBloc;
          },
          child: _blocConsumer(),
        ));
  }

  Widget _blocConsumer() {
    return BlocConsumer<StaffBloc, StaffUIStates>(
      buildWhen: (previousState, state) {
        return state is ApiHandling;
      },
      builder: (BuildContext context, state) {
        switch ((state as ApiHandling).response.status) {
          case Status.COMPLETED:
            return _staffListView((state.response.data as List<Staff>));
          case Status.ERROR:
            return ErrorView(
                errorTitle: state.response.title,
                errorMessage: state.response.message,
                buttonText: button_try_again,
                icon: Icons.cloud_off_rounded,
                onClicked: () => _staffBloc.getStaffList());
          case Status.EMPTY:
            return ErrorView(
                errorTitle: state.response.title,
                errorMessage: state.response.message,
                buttonText: button_refresh,
                icon: Icons.tag_faces_sharp,
                onClicked: () => _staffBloc.getStaffList());
          case Status.OFFLINE:
            return ErrorView(
                errorTitle: state.response.title,
                errorMessage: state.response.message,
                buttonText: button_try_again,
                icon: Icons.wifi_off_outlined,
                onClicked: () => _staffBloc.getStaffList());
          default:
            return CircularProgressbar();
        }
      },
      listener: (BuildContext context, state) {
        if (state is RefreshError) {
          _scaffoldKey.currentState?.showSnackBar(displaySnackBar(
              message: state.errorMessage,
              snackBarAction: SnackBarAction(
                  label: button_try_again,
                  onPressed: () => _staffBloc.refreshStaffList(true))));
        } else if (state is ShowAddOrEditStaff) {
          Navigator.push(
                  context,
                  SlideRightRoute(
                      page: AddOrEditStaffScreen(
                          staff: state.staff, isAddStaff: state.isAddStaff)))
              .then((value) => updateList(value));
        }
      },
    );
  }

  Future<void> updateList(bool? isRefreshList) async {
    if (isRefreshList == true) {
      _staffBloc.refreshStaffList(true);
    }
  }

  Widget _staffListView(List<Staff> list) {
    return RefreshIndicator(
      color: COLOR_PRIMARY,
      onRefresh: () => _staffBloc.refreshStaffList(false),
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) => InkWell(
              onTap: () =>
                  _staffBloc.redirectToAddOrEditStaffScreen(list[index], false),
              child: Container(
                color: COLOR_WHITE,
                margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _staffImageView(list[index].avatar),
                      SizedBox(width: 16),
                      _staffNameTextView(
                          list[index].firstName + " " + list[index].lastName),
                      _callImageView(list[index].yourNumber),
                      SizedBox(width: 16),
                      _messageImageView(list[index].yourNumber),
                      SizedBox(width: 8)
                    ],
                  ),
                ),
              ))),
    );
  }

  Widget _staffImageView(String avatar) {
    return CircleAvatar(
      radius: 20.0,
      backgroundImage: NetworkImage(avatar),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _staffNameTextView(String staffName) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Text(staffName,
          style: Theme.of(_buildContext).textTheme.subtitle1,
          maxLines: 2,
          overflow: TextOverflow.ellipsis),
    ));
  }

  Widget _callImageView(String mobileNumber) {
    return InkWell(
        onTap: () {
          if (mobileNumber.isEmpty) {
            Fluttertoast.showToast(
                msg: error_message_phone_number_not_available);
          } else {
            launch("tel:$mobileNumber");
          }
        },
        child: Container(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(IC_LIST_CALL, scale: 4.5)));
  }

  Widget _messageImageView(String mobileNumber) {
    return InkWell(
        onTap: () {
          if (mobileNumber.isEmpty) {
            Fluttertoast.showToast(
                msg: error_message_phone_number_not_available);
          } else {
            launch("sms:$mobileNumber");
          }
        },
        child: Container(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(IC_LIST_MESSAGE, scale: 4.5)));
  }
}
