import 'package:flutter/material.dart';
import 'package:sooq/config/ps_colors.dart';
import 'package:sooq/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';

class PhoneSignHeaderIconAndTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Widget _textWidget = Text(
      'login__phone_signin'.tr,
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(color: PsColors.achromatic900 // color: PsColors.primary500,
              ),
    );

    final Widget _imageWidget = Container(
      width: 40,
      height: 40,
      child: Image.asset(
        'assets/images/flutter_buy_and_sell_logo.png',
      ),
    );
    return Column(
      children: <Widget>[
        const SizedBox(
          height: PsDimens.space32,
        ),
        _imageWidget,
        const SizedBox(
          height: PsDimens.space8,
        ),
        _textWidget,
        const SizedBox(
          height: PsDimens.space52,
        ),
      ],
    );
  }
}
