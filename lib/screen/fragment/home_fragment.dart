import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:registration_login/utils/util.dart';
import 'package:http/http.dart' as http;

class HomeFragment extends StatefulWidget {
  List<String> list = Util.mediaList;
  List<String> listDe = Util.descriptionList;

  @override
  _HomeFragmentState createState() => new _HomeFragmentState();
}

class ListItems {
  String title;
  String mediaImage;

  ListItems(this.title, this.mediaImage);
}

class _HomeFragmentState extends State<HomeFragment> {
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getYoutubeData();
  }

  getYoutubeData() async {
    //GET https://www.googleapis.com/youtube/v3/channels?access_token=<access_token>&part=snippet&mine=true
    String url="https://www.googleapis"
        ".com/youtube/v3/subscriptions?access_token${Util.authToken}=&part"
        "=snippet&mine=true&key=AIzaSyCHU99nf9JpN64AVsH4SUPTinZ--ZYmg0k";
    var data = await http.get(url);
    var json1 = json.decode(data.body);
    print(json1);
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.list.length; i++) {
      var d = widget.list[i];
      var l = "";
      if (widget.listDe[i] != null) {
        l = widget.listDe[i];
      } else {
        //l ="Test data";
      }

      print(l);
      drawerOptions.add(new Column(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Image.network(
                d,
              ),
              new Text(
                l,
                style: new TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              ),
              new Divider(
                color: Colors.deepPurple,
                height: 2.0,
              )
            ],
          )
          /* new ListTile(

                leading: new Image.network(
                    d,
                ),
                title: new Text(
                    "",
                    style: new TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold
                    )),
                selected: i == _selectedIndex,
              //  onTap: () => _onSelectItem(i),
              ),*/
        ],
      ));
    }
    return new Scaffold(
      body: new Container(
        child: new ListView(
          children: <Widget>[
            InkWell(
              child: Container(
                child: Text("TAp"),
              ),
              onTap: () {
                getYoutubeData();
              },
            )
          ],
        ),
      ),
    );
  }
}
