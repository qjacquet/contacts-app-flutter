import 'dart:convert';
import 'package:contactsapp/src/home/home_bloc.dart';
import 'package:contactsapp/src/home/home_module.dart';
import 'package:contactsapp/src/shared/helpers/index.dart';
import 'package:flutter/material.dart';

import 'edit_page.dart';

class ViewPage extends StatefulWidget {
  static String tag = 'view-page';

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  static String defaultMessage = "Information indisponible";

  Map contact;

  HomeBloc blocHome;

  @override
  void initState() {
    blocHome = HomeModule.to.getBloc<HomeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListView content(context, Map snapshot) {
      return ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              buildHeader(context, snapshot),
              buildInformation(snapshot),
            ],
          )
        ],
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: StreamBuilder(
          stream: blocHome.favoriteOut,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return AppBar(
                elevation: 0,
                actions: <Widget>[
                  IconButton(
                    color: Colors.white,
                    icon: snapshot.data
                        ? Icon(Icons.star)
                        : Icon(Icons.star_border),
                    onPressed: () {
                      blocHome.updateFavorite(
                          this.contact['id'], !snapshot.data);
                      blocHome.getListContact();
                    },
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      EditPage.contact = this.contact;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditPage()),
                      );
                    },
                  ),
                  // IconButton(
                  //   color: Colors.white,
                  //   icon: Icon(Icons.more_vert),
                  //   onPressed: () {},
                  // ),
                ],
              );
            }
          },
        ),
      ),
      body: StreamBuilder(
        stream: blocHome.contactOut,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            this.contact = snapshot.data;
            blocHome.setFavorite(snapshot.data['favorite'] == 1);
            return content(context, snapshot.data);
          }
        },
      ),
    );
  }

  Container buildHeader(BuildContext context, dynamic item) {
    return Container(
      decoration: BoxDecoration(color: Colors.indigo),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.40,
      child: Column(
        children: <Widget>[
          Container(
            height: 180,
            width: 180,
            child: item['photo'] == null ? CircleAvatar(
              child: Text(
                item['firstName'].substring(0, 1).toUpperCase(),
                style: TextStyle(fontSize: 26, color: Colors.white60),
              ),
            ) :
            CircleAvatar(
              backgroundImage: MemoryImage(base64Decode(item['photo'])),
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  item['firstName'] + ' ' + item['lastName'],
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              (item['birthDate'] != '') ? Container(
                child: Text(
                  getAgeFromDateTime(DateTime.parse(item['birthDate'])) + ' ans',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ) : Container(),
              item['job'] != '' ? Container(
                child: Text(
                  (item['birthDate'] != '') ? ' - ' + item['job'] : item['job'],
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ) : Container(),
            ],
          )
        ],
      ),
    );
  }

  Padding buildInformation(item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text(item['phoneNumber'].toString().isNotEmpty
                  ? item['phoneNumber']
                  : defaultMessage),
              subtitle: Text(
                "Téléphone",
                style: TextStyle(color: Colors.black54),
              ),
              leading: IconButton(
                icon: Icon(Icons.phone, color: Colors.indigo),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(item['email'].toString().isNotEmpty ? item['email'] : defaultMessage),
              subtitle: Text(
                "Email",
                style: TextStyle(color: Colors.black54),
              ),
              leading: IconButton(
                  icon: Icon(Icons.email, color: Colors.indigo),
                  onPressed: () {}),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(item['comments'].toString().isNotEmpty ? item['comments'] : defaultMessage),
              subtitle: Text(
                "Commentaires",
                style: TextStyle(color: Colors.black54),
              ),
              leading: IconButton(
                  icon: Icon(Icons.create, color: Colors.indigo),
                  onPressed: () {}),
            ),
          ),
        ],
      ),
    );
  }
}
