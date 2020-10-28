import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:github_auth/github_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twitter_auth/twitter_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Auth Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final twitterAuth = TwitterAuth(
    clientId: '<your-client-id>',
    clientSecret: '<your-client-secret>',
    callbackUrl: '<your-client-url>',
  );

  final githubAuth = GithubAuth(
    clientId: '<your-client-id>',
    clientSecret: '<your-client-secret>',
    callbackUrl: '<your-client-url>',
  );

  void showToast(String message, MaterialColor color) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _signInWith(BuildContext context, FlutterAuth auth) async {
    try {
      FlutterAuthResult resp = await auth.login(context);
      print('Successfully retrieved result ${resp.toString()}');
      showToast('Successfully signed in', Colors.green);
    } on FlutterAuthException catch (e) {
      switch (e.code) {
        case FlutterAuthExceptionCode.login:
          print('A exception occurred during a login attempt: ${e.toString()}');
          if (e.details != null && e.details is GithubAPIError) {
            print('A GithubAPIError ${e.details.code} ${e.details.uri}');
          }

          if (e.details != null && e.details is TwitterAPIError) {
            print('A TwitterAPIError ${e.details.code} ${e.details.uri}');
          }
          showToast('A exception occurred during a login attempt', Colors.red);
          break;
        case FlutterAuthExceptionCode.cancelled:
          print('Login process was cancelled by user: ${e.toString()}');
          showToast('Login process was cancelled by user', Colors.red);
          break;
        case FlutterAuthExceptionCode.network:
          print('A network exception was thrown: ${e.toString()}');
          showToast('A network exception was thrown', Colors.red);
          break;
      }
    } catch (e) {
      print('Exception $e');
    }
  }

  Widget _buildTwitterButton(BuildContext context) {
    return SignInButton(
      Buttons.Twitter,
      onPressed: () => _signInWith(context, twitterAuth),
    );
  }

  Widget _buildGithubButton(BuildContext context) {
    return SignInButton(
      Buttons.GitHub,
      onPressed: () => _signInWith(context, githubAuth),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4466A2),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTwitterButton(context),
            _buildGithubButton(context)
          ],
        ),
      ),
    );
  }
}
