import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/utilities/app_theme.dart';

import '../providers/list_provider.dart';

class EasyDateTimeLine extends StatelessWidget {
  late ListProvider listProvider;

  EasyDateTimeLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);

    return EasyInfiniteDateTimeLine(
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      focusDate: listProvider.selectedDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      onDateChange: (selectedDate) {
        listProvider.onSelectedDateChanged(selectedDate);
      },
      showTimelineHeader: false,
      itemBuilder:
          (context, dayNumber, dayName, monthName, fullDate, isSelected) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppTheme.whiteColor),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              child: Column(
                children: [
                  Expanded(
                      child: Text(
                    dayName,
                    style: isSelected
                        ? AppTheme.selectedDateTimeTextStyle
                        : AppTheme.unSelectedDateTimeTextStyle,
                  )),
                  Expanded(
                      child: Text(
                    dayNumber,
                    style: isSelected
                        ? AppTheme.selectedDateTimeTextStyle
                        : AppTheme.unSelectedDateTimeTextStyle,
                  )),
                  Expanded(
                      child: Text(
                    monthName,
                    style: isSelected
                        ? AppTheme.selectedDateTimeTextStyle
                        : AppTheme.unSelectedDateTimeTextStyle,
                  )),
                  Expanded(
                      child: Text(
                    fullDate.year.toString(),
                    style: isSelected
                        ? AppTheme.selectedDateTimeTextStyle
                        : AppTheme.unSelectedDateTimeTextStyle,
                  )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
