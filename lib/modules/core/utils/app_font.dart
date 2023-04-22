import 'package:nstack_softech_practical/modules/core/utils/common_import.dart';

/// > AppFont is a class that contains a static method that returns a font family name
class AppFont {
  static final regular = GoogleFonts.roboto(
      fontWeight: FontWeight.w400, color: AppColors.colorBlack);
  static final bold = GoogleFonts.roboto(
      fontWeight: FontWeight.w700, color: AppColors.colorBlack);
  static final semiBold = GoogleFonts.roboto(
      fontWeight: FontWeight.w600, color: AppColors.colorBlack);
  static final mediumBold = GoogleFonts.roboto(
      fontWeight: FontWeight.w500, color: AppColors.colorBlack);

  ///-------REGULAR-------------

  ///colorWhite-------
  static final colorWhite = bold.copyWith(color: AppColors.colorWhite);
  static final colorBlack = bold.copyWith(color: AppColors.colorBlack);

  /// ------ semiBold -------

  static final semiBoldColorBlack20 =
      semiBold.copyWith(fontSize: Dimens.textSize20);
  static final semiBoldColor9A9A9A16 = semiBold.copyWith(
      fontSize: Dimens.textSize14, color: AppColors.color9A9A9A);
}
