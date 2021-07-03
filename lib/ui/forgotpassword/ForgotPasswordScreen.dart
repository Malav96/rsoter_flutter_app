import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/data/network/Response.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:flutter_demo_app/widget/WidgetLibrary.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'ForgotPasswordBloc.dart';
import 'ForgotPasswordUIStates.dart';

class ForgotPasswordPage extends StatelessWidget {
  final String email;
  late ForgotPasswordBloc _forgotPasswordBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ForgotPasswordPage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: COLOR_TRANSPARENT,
        body: BlocProvider(
          create: (_) {
            _forgotPasswordBloc = ForgotPasswordBloc(email);
            return _forgotPasswordBloc;
          },
          child: _blocListener(context, email),
        ));
  }

  Widget _blocListener(BuildContext context, String email) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordUIState>(
        listener: (context, state) {
          FocusScope.of(context).unfocus();
          if (state is ShowValidationError) {
            Fluttertoast.showToast(msg: state.errorMessage);
          } else if (state is ApiHandling) {
            if (state.response.status == Status.LOADING) {
              showProgressDialog(context);
            } else if (state.response.status == Status.HIDE_LOADING) {
              Navigator.pop(context);
            } else if (state.response.status == Status.ERROR) {
              _scaffoldKey.currentState?.showSnackBar(displaySnackBar(
                  message: state.response.message,
                  snackBarAction: SnackBarAction(
                      label: button_try_again,
                      onPressed: () =>
                          _forgotPasswordBloc.validateCredentials())));
            } else if (state.response.status == Status.COMPLETED) {
              showSuccessMessageAlertDialog(
                  buildContext: context,
                  message: state.response.data,
                  onButtonClicked: () => Navigator.pop(context));
            }
          }
        },
        child: _forgotPasswordUI(context, email));
  }

  Widget _forgotPasswordUI(BuildContext context, String email) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: FullScreenBackground(
      asstImage: BG_BACKGROUND,
      childWidget: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(IC_COMPANY_LOGO, scale: 3.0),
              SizedBox(height: 24),
              Text(label_forgot_your_password,
                  textAlign: TextAlign.center, style: textTheme.headline5),
              SizedBox(height: 4),
              Container(
                width: SizeConfig.screenWidth * 0.8,
                child: Text(label_forgot_message,
                    textAlign: TextAlign.center,
                    style: textTheme.headline5
                        ?.merge(TextStyle(fontWeight: FontWeight.bold))),
              ),
              SizedBox(height: 32),
              _emailTextInput(email),
              SizedBox(height: 16),
              _sendMeEmailButton(),
              SizedBox(height: 16),
              _backToLoginButton(context),
              SizedBox(height: 16),
              Text(label_company_rights,
                  style: Theme.of(context).textTheme.caption)
            ],
          ),
        ),
      ),
    ));
  }

  Widget _emailTextInput(String email) {
    return TextInputField(
        initialValue: email,
        hintText: hint_email_address,
        onChanged: (value) => _forgotPasswordBloc.onEmailChange(value),
        inputType: TextInputType.emailAddress,
        inputAction: TextInputAction.done,
        textAlign: TextAlign.center);
  }

  Widget _sendMeEmailButton() {
    return NormalButton(
        buttonText: button_send_me_email,
        onClicked: () => _forgotPasswordBloc.validateCredentials());
  }

  Widget _backToLoginButton(BuildContext context) {
    return NormalButton(
      buttonText: button_back_to_login,
      onClicked: () => Navigator.pop(context),
      buttonColor: COLOR_GREY,
    );
  }
}
