// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

FavoriteModel favoriteModelFromJson(String str) =>
    FavoriteModel.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModel data) => json.encode(data.toJson());

class FavoriteModel {
  FavoriteModel({
    required this.userId,
    this.id,
    required this.dogId,
  });

  String? id;
  String userId;
  String dogId;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        id: json["id"],
        userId: json["user_id"],
        dogId: json["dog_id"],
      );
  factory FavoriteModel.fromFirebaseSnapshot(
          DocumentSnapshot<Map<String, dynamic>> json) =>
      FavoriteModel(
        id: json.id,
        userId: json["user_id"],
        dogId: json["dog_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "id": id,
        "dog_id": dogId,
      };
}
