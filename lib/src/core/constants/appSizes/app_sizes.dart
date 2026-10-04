import 'package:flutter/material.dart'
    show BorderRadius, EdgeInsets, Radius, SizedBox;

/// [AppDimens] contains the application's dimension constants.
class AppDimens {
  AppDimens._();
 
  static const double p1 = 1;
  static const double p80 = 80;
  static const double p2 = 2;
  static const double p3 = 3;
  static const double p4 = 4;
  static const double p5 = 5;
  static const double p6 = 6;
  static const double p8 = 8;
  static const double p10 = 10;
  static const double p11 = 11;
  static const double p12 = 12;
  static const double p14 = 14;
  static const double p15 = 15;
  static const double p16 = 16;
  static const double p18 = 18;
  static const double p19 = 19;
  static const double p20 = 20;
  static const double p22 = 22;
  static const double p24 = 24;
  static const double p26 = 26;
  static const double p28 = 28;
  static const double p32 = 32;
  static const double p36 = 36;
  static const double p42 = 42;
  static const double p48 = 48;
  static const double p52 = 52;
  static const double p56 = 56;
  static const double p64 = 64;
  static const double p60 = 60;
   static const double p105 = 105;
  static const double p200 = 200;
  static const double p240 = 240;
  static const double p250 = 250;
  static const double p40 = 40;
  static const double p72 = 72;
  static const double p150 = 150;
  static const double p160 = 160;
  static const double p132 = 132;
  static const double p120 = 120;
  static const double p350 = 350;
  static const double p225 = 225;
  static const double p180 = 180;
  static const double p130 = 130;
}

class AppPadding {
  AppPadding._();

  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: AppDimens.p24,
    vertical: AppDimens.p24,
  );
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: AppDimens.p24,
    vertical: AppDimens.p12,
  );

  static const EdgeInsets horizontalScreenPadding = EdgeInsets.symmetric(
    horizontal: AppDimens.p16,
    vertical: AppDimens.p12,
  );

  static const EdgeInsets horizontalNormalPadding = EdgeInsets.symmetric(
    horizontal: AppDimens.p16,
  );

  static const EdgeInsets dialogPadding = EdgeInsets.symmetric(
    horizontal: AppDimens.p12,
    vertical: AppDimens.p8,
  );
  static const EdgeInsets normalPadding = EdgeInsets.all(AppDimens.p16);

  static const EdgeInsets allPadding = EdgeInsets.all(
    AppDimens.p16,
  );

  static const EdgeInsets allSmallPadding = EdgeInsets.all(AppDimens.p4);

  static const EdgeInsets allmediumPadding = EdgeInsets.all(AppDimens.p10);
  static const EdgeInsets hintTextPadding = EdgeInsets.symmetric(
    horizontal: AppDimens.p16,
    vertical: AppDimens.p8,
  );

  static const EdgeInsets smallVerticalPadding = EdgeInsets.symmetric(
    vertical: AppDimens.p4,
  );
}

class AppSpacing {
  AppSpacing._();
  static const SizedBox h2 = SizedBox(height: AppDimens.p2);
  static const SizedBox h3 = SizedBox(height: AppDimens.p3);
  static const SizedBox h4 = SizedBox(height: AppDimens.p4);
  static const SizedBox h5 = SizedBox(height: AppDimens.p5);
  static const SizedBox h6 = SizedBox(height: AppDimens.p6);
  static const SizedBox h8 = SizedBox(height: AppDimens.p8);
  static const SizedBox h10 = SizedBox(height: AppDimens.p10);
  static const SizedBox h14 = SizedBox(height: AppDimens.p14);
  static const SizedBox h12 = SizedBox(height: AppDimens.p12);
  static const SizedBox h16 = SizedBox(height: AppDimens.p16);
  static const SizedBox h15 = SizedBox(height: AppDimens.p15);
  static const SizedBox h20 = SizedBox(height: AppDimens.p20);
  static const SizedBox h24 = SizedBox(height: AppDimens.p24);
  static const SizedBox h26 = SizedBox(height: AppDimens.p26);
  static const SizedBox h32 = SizedBox(height: AppDimens.p32);
  static const SizedBox h48 = SizedBox(height: AppDimens.p48);
  static const SizedBox h19 = SizedBox(height: AppDimens.p19);
  static const SizedBox h52 = SizedBox(height: AppDimens.p52);


  static const SizedBox w1 = SizedBox(width: AppDimens.p1);
  static const SizedBox w4 = SizedBox(width: AppDimens.p4);
  static const SizedBox w6 = SizedBox(width: AppDimens.p6);
  static const SizedBox w8 = SizedBox(width: AppDimens.p8);
  static const SizedBox w12 = SizedBox(width: AppDimens.p12);
  static const SizedBox w16 = SizedBox(width: AppDimens.p16);
  static const SizedBox w24 = SizedBox(width: AppDimens.p24);
  static const SizedBox w32 = SizedBox(width: AppDimens.p32);
  static const SizedBox w48 = SizedBox(width: AppDimens.p48);
}

/// [AppRadius] contains the application's border radius constants.
class AppRadius {
  AppRadius._();

  static const double sm = 8;
  static const double nrml = 12;

  static const double md = 16;
  static const double md20 = 20;
  static const double lg = 32;
  static const double xl = 36;

  static BorderRadius small = BorderRadius.circular(sm);
  static BorderRadius normal = BorderRadius.circular(nrml);
  static BorderRadius medium20 = BorderRadius.circular(md20);
  static BorderRadius medium = BorderRadius.circular(md);
  static BorderRadius large = BorderRadius.circular(lg);
  static BorderRadius xLarge = BorderRadius.circular(xl);

  static BorderRadius verticalRadius = const BorderRadius.vertical(
    top: Radius.circular(AppDimens.p16),
  );
}
