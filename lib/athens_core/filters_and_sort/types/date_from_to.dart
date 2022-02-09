import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/athens_core/filters_and_sort//choose_date_bottom_sheet.dart';
import 'package:project_athens/athens_core/filters_and_sort/types/base_filter_type.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:provider/provider.dart';

class DateFromTo extends BaseFilterType {
  DateTime fromTime;
  DateTime toTime;

  DateFromTo({required this.fromTime, required this.toTime});

  @override
  BaseFilterType copy() => DateFromTo(fromTime: fromTime, toTime: toTime);

  @override
  Widget buildFilter(BuildContext parentContext) {
    final theme = Theme.of(parentContext);
    final localizations = Provider.of<AppLocalizations>(parentContext);

    return ChangeNotifierProvider<DateFromTo>.value(
      value: this,
      child: Consumer<DateFromTo>(
        builder: (context, type, child) => Row(
          children: [
            _buildDateColumn(parentContext, theme, localizations().filtersFiltersDateFrom(), fromTime,
                () async {
              fromTime = await showDateChooserBottomSheet(parentContext,
                      firstSelectedDate: fromTime, maxDate: toTime) ??
                  fromTime;
              notifyListeners();
            }),
            _buildDateColumn(parentContext, theme, localizations().filtersFiltersDateTo(), toTime,
                () async {
              toTime = await showDateChooserBottomSheet(parentContext,
                      firstSelectedDate: toTime, minDate: fromTime) ??
                  toTime;
              notifyListeners();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDateColumn(BuildContext parentContext, ThemeData theme,
      String title, DateTime date, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
          GestureDetector(
            child: Container(
              child: Text(
                DateFormat("d.MM.y", "pl").format(date),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              margin: EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                  border: Border.all(color: theme.dividerColor),
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
            onTap: onTap,
          )
        ],
      ),
    );
  }
}
