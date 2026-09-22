# bento_datetime_picker

Inline date and time pickers for Flutter.

Collapsed, `BentoDatePicker` is just a row inside your form: a label on the left, the selected
date on the right. Tap it and the Cupertino wheel unfolds right there, under the row. No modal
sheet, no dialog, nothing covering the rest of the screen.

It's a plain widget — no platform channels, no native code, nothing to configure per platform.

## Features

* The wheel expands in place instead of opening over the screen
* Size + fade animation on open and close, both durations are yours to set
* Give it the scroll controller of the surrounding form and the card scrolls itself into view after it opens
* Styled through a `ThemeExtension`, so one declaration covers every picker in the app
* Without any theming it picks colors from the current `ColorScheme`
* Values come back as dates only, normalized with `DateUtils.dateOnly()`

## Supported platforms

Android, iOS.

Needs Flutter `>=3.27.0` and Dart `>=3.6.0`.

## Installation

The package isn't on pub.dev, so pull it straight from GitHub:

```yaml
dependencies:
  bento_datetime_picker:
    git:
      url: https://github.com/DmytroPedych/bento-date-and-time-picker.git
```

Better to pin a tag or a commit, otherwise you get whatever is on the default branch at the
moment of resolution:

```yaml
dependencies:
  bento_datetime_picker:
    git:
      url: https://github.com/DmytroPedych/bento-date-and-time-picker.git
      ref: v0.0.1 # tag, branch or commit sha
```

To move to a newer commit later, run `flutter pub upgrade bento_datetime_picker` (or bump `ref`).

Then import it:

```dart
import 'package:bento_datetime_picker/bento_datetime_picker.dart';
```

## How to use

Pass the two widgets that make up the collapsed row — `label` and `dateLabel` — and a callback:

```dart
DateTime? _selectedDate;

BentoDatePicker(
  label: const Text('Birthday'),
  dateLabel: Text(
    _selectedDate != null ? DateFormat('d MMMM yyyy').format(_selectedDate!) : 'Not defined',
  ),
  selectedDate: _selectedDate,
  onDateTimeChanged: (date) => setState(() => _selectedDate = date),
)
```

Both are widgets, not strings, on purpose: formatting, text styles, an icon next to the value —
all of that stays in your code, the picker doesn't guess.

Tapping the row toggles the picker. `onDateTimeChanged` fires on every turn of the wheel and once
more on close, so the date you hold is always the one the user sees.

### Inside a scrolling form

A card near the bottom of a long form opens below the fold. Hand the picker the `ScrollController`
of the scroll view and it will scroll itself into view when the open animation finishes:

```dart
final _scrollController = ScrollController();

SingleChildScrollView(
  controller: _scrollController,
  child: Column(
    children: [
      // ...
      BentoDatePicker(
        scrollController: _scrollController,
        scrollAlignment: 0.3, // 0.0 — top of the viewport, 1.0 — bottom
        minimumYear: 2020,
        label: const Text('Start date'),
        dateLabel: Text(DateFormat('d MMMM yyyy').format(_date)),
        selectedDate: _date,
        onDateTimeChanged: (date) => setState(() => _date = date),
      ),
    ],
  ),
)
```

## Params

```dart
BentoDatePicker(
  label: const Text('Birthday'),
  dateLabel: const Text('01 January 2000'),
  selectedDate: DateTime(2000, 1, 1),
  onDateTimeChanged: (date) {},
  minimumYear: 1901,
  scrollController: controller,
  scrollAlignment: 0.3,
  openDuration: const Duration(milliseconds: 320),
  closeDuration: const Duration(milliseconds: 240),
  scrollToElementDuration: const Duration(milliseconds: 220),
)
```

| Param | Type | Default | What it does |
| --- | --- | --- | --- |
| `label` | `Widget` | **required** | Left side of the collapsed row, usually the field name. |
| `dateLabel` | `Widget` | **required** | Right side of the collapsed row, usually the formatted date. |
| `onDateTimeChanged` | `void Function(DateTime)` | **required** | Fires on every wheel change and once when the picker closes. |
| `selectedDate` | `DateTime?` | `null` | Starting value. Time is stripped; `null` means today. |
| `minimumYear` | `int` | `1901` | Earliest year in the wheel. |
| `scrollController` | `ScrollController?` | `null` | Controller of the surrounding scroll view. Without it the card won't scroll itself into view. |
| `scrollAlignment` | `double` | `0.3` | Where the card ends up after that scroll: `0.0` top of the viewport, `1.0` bottom. |
| `openDuration` | `Duration` | `320ms` | Expand animation. |
| `closeDuration` | `Duration` | `240ms` | Collapse animation. |
| `scrollToElementDuration` | `Duration` | `220ms` | How long the scroll-into-view takes. |
| `scrollCurve` | `Curve` | `Curves.easeInOut` | Reserved for that scroll — it currently runs on `Curves.easeOutCubic`. |

The wheel itself is a `CupertinoDatePicker` in `date` mode, day-month-year order, no weekday column.

## Theming

Styling goes through a `ThemeExtension`, so you declare it once and every picker in the app picks
it up (and the values interpolate when the theme changes):

```dart
MaterialApp(
  theme: ThemeData(
    colorScheme: colorScheme,
    extensions: <ThemeExtension<dynamic>>[
      BentoDatePickerTheme(
        backgroundColor: colorScheme.surfaceContainer,
        borderColor: colorScheme.outline,
        borderRadius: BorderRadius.circular(24),
        pickerHeight: 242,
        itemExtent: 32,
        dateTimePickerTextStyle: TextStyle(
          fontSize: 18,
          height: 1.3,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
      ),
    ],
  ),
)
```

Every field is optional.

`BentoDatePickerTheme.of(context)` gives you the resolved extension if you need it elsewhere.

## Example

The demo app in [`example/`](example) shows both cases side by side: a picker on its own, and one
wired to a `ScrollController` in a scrolling form.

```bash
cd example
flutter run
```

## Roadmap

* `BentoTimePicker` — the widget and its theme extension are stubs for now, work in progress
* Date range mode
* Screenshots and a web demo

## Issues and feedback

Bugs and ideas go to the
[issue tracker](https://github.com/DmytroPedych/bento-date-and-time-picker/issues).
Pull requests are welcome.

