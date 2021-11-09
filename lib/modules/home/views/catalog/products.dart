import 'package:flutter/material.dart';
import 'package:new_app/core/theme/appTheme.dart';
import 'package:new_app/modules/home/models/product_model.dart';
import 'package:new_app/modules/home/views/catalog/product_container.dart';
import 'package:new_app/modules/home/views/topItems/top_part.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsView extends StatefulWidget {
  final String title;
  final List<ProductModel> items;

  const ProductsView({Key key, this.title, this.items}) : super(key: key);

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 18.w),
      color: Colors.white,
      child: Column(
        children: [
          TopPart(title: widget.title),
          SizedBox(height: 18.h),
          ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, i) {
              return ProductContainer(
                product: widget.items[i],
                color: AppColors.yellow,
                itemType: widget.title,
                index: i,
              );
            },
            separatorBuilder: (_, __) => SizedBox(height: 1),
            itemCount: widget.items.length,
          ),
        ],
      ),
    );
  }
}
