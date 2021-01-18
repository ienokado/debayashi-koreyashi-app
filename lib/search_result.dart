import 'package:flutter/material.dart';
import './util/hex_color.dart';

class SearchResult extends StatelessWidget {
  SearchResult({ this.performerName });

  final dynamic performerName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor('4960FA'),
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(performerName),
                RaisedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: new Text('戻る')
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}