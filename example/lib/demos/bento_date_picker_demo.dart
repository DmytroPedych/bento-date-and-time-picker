import 'package:bento_datetime_picker/bento_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime date, BuildContext context) {
  final locale = Localizations.localeOf(context).toString();
  final formatter = DateFormat('d MMMM yyyy', locale);
  return formatter.format(date);
}

class BentoDatePickerDemo extends StatefulWidget {
  const BentoDatePickerDemo({super.key});

  @override
  State<BentoDatePickerDemo> createState() => _BentoDatePickerDemoState();
}

class _BentoDatePickerDemoState extends State<BentoDatePickerDemo> {
  DateTime? _selectedDate;
  DateTime _selectedDate2 = DateTime.now();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        bottom: true,
        top: true,
        child: Padding(
          padding: const EdgeInsetsDirectional.all(16.0),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ColoredBoxExample(),
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 16),
                  child: Text(
                    "Initial date:  Not definded",
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                  ),
                ),
                Text(
                  "Selected date: ${_selectedDate != null ? formatDate(_selectedDate!, context) : "Not definded"}",
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                  ),
                ),

                //WITHOUT SCROLL CONTROLLER
                BentoDatePicker(
                  label: Text(
                    'Birthday',
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                  ),
                  dateLabel: Text(
                    _selectedDate != null ? formatDate(_selectedDate!, context) : 'Not defined',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  selectedDate: _selectedDate,
                  onDateTimeChanged: (dateTime) {
                    setState(() {
                      _selectedDate = dateTime;
                    });
                  },
                ),
                const SizedBox(height: 16),
                ColoredBoxExample(),
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 16),
                  child: Text(
                    "Initial date: ${formatDate(_selectedDate2, context)}",
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                  ),
                ),
                Text(
                  "Selected date: ${formatDate(_selectedDate2, context)}",
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                  ),
                ),
                //WITH SCROLL CONTROLLER
                BentoDatePicker(
                  scrollController: _scrollController,
                  minimumYear: 2020,
                  label: Text(
                    'Birthday',
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                  ),
                  dateLabel: Text(
                    formatDate(_selectedDate2, context),
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  selectedDate: _selectedDate2,
                  onDateTimeChanged: (dateTime) {
                    setState(() {
                      _selectedDate2 = dateTime;
                    });
                  },
                ),
                Padding(padding: const EdgeInsetsDirectional.only(top: 16), child: ColoredBoxExample()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ColoredBoxExample extends StatelessWidget {
  const ColoredBoxExample({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(color: colorScheme.primary, borderRadius: BorderRadius.all(Radius.circular(16))),
      child: SizedBox(height: 200, width: double.infinity),
    );
  }
}
