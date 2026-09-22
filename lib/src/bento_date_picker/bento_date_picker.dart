import 'package:bento_datetime_picker/bento_datetime_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BentoDatePicker extends StatefulWidget {
  const BentoDatePicker({
    super.key,
    required this.label,
    this.selectedDate,
    required this.onDateTimeChanged,
    required this.dateLabel,
    this.scrollController,
    this.minimumYear = 1901,
    this.scrollAlignment = 0.3,
    this.openDuration = const Duration(milliseconds: 320),
    this.closeDuration = const Duration(milliseconds: 240),
    this.scrollToElementDuration = const Duration(milliseconds: 220),
    this.scrollCurve = Curves.easeInOut,
  });
  final Widget label;
  final Widget dateLabel;
  final DateTime? selectedDate;
  final void Function(DateTime) onDateTimeChanged;
  final ScrollController? scrollController;
  final double scrollAlignment;
  final Duration openDuration;
  final Duration closeDuration;
  final Duration scrollToElementDuration;
  final Curve scrollCurve;
  final int minimumYear;
  @override
  State<BentoDatePicker> createState() => _BentoDatePickerState();
}

class _BentoDatePickerState extends State<BentoDatePicker> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.openDuration,
    reverseDuration: widget.closeDuration,
  );

  late final Animation<double> _expand = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
    reverseCurve: Curves.easeInCubic,
  );

  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.25, 1, curve: Curves.easeOut),
    reverseCurve: const Interval(0.5, 1, curve: Curves.easeIn),
  );

  late DateTime _date;
  bool get _isPickerOpen =>
      _controller.status == AnimationStatus.forward || _controller.status == AnimationStatus.completed;

  @override
  void initState() {
    super.initState();
    _date = widget.selectedDate != null ? DateUtils.dateOnly(widget.selectedDate!) : DateUtils.dateOnly(DateTime.now());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePickerTap() {
    if (_isPickerOpen) {
      _controller.reverse();
      widget.onDateTimeChanged(_date);
      return;
    }
    _controller.forward().whenComplete(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _revealCard(widget.scrollToElementDuration);
      });
    });
  }

  void _revealCard(Duration duration) {
    final ScrollPosition? position = widget.scrollController?.position;
    final RenderObject? renderObject = context.findRenderObject();
    if (position == null || renderObject == null || !renderObject.attached) {
      return;
    }
    position.ensureVisible(
      renderObject,
      alignment: widget.scrollAlignment,
      duration: duration,
      curve: Curves.easeOutCubic,
    );
  }

  DateTime _initialDateTime(DateTime minimumDate) {
    final DateTime date = _date;
    if (date.isBefore(minimumDate)) {
      return minimumDate;
    }
    return date;
  }

  @override
  Widget build(BuildContext context) {
    final BentoDatePickerTheme? datePickerTheme = BentoDatePickerTheme.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final double datePickerHeight = datePickerTheme?.pickerHeight ?? 242;
    final EdgeInsetsGeometry dividerSpacing = datePickerTheme?.dividerSpacing ?? EdgeInsetsDirectional.only(top: 16);
    final double additionalBottomSpace = datePickerTheme?.additionalBottomSpace ?? 16;
    final EdgeInsetsGeometry contentPadding = datePickerTheme?.contentPadding ??
        EdgeInsetsDirectional.only(
          start: 24,
          top: 16,
          end: 24,
          bottom: additionalBottomSpace * (1 - _expand.value),
        );
    final Color backgroundColor = datePickerTheme?.backgroundColor ?? colorScheme.surface;
    final BorderRadiusGeometry borderRadius = datePickerTheme?.borderRadius ?? BorderRadius.circular(24);
    final Color borderColor = datePickerTheme?.borderColor ?? colorScheme.outline;
    final Color dividerColor = datePickerTheme?.dividerColor ?? colorScheme.outline;
    final TextStyle dateTimePickerTextStyle = datePickerTheme?.dateTimePickerTextStyle ??
        TextStyle(
          fontSize: 18,
          height: 1.3,
          letterSpacing: 0,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        );
    final double itemExtent = datePickerTheme?.itemExtent ?? 32;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: Border.all(color: borderColor),
      ),
      child: AnimatedBuilder(
        animation: _expand,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _handlePickerTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [widget.label, widget.dateLabel],
              ),
            ),
            SizeTransition(
              sizeFactor: _expand,
              axisAlignment: -1,
              child: FadeTransition(
                opacity: _fade,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: dividerSpacing,
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: dividerColor,
                      ),
                    ),
                    SizedBox(
                      height: datePickerHeight,
                      child: CupertinoTheme(
                        data: CupertinoThemeData(
                          brightness: Theme.of(context).brightness,
                          textTheme: CupertinoTextThemeData(
                            dateTimePickerTextStyle: dateTimePickerTextStyle,
                          ),
                        ),
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          dateOrder: DatePickerDateOrder.dmy,
                          showDayOfWeek: false,
                          initialDateTime: _initialDateTime(_date),
                          minimumYear: widget.minimumYear,
                          onDateTimeChanged: (newDate) {
                            _date = DateUtils.dateOnly(newDate);
                            widget.onDateTimeChanged(_date);
                          },
                          itemExtent: itemExtent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        builder: (context, child) {
          return Padding(
            padding: contentPadding,
            child: child,
          );
        },
      ),
    );
  }
}
