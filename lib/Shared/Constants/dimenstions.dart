// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class Gaps{
  static final tiny_Gap = Gap(4.h.w);
  static final small_Gap = Gap(10.h.w);
  static final medium_Gap = Gap(16.h.w);
  static final large_Gap = Gap(24.h.w);
  static final huge_Gap = Gap(30.h.w);
}

class Pads{
  static final small_Padding = EdgeInsets.all(8.r);
  static final medium_Padding = EdgeInsets.all(16.r);
  static final large_Padding = EdgeInsets.all(24.r);

  static final v_small_Padding = EdgeInsets.symmetric(vertical: 8.r);
  static final v_medium_Padding = EdgeInsets.symmetric(vertical: 16.r);
  static final v_large_Padding = EdgeInsets.symmetric(vertical: 24.r);

  static final h_small_Padding = EdgeInsets.symmetric(horizontal: 8.r);
  static final h_medium_Padding = EdgeInsets.symmetric(horizontal: 16.r);
  static final h_large_Padding = EdgeInsets.symmetric(horizontal: 24.r);
}

// Screen Dimenstions
late double screen_height;
late double screen_width;

