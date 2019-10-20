import 'package:flutter/material.dart';

import 'dart:convert';
import 'strings.dart';
import 'package:http/http.dart' as http;
import 'member.dart';

class GHFlutterState extends State<GHFlutter> {
  var _members = <Member>[];
  final _biggetFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.appTitle),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _members.length * 2,
        itemBuilder: (BuildContext context, int position) {
          if (position.isOdd) return Divider();
          return _buildRow(position ~/ 2);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  void _loadData() async {
    String url = "https://api.github.com/orgs/raywenderlich/members";
    http.Response response = await http.get(url);
    setState(() {
      final theJson = json.decode(response.body);
      for (var aMember in theJson) {
        final theMember = Member(aMember["login"], aMember["avatar_url"]);
        _members.add(theMember);
      }
    });
  }

  Widget _buildRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListTile(
        title: Text("${_members[i].login}", style: _biggetFont),
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          backgroundImage: NetworkImage(_members[i].avatarURI),
        ),
      ),
    );
  }
}

class GHFlutter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GHFlutterState();
  }
}
