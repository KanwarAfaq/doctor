import 'package:doctor_v2/profile/Select_Test_Screen.dart';
import 'package:doctor_v2/Model/TokenModel.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../Login/login.dart';

class QRScreen extends StatefulWidget {
  final String data;
  final String email;
  final TokenModel tokenModel;

  QRScreen({
    Key? key,
    required this.data,
    required this.email,
    required this.tokenModel,
  }) : super(key: key);
  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  @override
  Widget build(BuildContext context) {
    var listTest = widget.data.split(",");
    var qR = "Address = \n" +
        widget.tokenModel.account! +
        "," +
        "\n" +
        "Public Key =\n " +
        widget.tokenModel.pub_key! +
        "," +
        "\n" +
        "Required Test = \n" +
        widget.data;
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              color: Colors.pink,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Login_otp1()));
              })
        ],
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: QrImage(
                    data: qR,
                    version: QrVersions.auto,
                    size: 320,
                    gapless: false,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "You Have Selected",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      ...List.generate(
                        listTest.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Text(
                                    listTest[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
