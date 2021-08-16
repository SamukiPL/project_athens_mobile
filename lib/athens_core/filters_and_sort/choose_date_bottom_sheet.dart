import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

Future<DateTime?> showDateChooserBottomSheet(BuildContext parentContext,
    {required DateTime firstSelectedDate,
    DateTime? minDate, DateTime? maxDate}) {
  return showModalBottomSheet(
      context: parentContext,
      builder: (context) => _DateChooserBottomSheet(
            parentContext: parentContext,
            firstSelectedDate: firstSelectedDate,
            minDate: minDate,
            maxDate: maxDate,
          ),
      isScrollControlled: true);
}

class _DateChooserBottomSheet extends StatelessWidget {
  final BuildContext parentContext;

  final DateTime firstSelectedDate;
  final DateTime? minDate;
  final DateTime? maxDate;

  const _DateChooserBottomSheet(
      {Key? key,
      required this.parentContext,
      required this.firstSelectedDate,
      this.minDate,
      this.maxDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = Provider.of<AppLocalizations>(context);

    return Provider<DateRangePickerController>(
      create: (_) {
        final controller = DateRangePickerController();
        controller.selectedDate = firstSelectedDate;
        controller.displayDate = firstSelectedDate;
        return controller;
      },
      child: Consumer<DateRangePickerController>(
          builder: (context, controller, _) => Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(parentContext).padding.top),
                child: new Scaffold(
                  appBar: new AppBar(
                    backgroundColor: Colors.white,
                    title: Text(localizations().filtersTitle()),
                    leading: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                    actions: [
                      IconButton(
                          icon: Icon(Icons.done),
                          onPressed: () {
                            Navigator.pop(context, controller.selectedDate);
                          })
                    ],
                  ),
                  body: SfDateRangePicker(
                    controller: controller,
                    minDate: minDate,
                    maxDate: maxDate,
                  ),
                ),
              )),
      dispose: (context, controller) => controller.dispose(),
    );
  }
}
