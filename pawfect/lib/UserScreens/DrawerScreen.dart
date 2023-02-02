import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pawfect/constants/Colors.dart';
import 'package:pawfect/constants/configuration.dart';
import 'package:provider/provider.dart';

import '../ViewModel/GlobalUIViewModel.dart';
import '../ViewModel/auth_viewmodel.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  late GlobalUIViewModel _ui;
  late AuthViewModel _auth;
  void logout() async {
    _ui.loadState(true);
    try {
      await _auth.logout().then((value) {
        Navigator.of(context).pushReplacementNamed('/UserLogin');
      }).catchError((e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
      });
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
    _ui.loadState(false);
  }

  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _auth = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BackColor,
      padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                child: CircleAvatar(
                  backgroundImage: AssetImage('Assets/img_4.png'),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed("/Profile");
                },
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_auth.loggedInUser!.name.toString(),
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold)),
                  Text(
                    "Online",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
          Column(
            children: drawerItems
                .map((elements) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          switch (elements['title']) {
                            case 'Adoption':
                              Navigator.pushNamed(context, '/adoption');
                              break;
                            case 'Payment':
                              Navigator.pushNamed(context, '/Payment');
                              break;
                            case 'Favorites':
                              Navigator.pushNamed(context, '/Favorites');
                              break;
                            case 'Profile':
                              Navigator.pushNamed(context, '/Profile');
                              break;
                            default:
                              break;
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                              elements['icons'],
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(width: 10),
                            Text(elements['title'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15))
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
          InkWell(
            onTap: logout,
            child: Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                InkWell(
                  child: Text("Settings",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.of(context).pushNamed("/About");
                  },
                ),
                SizedBox(width: 10),
                Container(width: 2, height: 20, color: Colors.white),
                SizedBox(width: 10),
                Text("Log out",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
