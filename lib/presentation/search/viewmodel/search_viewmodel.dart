import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraxproperty/data/api-request/search_request.dart';

class SearchViewModel extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  bool isKeyboardVisible = false;

  List searchResult = [];

  changeKeyboardVisibility(bool value) {
    isKeyboardVisible = value;
    notifyListeners();
  }

  Future searchForProps(String q) async {
    SearchRequest searchRequest = SearchRequest();
    try {
      final res = await searchRequest.searchForProperties(q);
      searchResult = res;
      // notifyListeners();
      return res;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return e;
    }
  }

  toggleNotifyListener(){
    notifyListeners();
  }
}
