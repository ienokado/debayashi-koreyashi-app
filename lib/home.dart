import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './util/hex_color.dart';
import 'search_result.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController inputText = TextEditingController();
  int _selectedIndex = 1;

  // タブメニューのタップ時
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  getDebayashiData() async {
    Firebase.initializeApp();
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('debayashis')
        .where("comedian_group_name", isEqualTo: inputText.text).get();
    return snapshot;
  }

  // 検索ボタン押下時
  void _pressedSearchButton(BuildContext context) {
    final snapshot = getDebayashiData();
    print(snapshot);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResult(
          performerName: inputText.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: HexColor('4960FA'),
          child: Center(
              child: Container(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // TODO: 画像(SVG)の差込
//                Image.asset('assets/images/logo.jpg'),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'あの芸人の出囃子を検索しよう',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: HexColor('FFD3CF'),
                        borderRadius:  BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        style: TextStyle(color: HexColor('4960FA')),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'コンビ名で検索',
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15
                          ),
                        ),
                        controller: inputText,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: RaisedButton(
                        child: const Text('検索'),
                        color: HexColor('FFD3CF'),
                        textColor: Colors.black,
                        onPressed: () => _pressedSearchButton(context),
                      ),
                    ),
                    // TODO: 画像(SVG)の差込
//                Padding(
//                  padding: EdgeInsets.only(top: 20),
//                  child: Container(
//
//                  ),
//                )
                  ],
                ),
              )
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.history_rounded),
            label: '履歴',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: '検索',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_numbered_rtl_rounded),
            label: 'ランキング',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: HexColor('4960FA'),
        onTap: _onItemTapped,
      ),
    );
  }
}