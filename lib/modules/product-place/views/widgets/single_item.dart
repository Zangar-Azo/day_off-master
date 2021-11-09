import 'package:flutter/material.dart';
import 'package:new_app/core/theme/appTheme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/core/utils/convert.dart';
import 'package:new_app/core/utils/snackbar_utils.dart';
import 'package:new_app/modules/home/models/product_model.dart';
import 'package:new_app/modules/home/utils/const.dart';
import 'package:new_app/modules/product-place/views/controller/CartController.dart';

import 'package:provider/provider.dart';

class SingleItemContainer extends StatelessWidget {
  final ProductModel product;
  final String itemType;
  final String quantity;

  SingleItemContainer({this.product, this.itemType, this.quantity});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black,
      padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(TextSpan(children: [
            TextSpan(text: quantity, style: AppFontStyles.white12w400),
            TextSpan(
                text: '\tx',
                style: TextStyle(color: AppColors.yellow, fontSize: 12.sp))
          ])),
          SizedBox(
              width: 70.w,
              height: 100.h,
              child: Image.network(imgSource + product.smallImg)),
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(itemType, style: AppFontStyles.mediumSubTitle),
                    SizedBox(width: 10.w),
                    Flexible(
                        child: Text(product.name,
                            style: AppFontStyles.white14w500)),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Text(interpretPrice(product.price),
                        style: AppFontStyles.yellow16w700),
                    Text('\tТГ', style: AppFontStyles.bigSubTitle)
                  ],
                )
              ],
            ),
          ),
          IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.close, color: AppColors.yellow, size: 20.sp),
              onPressed: () async {
                var success = await context
                    .read<CartController>()
                    .deleteFromCart(product, '');
                success
                    ? SnackUtil.showInfo(
                        context: context,
                        message: 'Product was successfully deleted')
                    : SnackUtil.showError(
                        context: context, message: 'Product was not deleted');
              })
        ],
      ),
    );
  }
}
