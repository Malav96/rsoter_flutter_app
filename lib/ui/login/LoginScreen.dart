import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/data/network/Response.dart';
import 'package:flutter_demo_app/ui/forgotpassword/ForgotPasswordScreen.dart';
import 'package:flutter_demo_app/ui/home/HomeScreen.dart';
import 'package:flutter_demo_app/ui/login/LoginBloc.dart';
import 'package:flutter_demo_app/ui/login/LoginUIStates.dart';
import 'package:flutter_demo_app/utils/UtilsLibrary.dart';
import 'package:flutter_demo_app/widget/WidgetLibrary.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  late BuildContext context;
  late LoginBloc _loginBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    SizeConfig().init(context);
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: COLOR_TRANSPARENT,
        body: BlocProvider(
          create: (_) {
            _loginBloc = LoginBloc();
            return _loginBloc;
          },
          child: _blocListener(),
        ));
  }

  Widget _blocListener() {
    return BlocListener<LoginBloc, LoginUIStates>(
        listener: (context, state) {
          FocusScope.of(context).unfocus();
          if (state is ShowValidationError) {
            Fluttertoast.showToast(msg: state.errorMessage);
          } else if (state is ShowForgotPassword) {
            Navigator.push(context,
                SlideRightRoute(page: ForgotPasswordPage(email: state.email)));
          } else {
            if (state is ApiHandling) {
              if (state.response.status == Status.LOADING) {
                showProgressDialog(context);
              }
              if (state.response.status == Status.HIDE_LOADING) {
                Navigator.pop(context);
              } else if (state.response.status == Status.ERROR) {
                _scaffoldKey.currentState?.showSnackBar(displaySnackBar(
                    message: state.response.message,
                    snackBarAction: SnackBarAction(
                        label: button_try_again,
                        onPressed: () => _loginBloc.validateCredentials())));
              } else if (state.response.status == Status.COMPLETED) {
                Navigator.pushReplacement(
                    context, SlideRightRoute(page: HomeScreen()));
              }
            }
          }
        },
        child: _loginBody());
  }

  Widget _loginBody() {
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
              SizedBox(height: 40),
              Text(label_welcome, style: textTheme.headline5),
              Text(label_login_message,
                  style: textTheme.headline5
                      ?.merge(TextStyle(fontWeight: FontWeight.bold))),
              SizedBox(height: 24),
              _emailTextInput(),
              SizedBox(height: 16),
              _passwordTextInput(),
              _forgotPasswordButton(),
              SizedBox(height: 16),
              _submitButton(),
              SizedBox(height: 12),
              Text(label_company_rights,
                  style: Theme.of(context).textTheme.caption)
            ],
          ),
        ),
      ),
    ));
  }

  Widget _emailTextInput() {
    return TextInputField(
        hintText: hint_email_address,
        onChanged: (value) => _loginBloc.onEmailChange(value),
        inputType: TextInputType.emailAddress,
        inputAction: TextInputAction.next,
        textAlign: TextAlign.center);
  }

  Widget _passwordTextInput() {
    return TextInputField(
      hintText: hint_password,
      onChanged: (value) => _loginBloc.onPasswordChange(value),
      inputType: TextInputType.visiblePassword,
      inputAction: TextInputAction.done,
      obscureText: true,
      textAlign: TextAlign.center,
    );
  }

  Widget _forgotPasswordButton() {
    return BorderlessButton(
        buttonText: button_forgot_password,
        onClicked: () => _loginBloc.onForgotPasswordButtonClick());
  }

  Widget _submitButton() {
    return NormalButton(
        buttonText: button_login,
        onClicked: () => _loginBloc.validateCredentials());
  }
}
