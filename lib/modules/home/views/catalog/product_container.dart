import 'package:flutter/material.dart';
import 'package:new_app/core/config/routes.dart';
import 'package:new_app/core/theme/appTheme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/core/utils/convert.dart';
import 'package:new_app/modules/home/models/product_model.dart';
import 'package:new_app/modules/home/utils/const.dart';
import 'package:new_app/modules/product-place/views/controller/CartController.dart';

import 'package:provider/provider.dart';

class ProductContainer extends StatelessWidget {
  final ProductModel product;
  final String itemType;
  final Color color;
  final int index;

  const ProductContainer({
    Key key,
    this.product,
    this.itemType,
    this.color,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _price = product.price;
    final _itemName = product.name;
    final _imgAsset = "$imgSource" + product.largeImg;

    return GestureDetector(
      onTap: () async {
        context.read<CartController>();
        Navigator.pushNamed(context, Routes.PRODUCT_PLACE,
            arguments: [index, itemType]);
      },
      child: Container(
        color: color,
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: _width / 2 - 60.w,
                child: SizedBox(
                    height: 140.h,
                    width: 130.w,
                    child: Image.network(_imgAsset))),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20.h),
                    Text(itemType, style: AppFontStyles.mediumSubTitle),
                    SizedBox(height: 5.h),
                    Text(_itemName, style: AppFontStyles.black12w700),
                    SizedBox(height: 30.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(interpretPrice(_price),
                            style: AppFontStyles.bigTitle(true)),
                        Text(' ТГ',
                            textAlign: TextAlign.start,
                            style: AppFontStyles.bigSubTitle,)
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
            Icon(product.isFavorite ? Icons.favorite : Icons.favorite_outline,
                size: 16.sp,
                color:
                    product.isFavorite ? AppColors.yellow : AppColors.darkGrey)
          ],
        ),
      ),
    );
  }
}
