import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pawfect/constants/configuration.dart';

class SubScreen extends StatelessWidget {
  const SubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.blueGrey.shade300,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 40, left: 10),
          child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios))),
        ),
        Container(
          margin: EdgeInsets.all(40),
          padding: EdgeInsets.only(bottom: 30),
          child: Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "Assets/img_3.png",
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.height / 2,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 130,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: shadowList,
              borderRadius: BorderRadius.circular(20),
              //add a column and values //2nd vdo 19min
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 100,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  height: 50,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff056608),
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff056608),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Adoption",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                )),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
          ),
        )
      ],
    ));
  }
}
