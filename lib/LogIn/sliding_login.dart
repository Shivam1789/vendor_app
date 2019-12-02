import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendor_flutter/Utils/AppColors.dart';
import 'package:vendor_flutter/Utils/ReusableWidgets.dart';
import 'package:vendor_flutter/Utils/UniversalFunctions.dart';
import 'package:vendor_flutter/Utils/ValidatorFunctions.dart';
import 'package:vendor_flutter/bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sliding Login',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isLogin = false;
  Animation<double> loginSize;
  AnimationController loginController;
  AnimatedOpacity opacityAnimation;
  Duration animationDuration = Duration(milliseconds: 270);

  // Focus Nodes
  final FocusNode _emailFocusNode = new FocusNode();
  final FocusNode _passwordFocusNode = new FocusNode();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController password = new TextEditingController();

  // Controllers
  LoginBloc _loginBloc = LoginBloc();

  final StreamController<bool> _loaderStreamController =
      new StreamController<bool>();

  // Global keys
  final GlobalKey<FormState> _loginFormKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);

    loginController =
        AnimationController(vsync: this, duration: animationDuration);

    opacityAnimation =
        AnimatedOpacity(opacity: 0.0, duration: animationDuration);
  }

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  Widget _buildLoginWidgets() {
    return Container(
      padding: EdgeInsets.only(bottom: 62, top: 16),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(190),
              bottomRight: Radius.circular(190)),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.4,
                0.6,
                0.9
              ],
              colors: [
                AppColors.kBlue,
                AppColors.kBlue,
                AppColors.kGreen,
                AppColors.kGreen
              ])),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: animationDuration,
          child: GestureDetector(
            child: Container(
              child: Text(
                'LOGIN'.toUpperCase(),
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegistercomponents() {
    return Padding(
      padding: EdgeInsets.only(left: 42, right: 42, top: 32, bottom: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: Text(
              'Please login to continue using our app',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.kGreen,
              ),
            ),
          ),
          textFieldWidget(
            hint: 'Email',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            controller: _loginBloc.emailController,
            focusNode: _emailFocusNode,
            obscureText: false,
            inputAction: TextInputAction.next,
            validator: (value) {
              return emailValidator(email: value, context: context);
            },
            onFieldSubmitted: (val) {
              setFocusNode(context: context, focusNode: _passwordFocusNode);
            },
            textCapitalization: TextCapitalization.words,
          ),
          Padding(
              padding: const EdgeInsets.only(top: 16),
              child: textFieldWidget(
                hint: 'Password',
                icon: Icons.vpn_key,
                controller: _loginBloc.passwordController,
                focusNode: _passwordFocusNode,
                keyboardType: TextInputType.text,
                obscureText: true,
                inputAction: TextInputAction.done,
                validator: (value) {
                  return passwordValidator(
                      newPassword: value, context: context);
                },
              )),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: GestureDetector(
              onTap: () {
                closeKeyboard(
                  context: context,
                  onClose: () {},
                );
                if (_loginFormKey.currentState.validate()) {
                  _loginBloc.login(context);
                }
              },
              child: Container(
                width: 200,
                height: 40,
                margin: EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                    color: AppColors.kGreen,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _defaultLoginSize = MediaQuery.of(context).size.height / 1.5;

    loginSize = Tween<double>(begin: _defaultLoginSize, end: 200).animate(
        CurvedAnimation(parent: loginController, curve: Curves.linear));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _loginFormKey,
          child: Column(
            children: <Widget>[
              _buildLoginWidgets(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(child: _buildRegistercomponents()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
