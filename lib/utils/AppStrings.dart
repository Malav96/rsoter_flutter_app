/*All button*/
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/utils/AppImagesPath.dart';

const button_login = 'Login';
const button_forgot_password = 'Forgot Password?';
const button_back_to_login = 'Back To Login';
const button_send_me_email = 'Send Me Email';
const button_ok = 'Ok';
const button_try_again = 'Try Again';
const button_refresh = 'Refresh';
const button_save = 'Save';
const button_delete = 'DELETE';
const button_cancel = 'Cancel';

/*All error*/
const error_email = 'Please enter a valid email address';
const error_password = 'Please enter a password';
const error_first_name = 'Please enter your first name';
const error_last_name = 'Please enter your last name';
const error_message_enter_valid_mobile = 'Please enter valid mobile number';
const error_bad_request =
    'There was a problem while connecting to our server, please try again.';
const error_inter_server = 'Internal server error';
const error_not_found =
    'Incorrect email address or password, please try again.';
const error_for_bidden =
    'Sorry, there’s a bit more information we need from you. Please return to rosterelf.com and log in to complete your setup';

const error_message_phone_number_not_available =
    'Phone number isn\'t available';

const error_message_no_internet_title = 'No internet connection';
const error_message_no_internet_msg =
    'Make sure that Wi-Fi or cellular mobile data is turned on, then try again.';

const error_message_server_error_title = 'Something went wrong';
const error_message_server_error_msg =
    'There was a problem while connecting to our server, please try again.';

const error_message_no_records_title = 'No records available';
const error_message_no_records_msg =
    'Nothing to display, please try to refresh.';

const error_message_unauthorized_title = 'Unauthorized access';
const error_message_unauthorized_msg =
    'Sorry, we are not able to authenticate you';

const error_message_unknown_title = 'An unexpected error has occurred.';

/*All label*/
const label_appName = 'Flutter Demo App';
const label_welcome = 'Welcome to RosterElf';
const label_login_message = 'Let\'s log you in';
const label_company_rights = 'Copyright © 2018. RosterElf Pty Ltd.';
const label_forgot_your_password = 'Forgot Your Password?';
const label_forgot_message = 'Confirm email address below to get a new one.';
const label_dashboard = 'Dashboard';
const label_my_shift = 'My Shift';
const label_staff = 'Staff';
const label_roster = 'Roster';
const label_trends = 'TRENDS';
const label_swaps = 'SWAPS';
const label_leave = 'LEAVE';
const label_avails = 'AVAILS';
const label_today = 'TODAY';
const label_future = 'FUTURE';
const label_add_staff = 'Add Staff';
const label_edit_staff = 'Edit Staff';
const label_delete_staff = 'Delete Staff?';

/*All hint*/
const hint_email_address = 'Email Address';
const hint_password = 'Password';
const hint_search = 'Search';
const hint_search_by_name = 'Search by name';
const hint_first_name = 'First Name*';
const hint_last_name = 'Last Name*';
const hint_star_email_address = 'Email Address*';
const hint_mobile_number = 'Mobile Number*';

/*All message*/
const msg_please_wait_moment = 'Please wait a moment...';
const msg_delete_employee =
    'Are you sure you want to delete this staff?\n\nDoing so will make their account inactive and they will not longer be able to login.';

const List<BottomNavigationBarItem> bottomNavigationBarItem = [
  BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(IC_BOTTOM_MENU_DASHBOARD)),
      label: label_dashboard),
  BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(IC_BOTTOM_MENU_MY_SHIFT)),
      label: label_my_shift),
  BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(IC_BOTTOM_MENU_STAFF)), label: label_staff),
  BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(IC_BOTTOM_MENU_ROSTER)), label: label_roster),
];

const Iterable<Locale> supportedLocale = [
  Locale("af"),
  Locale("am"),
  Locale("ar"),
  Locale("az"),
  Locale("be"),
  Locale("bg"),
  Locale("bn"),
  Locale("bs"),
  Locale("ca"),
  Locale("cs"),
  Locale("da"),
  Locale("de"),
  Locale("el"),
  Locale("en"),
  Locale("es"),
  Locale("et"),
  Locale("fa"),
  Locale("fi"),
  Locale("fr"),
  Locale("gl"),
  Locale("ha"),
  Locale("he"),
  Locale("hi"),
  Locale("hr"),
  Locale("hu"),
  Locale("hy"),
  Locale("id"),
  Locale("is"),
  Locale("it"),
  Locale("ja"),
  Locale("ka"),
  Locale("kk"),
  Locale("km"),
  Locale("ko"),
  Locale("ku"),
  Locale("ky"),
  Locale("lt"),
  Locale("lv"),
  Locale("mk"),
  Locale("ml"),
  Locale("mn"),
  Locale("ms"),
  Locale("nb"),
  Locale("nl"),
  Locale("nn"),
  Locale("no"),
  Locale("pl"),
  Locale("ps"),
  Locale("pt"),
  Locale("ro"),
  Locale("ru"),
  Locale("sd"),
  Locale("sk"),
  Locale("sl"),
  Locale("so"),
  Locale("sq"),
  Locale("sr"),
  Locale("sv"),
  Locale("ta"),
  Locale("tg"),
  Locale("th"),
  Locale("tk"),
  Locale("tr"),
  Locale("tt"),
  Locale("uk"),
  Locale("ug"),
  Locale("ur"),
  Locale("uz"),
  Locale("vi"),
  Locale("zh")
];
