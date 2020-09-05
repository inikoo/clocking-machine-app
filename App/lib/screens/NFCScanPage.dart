import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';

class NFCScanPage extends StatefulWidget {
  @override
  _NFCScanPageState createState() => _NFCScanPageState();
}

class _NFCScanPageState extends State<NFCScanPage> {
  TextEditingController writerController = TextEditingController();
  bool _reading = false;
  String data = "";

  @override
  initState() {
    super.initState();
    writerController.text = 'Flutter NFC Scan';
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      print(onData.id);
      print(onData.content);
    });
  }

  @override
  void dispose() {
    writerController.dispose();
    super.dispose();
  }

  void _onPressedRead() {
    setState(() => _reading = true);
    FlutterNfcReader.read(instruction: "It's reading")
        .then((value) => setState(() => _reading = true));
  }

  // void _onPressedWrite() {
  //   setState(() => _reading = false);
  //   FlutterNfcReader.write(" ", writerController.text).then((value) {
  //     print(value.content);
  //   });
  // }

  Widget customizedButton(String title, Function onPressed) {
    return SizedBox(
      height: 60,
      child: RaisedButton(
        onPressed: onPressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(143, 190, 251, 1),
                Color.fromRGBO(143, 148, 251, 0.6),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 50.0,
              minWidth: 50,
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NFC Scan Page"),
      ),
      body: Stack(
        children: [
          _reading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Reading...",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : Column(
                  children: <Widget>[
                    TextField(
                      controller: writerController,
                    ),
                  ],
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: customizedButton("Read", _onPressedRead),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(10),
                  //   child: customizedButton("Write", _onPressedWrite),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
