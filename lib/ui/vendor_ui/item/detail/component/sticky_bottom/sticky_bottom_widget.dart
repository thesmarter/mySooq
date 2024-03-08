import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sooq/config/ps_colors.dart';
import 'package:sooq/core/vendor/constant/ps_constants.dart';
import 'package:sooq/core/vendor/viewobject/holder/product_detail_and_address_intent_holder.dart';
import 'package:sooq/ui/custom_ui/item/detail/component/sticky_bottom/buy_action/buy_action.dart';
import 'package:sooq/ui/custom_ui/item/detail/component/sticky_bottom/other_user_action/other_user_actions_widget.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../custom_ui/item/detail/component/sticky_bottom/owner_action/owner_actions_widget.dart';

class StickyBottomWidget extends StatelessWidget {
  const StickyBottomWidget({Key? key, this.productDetailAndAddress})
      : super(key: key);
  final ProductDetailAndAddress? productDetailAndAddress;
  @override
  Widget build(BuildContext context) {
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context);
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    final Product product = itemDetailProvider.product;
    // print("owner item=>${Utils.isOwnerItem(psValueHolder, product)}");
    return Container(
      alignment: Alignment.bottomCenter,
      child: (!itemDetailProvider.productOwner!.hasPhone &&
              itemDetailProvider.product.phoneNumList == '' &&
              psValueHolder.selectChatType == PsConst.NO_CHAT)
          ? Container()
          : Container(
              width: double.infinity,
              height: PsDimens.space84,
              decoration: BoxDecoration(
                color: Utils.isLightMode(context)
                    ? PsColors.achromatic50
                    : PsColors.achromatic800,
                border: Border.all(
                    color: Utils.isLightMode(context)
                        ? PsColors.achromatic50
                        : PsColors.achromatic800),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(PsDimens.space12),
                    topRight: Radius.circular(PsDimens.space12)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Utils.isLightMode(context)
                        ? PsColors.achromatic100
                        : PsColors.achromatic700,
                    blurRadius: 10.0, // has the effect of softening the shadow
                    spreadRadius: 0, // has the effect of extending the shadow
                    offset: const Offset(
                      0.0, // horizontal, move right 10
                      0.0, // vertical, move down 10
                    ),
                  )
                ],
              ),
              child: Utils.isOwnerItem(psValueHolder, product)
                  ? CustomOwnerActionButtonsWidget()
                  : (itemDetailProvider.product.vendorId != '') ? CustomBuyAction(
                      productDetailAndAddress: productDetailAndAddress,
                    )
              : CustomOtherUserActionsWidget(),
              ),
    );
  }
}
// class StickyBottomWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final ItemDetailProvider itemDetailProvider =
//         Provider.of<ItemDetailProvider>(context);
//     final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
//     final Product product = itemDetailProvider.product;
//     // print("owner item=>${Utils.isOwnerItem(psValueHolder, product)}");
//     return Container(
//       alignment: Alignment.bottomCenter,
//       child: (!itemDetailProvider.productOwner!.hasPhone &&
//               itemDetailProvider.product.phoneNumList == '' &&
//               psValueHolder.selectChatType == PsConst.NO_CHAT)
//           ? Container()
//           : Container(
//               width: double.infinity,
//               height: PsDimens.space84,
//               decoration: BoxDecoration(
//                 color: Utils.isLightMode(context)
//                     ? PsColors.achromatic50
//                     : PsColors.achromatic800,
//                 border: Border.all(
//                     color: Utils.isLightMode(context)
//                         ? PsColors.achromatic50
//                         : PsColors.achromatic800),
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(PsDimens.space12),
//                     topRight: Radius.circular(PsDimens.space12)),
//                 boxShadow: <BoxShadow>[
//                   BoxShadow(
//                     color: Utils.isLightMode(context)
//                         ? PsColors.achromatic100
//                         : PsColors.achromatic700,
//                     blurRadius: 10.0, // has the effect of softening the shadow
//                     spreadRadius: 0, // has the effect of extending the shadow
//                     offset: const Offset(
//                       0.0, // horizontal, move right 10
//                       0.0, // vertical, move down 10
//                     ),
//                   )
//                 ],
//               ),
//               child: Utils.isOwnerItem(psValueHolder, product)
//                   ?
//                   // Text("Hello")
//                   CustomOwnerActionButtonsWidget()
//                   : const CustomBuyAction()
//               // : CustomOtherUserActionsWidget(),
//               ),
//     );
//   }
// }
