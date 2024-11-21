import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import 'app_text.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  final bool? isLoading;
  final double? bottomMargin;
  final double? topMargin;
  final double? leftMargin;
  final double? rightMargin;
  final bool? isDisabled;
  final bool? hasBorder;
  final Color? borderColor;

  final Color? textColor;
  final Color? buttonColor;

  final Color? highlightColor;
  final Color? splashColor;
  final double? width;

  final FontWeight fontWeight;
  final double fontSize;
  final double? customBorderRadius;
  final bool isOutlined;

  const AppButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.isLoading = false,
    this.bottomMargin = 16,
    this.topMargin = 0,
    this.isDisabled = false,
    this.hasBorder = false,
    this.borderColor,
    this.leftMargin = 0,
    this.rightMargin = 0,
    this.textColor = Colors.white,
    this.buttonColor,
    this.fontWeight = FontWeight.w600,
    this.fontSize = 14,
    this.customBorderRadius = 20,
    this.width,
    this.highlightColor,
    this.splashColor,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginEdgeInsets.r,
      width: width?.w,
      child: Stack(
        children: [
          Center(
            child: AnimatedContainer(
              decoration: _buildBoxDecoration(),
              duration: const Duration(milliseconds: 300),
              height: buttonHeight.h,
              width: isLoading!
                  ? buttonHeight.h
                  : MediaQuery.of(context).size.width,
              child: Material(
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(
                  isLoading! ? 43 : customBorderRadius ?? 90,
                ).r,
                child: InkWell(
                  highlightColor: highlightColor,
                  splashColor: splashColor,
                  splashFactory: InkRipple.splashFactory,
                  onTap: (!isLoading! && !isDisabled!) ? onPressed : null,
                  child: Center(
                    child: Center(
                      child: AnimatedOpacity(
                        opacity: isLoading! ? 0 : 1,
                        duration: const Duration(milliseconds: 200),
                        child: Expanded(
                          child: Text(
                            text,
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: AppText.fontFamily,
                              fontSize: fontSize.sp,
                              color: textColor ??
                                  (hasBorder!
                                      ? borderColor
                                      : isOutlined
                                          ? AppColors.primary
                                          : AppColors.white),
                              fontWeight: fontWeight,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (isLoading!) Center(child: _buildProgressLoader())
        ],
      ),
    );
  }

  double get buttonHeight => 60;

  Widget _buildProgressLoader() {
    return AnimatedOpacity(
      opacity: isLoading! ? 1 : 0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        width: buttonHeight.h,
        height: buttonHeight.h,
        padding: const EdgeInsets.all(8).r,
        child: CircularProgressIndicator(
          strokeWidth: 3.sp,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  EdgeInsets get marginEdgeInsets {
    return EdgeInsets.only(
        left: leftMargin!,
        right: rightMargin!,
        bottom: bottomMargin!,
        top: topMargin!);
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: hasBorder! ? borderColor! : Colors.transparent,
        width: hasBorder! ? 1.sp : 0.sp,
      ),
      borderRadius:
          BorderRadius.circular(isLoading! ? 43 : customBorderRadius ?? 5).r,
      color: isOutlined
          ? Colors.white
          : isDisabled!
              ? Colors.grey
              : buttonColor ?? AppColors.primary,
    );
  }
}
