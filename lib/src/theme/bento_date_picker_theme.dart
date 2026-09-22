import 'dart:ui';

import 'package:flutter/material.dart';

class BentoDatePickerTheme extends ThemeExtension<BentoDatePickerTheme> {
  const BentoDatePickerTheme({
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.dividerSpacing,
    this.dividerColor,
    this.pickerHeight,
    this.dateTimePickerTextStyle,
    this.itemExtent,
    this.contentPadding,
    this.additionalBottomSpace,
  });

  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? dividerSpacing;
  final Color? dividerColor;
  final double? pickerHeight;
  final TextStyle? dateTimePickerTextStyle;
  final double? itemExtent;
  final EdgeInsetsGeometry? contentPadding;
  final double? additionalBottomSpace;

  static BentoDatePickerTheme? of(BuildContext context) => Theme.of(context).extension<BentoDatePickerTheme>();

  @override
  ThemeExtension<BentoDatePickerTheme> copyWith({
    Color? backgroundColor,
    Color? borderColor,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? dividerSpacing,
    Color? dividerColor,
    double? pickerHeight,
    TextStyle? dateTimePickerTextStyle,
    double? itemExtent,
    EdgeInsetsGeometry? contentPadding,
    double? additionalBottomSpace,
  }) {
    return BentoDatePickerTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      dividerSpacing: dividerSpacing ?? this.dividerSpacing,
      dividerColor: dividerColor ?? this.dividerColor,
      pickerHeight: pickerHeight ?? this.pickerHeight,
      dateTimePickerTextStyle: dateTimePickerTextStyle ?? this.dateTimePickerTextStyle,
      itemExtent: itemExtent ?? this.itemExtent,
      contentPadding: contentPadding ?? this.contentPadding,
      additionalBottomSpace: additionalBottomSpace ?? this.additionalBottomSpace,
    );
  }

  @override
  ThemeExtension<BentoDatePickerTheme> lerp(covariant BentoDatePickerTheme? other, double t) {
    return BentoDatePickerTheme(
      backgroundColor: Color.lerp(backgroundColor, other?.backgroundColor, t),
      borderColor: Color.lerp(borderColor, other?.borderColor, t),
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other?.borderRadius, t),
      dividerSpacing: EdgeInsetsGeometry.lerp(dividerSpacing, other?.dividerSpacing, t),
      dividerColor: Color.lerp(dividerColor, other?.dividerColor, t),
      pickerHeight: lerpDouble(pickerHeight, other?.pickerHeight, t),
      dateTimePickerTextStyle: TextStyle.lerp(dateTimePickerTextStyle, other?.dateTimePickerTextStyle, t),
      itemExtent: lerpDouble(itemExtent, other?.itemExtent, t),
      contentPadding: EdgeInsetsGeometry.lerp(contentPadding, other?.contentPadding, t),
      additionalBottomSpace: lerpDouble(additionalBottomSpace, other?.additionalBottomSpace, t),
    );
  }
}
