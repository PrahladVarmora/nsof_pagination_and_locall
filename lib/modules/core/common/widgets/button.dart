import 'package:nstack_softech_practical/modules/core/utils/common_import.dart';

/// A [CustomButton] widget is a widget that describes part of the user interface by button
/// * [buttonText] which contains the button Text
/// * [height] which contains the button height
/// * [width] which contains the button width
/// * [backgroundColor] which contains the button backgroundColor
/// * [borderColor] which contains the button borderColor
/// * [borderRadius] which contains the button borderRadius
/// * [onPress] which contains the button onPress
/// * [style] which contains the button TextStyle
// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    this.buttonText,
    this.height,
    this.width,
    this.backgroundColor = AppColors.colorPrimary,
    this.borderColor = AppColors.colorPrimary,
    this.borderRadius,
    this.onPress,
    this.style,
    this.isLoading = false,
  }) : super(key: key);

  String? buttonText;
  double? height;
  double? width;
  Color? backgroundColor;
  Color? borderColor;
  double? borderRadius;
  TextStyle? style;
  final bool isLoading;
  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            height: height ?? 50,
            width: width ?? MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              color: backgroundColor,
            ),
          )
        : InkWell(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0)),
            splashColor: AppColors.colorTransparent,
            hoverColor: AppColors.colorTransparent,
            highlightColor: AppColors.colorTransparent,
            onTap: () {
              onPress!();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.zero,
              height: height ?? 50,
              width: width ?? MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 0)),
                color: backgroundColor,
                border: Border.all(
                    color: borderColor ?? Theme.of(context).primaryColor),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '$buttonText',
                  style:
                      style /*??
                      getTextStyle(
                          Theme.of(context).primaryTextTheme.headline1!,
                          14,
                          FontWeight.w300)*/
                  ,
                ),
              ),
            ),
          );
  }
}

/// A [CustomButton] widget is a widget that describes part of the user interface by button
/// * [buttonText] which contains the button Text
/// * [height] which contains the button height
/// * [width] which contains the button width
/// * [backgroundColor] which contains the button backgroundColor
/// * [borderColor] which contains the button borderColor
/// * [borderRadius] which contains the button borderRadius
/// * [onPress] which contains the button onPress
/// * [style] which contains the button TextStyle
/// * [Widget] for widgets that always build the same way given a
// ignore: must_be_immutable
class CustomChildButton extends StatelessWidget {
  CustomChildButton({
    Key? key,
    this.buttonText,
    this.height,
    this.width,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.onPress,
    this.style,
    this.isLoading = false,
    this.child,
  }) : super(key: key);

  String? buttonText;
  double? height;
  double? width;
  final bool? isLoading;
  Color? backgroundColor;
  Color? borderColor;
  double? borderRadius;
  Widget? child;
  TextStyle? style;
  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return isLoading!
        ? Container(
            height: height ?? 50,
            width: width ?? MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          )
        : InkWell(
            onTap: () {
              onPress!();
            },
            splashColor: AppColors.colorTransparent,
            hoverColor: AppColors.colorTransparent,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0)),
            child: Container(
              alignment: Alignment.center,
              height: height ?? 50,
              width: width ?? MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 0)),
                color: backgroundColor ?? AppColors.colorPrimary,
                border:
                    Border.all(color: borderColor ?? AppColors.colorPrimary),
              ),
              child: child,
            ),
          );
  }
}
