import 'package:doctor_v2/Model/SelectTestModel.dart';
import 'package:doctor_v2/QR/QR_Screen.dart';
import 'package:doctor_v2/Service.dart';
import 'package:doctor_v2/Model/TokenModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectTestScreen extends StatefulWidget {
  final String email;
  final TokenModel tokenModel;

// Receiving Email using Constructor.
  SelectTestScreen({
    Key? key,
    required this.email,
    required this.tokenModel,
  }) : super(key: key);

  @override
  _SelectTestScreenState createState() => _SelectTestScreenState();
}

final globalKey = GlobalKey<ScaffoldState>();

class _SelectTestScreenState extends State<SelectTestScreen> {
  SelectTestModel? items;
  bool hasData = false;

  @override
  void initState() {
    Services.getTest().then((testFromServer) {
      setState(() {
        items = testFromServer;
        hasData = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          String test = selectedTest.join(',');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QRScreen(
                data: test,
                email: widget.email,
                tokenModel: widget.tokenModel,
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
                  "Generate QR",
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
      key: globalKey,
      appBar: AppBar(
        title: Text('Select Test'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: hasData == false
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: new CupertinoActivityIndicator(
                        animating: true,
                        radius: 25,
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Please Select Required Test",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ...List.generate(
                        items!.result!.length,
                        (index) {

                          return Selection(
                            items: items!.result![index],

                          );
                        },
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class Selection extends StatefulWidget {
  const Selection({
    Key? key,
    required this.items,

  }) : super(key: key);

  final Result items;

  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 1,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Text(
                        widget.items.pname! + ">",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      widget.items.name!,
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Checkbox(
                  onChanged: (bool? value) {
                    setState(() {
                      isSelected = !isSelected;
                      if (isSelected) {

                        addTest(t: widget.items.name!);
                      } else {
                        removeTest(t: widget.items.name!);
                      }
                    });
                  },
                  activeColor: Colors.green,
                  value: isSelected,
                  //  <-- leading Checkbox
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<String> selectedTest = [];

void addTest({required String t}) {
  if (!selectedTest.contains(t)) selectedTest.add(t);
}

void removeTest({required String t}) {
  if (selectedTest.contains(t)) selectedTest.remove(t);
}
