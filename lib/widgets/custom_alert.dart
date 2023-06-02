import 'dart:async';
import 'dart:ui';
import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tip_dialog/tip_dialog.dart';
class BgaCustomAlert extends StatefulWidget {
  final String title, descriptions;
  final text;
  final Image img;
  final VoidCallback? onPressed;

  final Duration? duration;

  const BgaCustomAlert({
    required this.title,
    this.descriptions = '',
    this.text,
    required this.img,
    this.onPressed,
    this.duration,
  });

  @override
  _BgaCustomAlertState createState() => _BgaCustomAlertState();
}

class _BgaCustomAlertState extends State<BgaCustomAlert> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.duration != null) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer(widget.duration!, () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: BgaPaddingSize.getPaddingAlertButton(),
          margin: BgaPaddingSize.getPaddingTopAlertMargin(),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: BgaColor.bgaOrange,
            borderRadius: BorderRadiusStyle.bgaroundedBorder15,
            boxShadow: [
              BoxShadow(
                color: BgaColor.bgaBlack900,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: BgaSizedboxSize.getSizedBoxAlertHeight()),
              Padding(
                padding: BgaPaddingSize.getBgaPaddingSymmetric20(),
                child: Center(child: Text(widget.title,textAlign: TextAlign.center, style: BgaTextStyle.alertTitleBold)),
              ),
              SizedBox(height: BgaSizedboxSize.getSizedBoxLowHeight()),
              Padding(
                padding: BgaPaddingSize.getBgaPaddingSymmetric20(),
                child: Center(
                  child: Text(
                    widget.descriptions,
                    style:BgaTextStyle.subtitleText,
                  ),
                ),
              ),
              SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight()),
              if (widget.onPressed != null)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: BgaColor.bgaBodyColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: widget.onPressed,
                      child: Text(
                        widget.text,
                        style: BgaTextStyle.buttonBGATextSecondary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: widget.img,
            ),
          ),
        ),
      ],
    );
  }
}



class BgaPopUp {
  static void showLoading(String message) {
    TipDialogHelper.loading(message);
  }

  static void dismissLoading() {
    TipDialogHelper.dismiss();
  }

  static void showSuccess(String message) {
    TipDialogHelper.success(message);
  }

  static void showFail(String message) {
    TipDialogHelper.fail(message);
  }

  static void showInfo(String message) {
    TipDialogHelper.info(message);
  }

  static void showOnlyIcon(TipDialogType type) {
    TipDialogHelper.show(
      TipDialog(type: type),
    );
  }

  static void showOnlyText(String message) {
    TipDialogHelper.show(
      TipDialog(
        type: TipDialogType.NOTHING,
        tip: message,
      ),
    );
  }

  static void showCustomIcon(Icon icon, String message) {
    TipDialogHelper.show(
      TipDialog.customIcon(
        icon: icon,
        tip: message,
      ),
    );
  }

  static void showCustomBody(Widget body, Color color) {
    TipDialogHelper.show(
      TipDialog.builder(
        bodyBuilder: (_) => body,
        color: color,
      ),
    );
  }
}