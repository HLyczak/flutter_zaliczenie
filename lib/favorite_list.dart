import 'package:flutter/material.dart';
import 'package:flutter_zaliczenie/post.dart';

class FavoriteList with ChangeNotifier {
  final List<User> _usersList = [];
  List<User> get users => _usersList;

  void add(User user) {
    if (!_usersList.contains(user)) {
      _usersList.add(user);
      notifyListeners();
    }
  }

  bool isFavorite(User user) {
    return _usersList.contains(user);
  }
}
