import 'package:flutter/material.dart';

import '../UserScreens/SubScreenDog.dart';
import 'AppColumn.dart';

class CreatePageStack extends StatelessWidget {
  final int index;
  final String dogName;
  final String dogDescription;
  final String imageLink;
  final String breed;
  final String color;
  final int price;
  const CreatePageStack(
      {required this.index,
      required this.dogName,
      required this.dogDescription,
      required this.imageLink,
      required this.breed,
      required this.color,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubScreen(index, dogName, dogDescription,
                    imageLink, price, breed, color)));
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Stack(alignment: Alignment.topCenter, children: [
            Expanded(
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: index.isEven
                        ? Color.fromRGBO(255, 255, 187, 10)
                        : Color.fromRGBO(195, 223, 195, 10),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(imageLink))),
              ),
            ),
            Container(
              height: 100,
              width: 200,
              margin: EdgeInsets.only(top: 155.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: AppColumn(
                Name: dogName,
                breed: breed,
                color: color,
                price: price,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
