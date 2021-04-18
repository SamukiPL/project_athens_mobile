import 'package:flutter/cupertino.dart';

class PaginationController extends ChangeNotifier {
  
  void loadMore() {
    notifyListeners();
  }
  
}