import 'package:doctor_v2/profile/Select_Test_Screen.dart';
import 'package:doctor_v2/Model/TokenModel.dart';
import 'package:doctor_v2/Login/login.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
// Creating String Var to Hold sent Email.
  final String email;
  final TokenModel tokenModel;

// Receiving Email using Constructor.
  ProfileScreen({
    Key? key,
    required this.email,
    required this.tokenModel,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  logout(BuildContext context) {
    //Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login_otp1(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.purple),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            bottomNavigationBar: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectTestScreen(
                      tokenModel: widget.tokenModel,
                      email: widget.email,
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Select Test",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            appBar: AppBar(
                title: Text('Profile'),
                actions: [
                  IconButton(
                      icon: Icon(Icons.exit_to_app),
                      color: Colors.pink,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login_otp1()));
                      })
                ],
                automaticallyImplyLeading: false),
            body: Center(
                child: Column(
              children: <Widget>[
                Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Name = ' +
                        widget.tokenModel.firstname! +
                        "  " +
                        widget.tokenModel.lastname!,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Account Address = ' + widget.tokenModel.account!,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                // Container(
                //   width: 280,
                //   padding: EdgeInsets.all(10.0),
                //   child: Text(
                //     'Public Key = ' + widget.tokenModel.pub_key!,
                //     style: TextStyle(fontSize: 20),
                //   ),
                // ),
                Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Email = ' + widget.email,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     Clipboard.setData(new ClipboardData(text: tokenModel.jwt));
                //   },
                //   onLongPress: () {
                //     Clipboard.setData(new ClipboardData(text: tokenModel.jwt));
                //   },
                //   child: Container(
                //     width: 280,
                //     padding: EdgeInsets.all(10.0),
                //     child: Text(
                //       'Token = ' + tokenModel.jwt,
                //       style: TextStyle(fontSize: 20),
                //     ),
                //   ),
                // ),

                // Wrap(
                //   alignment: WrapAlignment.center,
                //   crossAxisAlignment: WrapCrossAlignment.center,
                //   children: <Widget>[
                //     Text(
                //       "want logiut?",
                //       style: GoogleFonts.muli(
                //         fontSize: 18,
                //         fontWeight: FontWeight.w300,
                //       ),
                //       textAlign: TextAlign.left,
                //       overflow: TextOverflow.visible,
                //     ),
                //     FlatButton(
                //       onPressed: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => Login_otp1(),
                //           ),
                //         );
                //       },
                //       splashColor: Colors.grey.shade200,
                //       child: Text(
                //         'Logout',
                //         style: TextStyle(
                //             color: Colors.pinkAccent,
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ))));
  }
}
