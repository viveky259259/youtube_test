  //import 'dart:async';
  //import 'dart:convert';
  //
  //import 'package:flutter/material.dart';
  //import 'package:registration_login/utils/list_item.dart';
  //import 'package:registration_login/utils/navigation_router.dart';
  //import 'package:firebase_auth/firebase_auth.dart';
  //import 'package:google_sign_in/google_sign_in.dart';
  //import 'package:registration_login/utils/util.dart';
  //import 'package:flutter_facebook_login/flutter_facebook_login.dart';
  //import 'package:http/http.dart' as http;
  //import "package:googleapis_auth/auth_io.dart";
  //
  //class LoginScreen extends StatefulWidget {
  //  @override
  //  _LoginScreenState createState() => new _LoginScreenState();
  //}
  //
  //class _LoginData {
  //  String email = '';
  //  String password = '';
  //}
  //
  //class _LoginScreenState extends State<LoginScreen> {
  //  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  //  static final FacebookLogin facebookSignIn = new FacebookLogin();
  //  String _message = 'Log in/out by pressing the buttons below.';
  //  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  //  _LoginData _data = new _LoginData();
  //  final _googleSignIn = new GoogleSignIn(
  //    scopes: [
  //      "https://www.googleapis.com/auth/youtube.readonly",
  //    ],
  //  );
  //
  //  Future<FirebaseUser> _googleSignInButton() async {
  //    GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
  //    GoogleSignInAuthentication _googleSignInAuth =
  //    await _googleSignInAccount.authentication;
  //    var key = await http.get(
  //        "https://www.googleapis.com/oauth2/v3/tokeninfo?access_token=${_googleSignInAuth.accessToken}");
  //    var body = json.decode(key.body);
  //    var authTO = body["aud"];
  //
  //    var client = new http.Client();
  //    var id = ClientId.serviceAccount(
  //        "415559321663-t0gn2nurftcbusc9hg2rmogppuapqn3k.apps.googleusercontent.com");
  //    AuthClient clientAuth =
  //    await clientViaUserConsent(id, _googleSignIn.scopes, prompt);
  ////    .then((AuthClient client) {
  ////      // Authenticated and auto refreshing client is available in [client].
  ////      // ...
  ////      client.close();
  ////    });
  //    FirebaseUser _fireBaseUser = await _fireBaseAuth.signInWithGoogle(
  //        idToken: _googleSignInAuth.idToken,
  //        accessToken: _googleSignInAuth.accessToken);
  //
  //    // print("user name : ${_fireBaseUser.photoUrl}");
  //    Util.userName = _fireBaseUser.displayName;
  //    Util.emailId = _fireBaseUser.email;
  //    Util.profilePic = _fireBaseUser.photoUrl;
  //    Util.authToken = await _fireBaseUser.getIdToken();
  //    NavigationRouter.switchToHome(context);
  //    return _fireBaseUser;
  //  }
  //
  //  void prompt(String url) {
  //    print("Please go to the following URL and grant access:");
  //    print("  => $url");
  //    print("");
  //  }
  //
  //  Future<Null> _facebookLogin() async {
  //    final FacebookLoginResult result = await facebookSignIn
  //        .logInWithReadPermissions(['email', 'public_profile', 'user_posts']);
  //    //,publish_actions,manage_pages,publish_pages,user_status,user_videos,user_work_history
  //
  //    switch (result.status) {
  //      case FacebookLoginStatus.loggedIn:
  //        final FacebookAccessToken accessToken = result.accessToken;
  //        accessToken.permissions;
  //
  //        var graphResponse = await http.get(
  //            'https://graph.facebook.com/v2.12/me?fields=name,first_name,picture,last_name,email&access_token=${accessToken.token}');
  //        Map<String, dynamic> user = json.decode(graphResponse.body);
  //        Map<String, dynamic> picture = user['picture'];
  //        Map<String, dynamic> data = picture['data'];
  //        Util.userName = user['name'];
  //        Util.emailId = user['email'];
  //        Util.profilePic = data['url'];
  //        var graphResponseFeed = await http.get(
  //            'https://graph.facebook.com/v2.12/me/feed?fields=message&access_token=${accessToken.token}');
  //        var data1 = json.decode(graphResponseFeed.body);
  //        // print(data1);
  //
  //        // me?fields=id,name,feed{message,attachments}
  //        var graphResponseFeed1 = await http.get(
  //            'https://graph.facebook.com/v2.12/me?fields=id,name,feed{attachments,message}&access_token=${accessToken.token}');
  //        var data1l = json.decode(graphResponseFeed1.body);
  //        Map<String, dynamic> root = json.decode(graphResponseFeed1.body);
  //        Map<String, dynamic> feed = root['feed'];
  //        var fdata = feed['data'];
  //
  //        for (var i = 0; i < fdata.length; i++) {
  //          var qq = fdata[i];
  //          // var pp = qq['attachments'];
  //          if (qq['attachments'] == null) {
  //            i++;
  //          } else {
  //            Map<String, dynamic> pp = qq['attachments'];
  //            var nn = pp['data'];
  //            for (var j = 0; j < nn.length; j++) {
  //              var mm = nn[j];
  //              var jj = mm['media'];
  //              var img = jj['image'];
  //              var src = img['src'];
  //              print(src);
  //              Util.descriptionList.add(mm['description']);
  //              Util.mediaList.add(img['src']);
  //              // Util.listItems.add(new ListItem(mm['description'], img['src']));
  //            }
  //          }
  //          NavigationRouter.switchToHome(context);
  //        }
  //        break;
  //      case FacebookLoginStatus.cancelledByUser:
  //        _showMessage('Login cancelled by the user.');
  //        break;
  //      case FacebookLoginStatus.error:
  //        _showMessage('Something went wrong with the login process.\n'
  //            'Here\'s the error Facebook gave us: ${result.errorMessage}');
  //        break;
  //    }
  //  }
  //
  //  Future<Null> _logOut() async {
  //    await facebookSignIn.logOut();
  //    _showMessage('Logged out.');
  //  }
  //
  //  void _showMessage(String message) {
  //    setState(() {
  //      _message = message;
  //    });
  //  }
  //
  //  String _validatePassword(String value) {
  //    if (value.length < 8) {
  //      return 'The Password must be at least 8 characters.';
  //    }
  //
  //    return null;
  //  }
  //
  //  String _validateEmail(String value) {
  //    if (!(value.length > 0 && value.contains("@") && value.contains("."))) {
  //      return 'The E-mail Address must be a valid email address.';
  //    }
  //    return null;
  //  }
  //
  //  void _submit() {
  //    if (this._formKey.currentState.validate()) {
  //      _formKey.currentState.save(); // Save our form now.
  //
  //      print('Printing the login data.');
  //      print('Email: ${_data.email}');
  //      print('Password: ${_data.password}');
  //    }
  //  }
  //
  ///* void _performLogin() {
  //   // This is just a demo, so no actual login here.
  //   final snackbar = new SnackBar(
  //     content: new Text('Email: $_email, password: $_password'),
  //   );
  //
  //   scaffoldKey.currentState.showSnackBar(snackbar);
  // }*/
  //  @override
  //  Widget build(BuildContext context) {
  //    MediaQueryData media = MediaQuery.of(context);
  //
  //    final Size screenSize = media.size;
  //    return new Scaffold(
  //      //key: this.scaffoldKey,
  //      appBar: new AppBar(
  //        title: new Text('Login'),
  //      ),
  //      body: new Container(
  //          padding: new EdgeInsets.all(20.0),
  //          child: new Form(
  //            key: this._formKey,
  //            child: new ListView(
  //              children: <Widget>[
  //                new Container(
  //                    padding: new EdgeInsets.all(20.0),
  //                    child: new Row(
  //                      mainAxisAlignment: MainAxisAlignment.center,
  //                      children: <Widget>[
  //                        FlutterLogo(
  //                          size: 100.0,
  //                        ),
  //                      ],
  //                    )),
  //                new Container(
  //                    padding: const EdgeInsets.only(top: 10.0),
  //                    child: new TextFormField(
  //                        keyboardType: TextInputType.emailAddress,
  //                        // Use email input type for emails.
  //                        decoration: new InputDecoration(
  //                            hintText: 'you@example.com',
  //                            labelText: 'E-mail Address',
  //                            icon: new Icon(Icons.email)),
  //                        validator: this._validateEmail,
  //                        onSaved: (String value) {
  //                          this._data.email = value;
  //                        })),
  //                new Container(
  //                  padding: const EdgeInsets.only(top: 10.0),
  //                  child: new TextFormField(
  //                      obscureText: true, // Use secure text for passwords.
  //                      decoration: new InputDecoration(
  //                          hintText: 'Password',
  //                          labelText: 'Enter your password',
  //                          icon: new Icon(Icons.lock)),
  //                      validator: this._validatePassword,
  //                      onSaved: (String value) {
  //                        this._data.password = value;
  //                      }),
  //                ),
  //                new Container(
  //                  width: screenSize.width,
  //                  child: new Row(
  //                    mainAxisAlignment: MainAxisAlignment.center,
  //                    children: <Widget>[
  //                      new Container(
  //                        height: 50.0,
  //                        margin: const EdgeInsets.only(left: 10.0, top: 30.0),
  //                        child: new RaisedButton(
  //                          child: new Text(
  //                            'Login',
  //                            style: new TextStyle(color: Colors.white),
  //                          ),
  //                          onPressed: this._submit,
  //                          color: Colors.deepPurple,
  //                        ),
  //                      ),
  //                      new Container(
  //                        height: 50.0,
  //                        margin: const EdgeInsets.only(left: 20.0, top: 30.0),
  //                        child: new RaisedButton(
  //                          child: new Text(
  //                            'Registration',
  //                            style: new TextStyle(color: Colors.white),
  //                          ),
  //                          onPressed: _navigateRegistration,
  //                          color: Colors.deepPurple,
  //                        ),
  //                      )
  //                    ],
  //                  ),
  //                ),
  //                new Container(
  //                  width: screenSize.width,
  //                  child: new Column(
  //                    children: <Widget>[
  //                      new Container(
  //                        margin: const EdgeInsets.only(left: 10.0, top: 20.0),
  //                        child: new Row(
  //                          mainAxisAlignment: MainAxisAlignment.center,
  //                          children: <Widget>[
  //                            new Container(
  //                              height: 50.0,
  //                              width: 210.0,
  //                              child: new RaisedButton.icon(
  //                                label: new Text(
  //                                  'Login with Google+',
  //                                  style: new TextStyle(
  //                                    color: Colors.white,
  //                                  ),
  //                                ),
  //                                icon: new Image.asset("assets/google_plus.png",
  //                                    width: 24.0, height: 24.0),
  //                                onPressed: () => _googleSignInButton().then(
  //                                      (FirebaseUser user) {
  //                                    print(user);
  //                                    http.get(
  //                                        "https://developers.google.com/apis-explorer/#p/youtube/v3/youtube.subscriptions.list?part=snippet,contentDetails&mine=true");
  //                                  },
  //                                ).catchError((e) => print(e)),
  //                                color: Colors.red,
  //                              ),
  //                            ),
  //                          ],
  //                        ),
  //                      ),
  //                      new Container(
  //                        margin: const EdgeInsets.only(left: 10.0, top: 20.0),
  //                        child: new Row(
  //                          mainAxisAlignment: MainAxisAlignment.center,
  //                          children: <Widget>[
  //                            new Container(
  //                              height: 50.0,
  //                              width: 210.0,
  //                              child: new RaisedButton.icon(
  //                                label: new Text(
  //                                  'Login with Facebook',
  //                                  style: new TextStyle(
  //                                    color: Colors.white,
  //                                  ),
  //                                ),
  //                                icon: new Image.asset(
  //                                  "assets/facebook.png",
  //                                  width: 24.0,
  //                                  height: 24.0,
  //                                ),
  //                                // icon: const Icon(Icons.adjust, size: 28.0,color: Colors.white),
  //
  //                                onPressed: this._facebookLogin,
  //                                color: Colors.indigo,
  //                              ),
  //                            ),
  //                          ],
  //                        ),
  //                      )
  //                    ],
  //                  ),
  //                )
  //              ],
  //            ),
  //          )),
  //    );
  //  }
  //
  //  _navigateRegistration() {
  //    NavigationRouter.switchToRegistration(context);
  //  }
  //}
