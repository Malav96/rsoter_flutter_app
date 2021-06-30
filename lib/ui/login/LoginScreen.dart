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
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: COLOR_TRANSPARENT,
        body: BlocProvider(
          create: (_) => LoginBloc(),
          child: _blocListener(context),
        ));
  }
}

Widget _blocListener(BuildContext context) {
  return BlocListener<LoginBloc, LoginUIStates>(
      listener: (context, state) {
        FocusScope.of(context).unfocus();
        hideSnackBar(buildContext: context);
        if (state is ShowValidationError) {
          Fluttertoast.showToast(msg: state.errorMessage);
        } else if (state is ShowForgotPassword) {
          Navigator.push(context,
              SlideRightRoute(page: ForgotPasswordPage(email: state.email)));
        } else {
          if (state is ApiHandling) {
            if (state.response.status == Status.LOADING) {
              showProgressDialog(context);
            } else if (state.response.status == Status.ERROR) {
              Navigator.pop(context);
              showSnackBar(
                  buildContext: context,
                  message: state.response.message,
                  onButtonClicked: () =>
                      {context.read<LoginBloc>().validateCredentials()});
            } else if (state.response.status == Status.COMPLETED) {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context, SlideRightRoute(page: HomeScreen()));
            }
          }
        }
      },
      child: _loginBody(context));
}

Widget _loginBody(BuildContext context) {
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
  return BlocBuilder<LoginBloc, LoginUIStates>(builder: (context, state) {
    return TextInputField(
        hintText: hint_email_address,
        onChanged: (value) {
          context.read<LoginBloc>().onEmailChange(value);
        },
        inputType: TextInputType.emailAddress,
        inputAction: TextInputAction.next);
  });
}

Widget _passwordTextInput() {
  return BlocBuilder<LoginBloc, LoginUIStates>(builder: (context, state) {
    return TextInputField(
      hintText: hint_password,
      onChanged: (value) {
        context.read<LoginBloc>().onPasswordChange(value);
      },
      inputType: TextInputType.visiblePassword,
      inputAction: TextInputAction.done,
      obscureText: true,
    );
  });
}

Widget _forgotPasswordButton() {
  return BlocBuilder<LoginBloc, LoginUIStates>(builder: (context, state) {
    return BorderlessButton(
        buttonText: button_forgot_password,
        onClicked: () {
          context.read<LoginBloc>().onForgotPasswordButtonClick();
        });
  });
}

Widget _submitButton() {
  return BlocBuilder<LoginBloc, LoginUIStates>(builder: (context, state) {
    return NormalButton(
        buttonText: button_login,
        onClicked: () {
          context.read<LoginBloc>().validateCredentials();
        });
  });
}
