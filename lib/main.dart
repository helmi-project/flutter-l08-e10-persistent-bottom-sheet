import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  VoidCallback _showPersistentSheet;

  @override
  void initState() {
    super.initState();

    _showPersistentSheet = _sheetBottomSheet;
  }

  void _sheetBottomSheet() {
    setState(() {
      _showPersistentSheet = null;
    });

    _scaffoldKey.currentState
        .showBottomSheet((content) {
          //Menampilkan konten bottom sheet menggunakan widget Container
          return Container(
            color: Colors.blue,
            height: 200,
            child: Center(
              child: Text(
                'Welcome to Android ATC',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          );
        })
        .closed
        .whenComplete(() {
          //.closed.whenComplete() untuk mengembalikan value dari fungsi _showpersistentSheet lagi ke interface sebelum user menekan tombol Persistent Bottom Sheet dan mendapatkan bottom sheet
          //Jika mengklik tombol panah kembali di app bar judul setelah menekan tombol Persistent Button, fungsi _showPersistentSheet akan aktif atau mengembalikan value aslinya. Artinya user dapat mengklik tombol Persistent Button lagi
          if (mounted) {
            setState(() {
              _showPersistentSheet = _sheetBottomSheet;
            });
          }
        });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Persistent Bottom Sheet Widget'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 50,
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'Persistent Botton Sheet',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () {
                          _showPersistentSheet();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 50,
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'Test Button',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
