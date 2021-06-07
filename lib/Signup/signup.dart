import 'dart:convert';
import 'package:doctor_v2/wallet_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_v2/Login/login.dart';
import 'package:doctor_v2/Signup/signup_otp.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../services_provider.dart';

class Register extends StatefulWidget {
  final String? token;

// Receiving Token using Constructor.
  Register({
    Key? key,
    this.token,
  }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.purple),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Registration'),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  '.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            body: Center(
                child: RegisterUser(
              token: widget.token,
            ))));
  }
}

class RegisterUser extends StatefulWidget {
  final String? token;

// Receiving Token using Constructor.
  RegisterUser({
    Key? key,
    this.token,
  }) : super(key: key);
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  // Boolean variable for CircularProgressIndicator.
  bool visible = false;

  // Getting value from TextField widget.
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final hnameController = TextEditingController();
  //final emailController = TextEditingController();
  final d_idController = TextEditingController();
  // final pubController = TextEditingController();
  final accController = TextEditingController();

  Future userRegistration() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    // ignore: non_constant_identifier_names
    String first_name = fnameController.text;

    // ignore: non_constant_identifier_names
    String last_name = lnameController.text;
    // ignore: non_constant_identifier_names
    // String email = emailController.text;
    // String pub = pubController.text;
    String acc = accController.text;
    String d_id = d_idController.text;

    // SERVER API URL
    var url = Uri.parse(
        'http://10.10.172.253/doctor_php/doctor_v2/signup/doctor_registration.php');

    // Store all data with Param Name.
    var data = {
      'first_name': first_name,
      'last_name': last_name,
      'h_name': h_name,
      // 'email': email,
      // 'pub': pub,
      'acc': acc,
      'd_id': d_id
    };

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }

    // Showing Alert Dialog with Response JSON Message.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: new Text("Got It"),
              onPressed: () {
                if (message ==
                    "Sorry! we could not found info against provided ID") {
                  Navigator.of(context).pop();
                } else if (message != "ID Already Exist") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Code(),
                      ));
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  String h_name = "";

  //Validation
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  void _validate() async {
    if (_form.currentState!.validate()) userRegistration();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.token != null) accController.text = widget.token!;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Doctor Registration Form',
                    style: TextStyle(fontSize: 21))),

            //for first name
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextFormField(
                controller: fnameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'First Name Required';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  hintText: "First Name",
                  hintStyle: TextStyle(color: Colors.grey),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.orange)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Colors.orange)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),
            //for last name
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextFormField(
                controller: lnameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Last Name Required';
                  }
                  return null;
                },
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  hintText: "Last Name",
                  hintStyle: TextStyle(color: Colors.grey),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.orange)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Colors.orange)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30),
              ),
              child: DropDown<String>(
                items: <String>["AUH", "CMUH", "CGMH"],
                customWidgets: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                    child: Text("AUH"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                    child: Text("CMUH"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                    child: Text("CGMH"),
                  ),
                ],
                hint: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                  child: Text(
                    "Select Hospital",
                    style: TextStyle(),
                  ),
                ),
                onChanged: (v) {
                  h_name = v;
                },
                showUnderline: false,
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextFormField(
                controller: accController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field Required';
                  }
                  return null;
                },
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  hintText: "Ethereum Address",
                  hintStyle: TextStyle(color: Colors.grey),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(
                    Icons.code_outlined,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.orange)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Colors.orange)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),
            Container(
              child: TextButton(
                  onPressed: () async {
                    WidgetsFlutterBinding.ensureInitialized();
                    final stores =
                        await createProviders(AppConfig().params['ropsten']!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainApp(stores)),
                    );
                  },
                  child: Text("Click here to Create Ethereum Account")),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextFormField(
                controller: d_idController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field Required';
                  } else if (value.length < 3) {
                    return 'Length must be more then 4 character';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                ),
                obscuringCharacter: "*",
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Doctor ID",
                  hintStyle: TextStyle(color: Colors.grey),
                  suffixIcon: Icon(
                    Icons.lock_sharp,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.orange)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.orange)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),
            // ignore: deprecated_member_use
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 35),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Colors.yellow,
                onPressed: () {
                  _validate();
                },
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  'Register',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Text(
                  'Already have an account?',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.visible,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login_otp1()),
                    );
                  },
                  splashColor: Colors.grey.shade200,
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
            ),

            Visibility(
                visible: visible,
                child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: CircularProgressIndicator())),
          ],
        ),
      ),
    )));
  }
}
