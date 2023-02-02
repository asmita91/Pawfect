import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pawfect/model/dogModel.dart';
import 'package:pawfect/repositories/DogRepository.dart';

import '../model/favModel.dart';
import '../model/user_model.dart';
import '../repositories/FavoriteRepository.dart';
import '../repositories/auth_repositories.dart';
import '../services/firebase_service.dart';

class AuthViewModel with ChangeNotifier {
  User? _user = FirebaseService.firebaseAuth.currentUser;

  User? get user => _user;

  UserModel? _loggedInUser;
  UserModel? get loggedInUser => _loggedInUser;

  Future<void> login(String email, String password) async {
    try {
      var response = await AuthRepository().login(email, password);
      _user = response.user;
      _loggedInUser = await AuthRepository().getUserDetail(_user!.uid);
      notifyListeners();
    } catch (err) {
      AuthRepository().logout();
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await AuthRepository().resetPassword(email);
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> register(UserModel user) async {
    try {
      var response = await AuthRepository().register(user);
      _user = response!.user;
      _loggedInUser = await AuthRepository().getUserDetail(_user!.uid);
      notifyListeners();
    } catch (err) {
      AuthRepository().logout();
      rethrow;
    }
  }

  Future<void> checkLogin() async {
    try {
      _loggedInUser = await AuthRepository().getUserDetail(_user!.uid);
      notifyListeners();
    } catch (err) {
      _user = null;
      AuthRepository().logout();
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await AuthRepository().logout();
      _user = null;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  FavoriteRepository _favoriteRepository = FavoriteRepository();
  List<FavoriteModel> _favorites = [];
  List<FavoriteModel> get favorites => _favorites;

  List<DogModel>? _favoriteDog;
  List<DogModel>? get favoriteDog => _favoriteDog;

  Future<void> getFavoritesDog() async {
    try {
      var response =
          await _favoriteRepository.getFavoritesDog(loggedInUser!.userId!);
      _favorites = [];
      for (var element in response) {
        _favorites.add(element.data());
      }
      _favoriteDog = [];
      if (_favorites.isNotEmpty) {
        var dogResponse = await DogRepository()
            .getDogsFromList(_favorites.map((e) => e.dogId).toList());
        for (var element in dogResponse) {
          _favoriteDog!.add(element.data());
        }
      }

      notifyListeners();
    } catch (e) {
      print(e);
      _favorites = [];
      _favoriteDog = null;
      notifyListeners();
    }
  }

  Future<void> favoriteAction(FavoriteModel? isFavorite, String dogId) async {
    try {
      await _favoriteRepository.favorite(
          isFavorite, dogId, loggedInUser!.userId!);
      await getFavoritesDog();
      notifyListeners();
    } catch (e) {
      _favorites = [];
      notifyListeners();
    }
  }

  List<DogModel>? _myDog;
  List<DogModel>? get myDog => _myDog;

  Future<void> getMyDogs() async {
    try {
      var dogResponse = await DogRepository().getMyDogs(loggedInUser!.userId!);
      _myDog = [];
      for (var element in dogResponse) {
        _myDog!.add(element.data());
      }
      notifyListeners();
    } catch (e) {
      print(e);
      _myDog = null;
      notifyListeners();
    }
  }

  Future<void> addMyDog(DogModel dog) async {
    try {
      await DogRepository().addDogs(dogModel: dog);

      await getMyDogs();
      notifyListeners();
    } catch (e) {}
  }

  Future<void> editMyDog(DogModel dog, String dogId) async {
    try {
      await DogRepository().editDog(dog: dog, dogId: dogId);
      await getMyDogs();
      notifyListeners();
    } catch (e) {}
  }

  Future<void> deleteMyDog(String dogId) async {
    try {
      await DogRepository().removeDog(dogId, loggedInUser!.userId!);
      await getMyDogs();
      notifyListeners();
    } catch (e) {
      print(e);
      _myDog = null;
      notifyListeners();
    }
  }
}
