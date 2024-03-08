import 'package:flutter/material.dart';
import 'package:sooq/config/ps_colors.dart';
import 'package:sooq/core/vendor/constant/ps_dimens.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget(
      {Key? key, required this.title, this.values, this.isPayment, this.paid})
      : super(key: key);
  final String title;
  final String? values;
  final bool? isPayment;
  final String? paid;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: PsColors.text500),
          ),
          if (isPayment == true)
            Row(
              children: [
                Text(
                  values ?? '',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: PsColors.text800),
                ),
                const SizedBox(
                  width: PsDimens.space10,
                ),
                Container(
                  alignment: Alignment.center,
                  color: PsColors.success50,
                  width: PsDimens.space36,
                  height: PsDimens.space22,
                  child: Text(
                    paid ?? '',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: PsColors.success500),
                  ),
                )
              ],
            )
          else
            Text(
              values ?? '',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: PsColors.text800),
            ),
        ],
      ),
    );
  }
}
