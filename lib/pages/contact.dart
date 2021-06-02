import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sprout/widget/imagecached.dart';
import 'package:sprout/widget/slide.dart';
import 'package:sprout/widget/tile.dart';
import 'package:http/http.dart' as http;

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  List user = [];
  bool loading = false;
  Map<int, bool> itemSelected = Map();

  @override
  void initState() {
    super.initState();
    this.getUserJsonData();
  }

  getUserJsonData() async {
    setState(() {
      loading = true;
    });
    var url = Uri.parse("https://reqres.in/api/users?per_page=12");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['data'];
      setState(() {
        user = data;
        loading = false;
      });
    } else {
      setState(() {
        user = [];
        loading = false;
      });
    }
  }

  Widget buildBody() {
    if (user.contains(null) || user.length < 0 || loading) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
      ));
    }
    return ListView.builder(
        itemCount: user == null ? 0 : user.length,
        itemBuilder: (context, index) {
          return SlidableWidget(
            onDismissed: null,
            child: CustomTile(
              leading: Container(
                constraints: BoxConstraints(
                    maxHeight: 100,
                    maxWidth: 100,
                    minHeight: 100,
                    minWidth: 100),
                child: ProfileCached(
                  user[index]['avatar'],
                  isRound: false,
                ),
              ),
              onTap: () {},
              icon: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    shape: BoxShape.circle,
                    color: Colors.green),
              ),
              title: Text(
                user[index]['first_name'] + " " + user[index]['last_name'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                user[index]['email'],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: null,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                currentAccountPicture: ProfileCached(
                  'https://cdn.techinasia.com/data/images/ljDtMLroAlDtnz51kthF4wrQdpbu9yUb7ed055Bg.png',
                  height: 100,
                  width: 100,
                  // isRound: true,
                  // radius: 50,
                ),
                accountName: Text(
                  'Sprout Digital Labs',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ListTile(
                title: Text("Kontak", style: TextStyle(color: Colors.white)),
              ),
              ListTile(
                title: Text(
                  "Panggilan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Pengaturan",
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contacts'),
      ),
      body: buildBody(),
    );
  }
}
