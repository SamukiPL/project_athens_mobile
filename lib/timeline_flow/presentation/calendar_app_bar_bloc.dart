import 'package:project_athens/athens_core/presentation/base_change_notifier.dart';

class CalendarAppBarBloc extends BaseChangeNotifier {

  DateTime _date;

  CalendarAppBarBloc(this._date);

  DateTime get date => _date;

  void setDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

}