import 'package:e_commerceapp/app/common_widgets/constants.dart';
import 'package:e_commerceapp/app/common_widgets/show_exception_alert_dialog.dart';
import 'package:e_commerceapp/app/common_widgets/social_sign_in_button.dart';
import 'package:e_commerceapp/app/sign_in/email_sign_in_page.dart';
import 'package:e_commerceapp/app/sign_in/sign_in_bloc.dart';
import 'package:e_commerceapp/app/sign_in/sign_in_button.dart';
import 'package:e_commerceapp/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  static Widget create(BuildContext context) {
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(),
      child: SignInPage(),
    );
  }

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;
  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(context,
        title: 'Sign In failed ', exception: exception);
  }

  Future<void> _signIWithGoogle(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
      print(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => EmailSignInPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sign In'),
        elevation: 2.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 50.0, child: _buildHeader()),
            SizedBox(height: 20.0),
            SignInButton(
              text: 'Sign In',
              textColor: Colors.white,
              color: Colors.blue[700],
              onPressed: _isLoading ? null : () => _signInWithEmail(context),
            ),
            SizedBox(height: 20.0),
            Text(
              'Sign in With',
              style: TextStyle(fontSize: 15.0, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            SocialSignInButton(
              assetName: 'images/google-logo.png',
              text: 'Sign In with Google',
              textColor: Colors.black87,
              color: Colors.white,
              onPressed: _isLoading ? null : () => _signIWithGoogle(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Welcome to Opaku',
      textAlign: TextAlign.center,
      style: Constants.regularHeading,
    );
  }
}
