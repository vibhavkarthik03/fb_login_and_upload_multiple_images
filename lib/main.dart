import 'package:fb_login_and_multiple_photos/select_photos_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Log-in with facebook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Log-in with facebook'),
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

  bool _isloggedin=false;
  Map _userObj={};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:_isloggedin?Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(_userObj["picture"]["data"]["url"]),
            Text(_userObj["name"]),
            Text(_userObj["email"]),
            ElevatedButton(onPressed: (){
              FacebookAuth.instance.logOut().then((value) =>
              setState((){
                _isloggedin=false;
                _userObj={};
              })
              );
            }, child:Text('Logout'))
          ],
        ):
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed:()async{
                  FacebookAuth.instance.login(
                      permissions: ["public_profile", "email"]
                  ).then((value) => FacebookAuth.instance.getUserData().then((userdata) =>
                      setState((){
                        _isloggedin=true;
                        _userObj=userdata;
                      }
                      )
                  ));
                }, child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.facebookSquare,color: Colors.white,),
                SizedBox(width: 5,),
                Text('Log-in with facebook',style: TextStyle(color: Colors.white),)
              ],
            )),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UploadMultipleImage()));
                }, child: Text('Select and upload multiple photos')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
