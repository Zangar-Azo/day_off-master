import 'package:flutter/material.dart';
import 'package:new_app/core/theme/appTheme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/core/utils/convert.dart';
import 'package:new_app/modules/home/models/product_model.dart';
import 'package:new_app/modules/product-place/utils/const.dart';
import 'package:new_app/modules/product-place/views/controller/CartController.dart';
import 'package:provider/provider.dart';

class BottomDescription extends StatefulWidget {
  final ProductModel product;
  final String productType;
  final Function onTap;
  final Function incrementQuantity;
  final Function decrementQuantity;

  const BottomDescription(
      {this.product,
      this.productType,
      this.onTap,
      this.incrementQuantity,
      this.decrementQuantity});

  @override
  _BottomDescriptionState createState() => _BottomDescriptionState();
}

class _BottomDescriptionState extends State<BottomDescription>
    with SingleTickerProviderStateMixin {
  TextEditingController _controller = TextEditingController();

  AnimationController _animationController;
  bool _favorite = false;

  Animation<Color> _animFavcolor;
  Animation<double> _animFavsize;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));

    _animFavcolor = ColorTween(begin: AppColors.darkGrey, end: AppColors.yellow)
        .animate(_animationController);

    _animFavsize = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 20.sp, end: 30.sp),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 30.sp, end: 20.sp),
        weight: 50,
      ),
    ]).animate(_animationController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void onTapFavorite() {
    _favorite
        ? context.read<CartController>().deleteFromFavorites(widget.product, '')
        : context.read<CartController>().addToFavorites(widget.product, '');
    _favorite = !_favorite;
    _favorite ? _animationController.forward() : _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    _controller.text = widget.product.quantity;

    return Container(
      color: AppColors.grey,
      padding:
          EdgeInsets.only(top: 46.h, left: 20.w, right: 10.w, bottom: 20.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.product.name,
                  style: AppFontStyles.black10w400,
                ),
              ),
              SizedBox(width: 14.w),
              AnimatedBuilder(
                animation: _animationController,
                builder: (_, __) => IconButton(
                  iconSize: _animFavsize.value,
                  icon: Icon(
                    _favorite ? Icons.favorite : Icons.favorite_outline,
                    color: _animFavcolor.value,
                  ),
                  onPressed: onTapFavorite,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.product.name.split(' ').sublist(1).join(' '),
                  style: AppFontStyles.bigTitle(true),
                ),
              ),
              SizedBox(width: 14.w)
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check, color: Colors.greenAccent),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.h),
                    Text(
                      'В наличии ${widget.product.stock}',
                      style: AppFontStyles.black12w300,
                    ),
                    SizedBox(height: 30.h),
                    Text('ОПИСАНИЕ:', style: AppFontStyles.black12w700),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: _width / 1.4,
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (_, int i) => Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              description_list[i],
                              style: AppFontStyles.black10w400,
                            ),
                            Spacer(),
                            Flexible(
                              child: Text(
                                description_list[i].toUpperCase(),
                                textAlign: TextAlign.end,
                                style: AppFontStyles.black10w400,
                              ),
                            ),
                          ],
                        ),
                        itemCount: description_list.length,
                        separatorBuilder: (_, __) => SizedBox(height: 14.h),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Consumer<CartController>(
            builder: (_, data, __) {
              print("Button consumer: widget.bought: ${widget.product.bought}");
              return widget.product.bought ? buttonBought() : buttonToBuy();
            },
          ),
        ],
      ),
    );
  }

  Widget buttonToBuy() => TextButton(
      style: TextButton.styleFrom(
          padding: EdgeInsets.all(20.sp), backgroundColor: AppColors.yellow),
      onPressed: widget.onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('В корзину за:\t\t', style: AppFontStyles.mediumTitle(true)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(interpretPrice(widget.product.price),
                  style: AppFontStyles.bigTitle(true)),
              Text(' ТГ', style: AppFontStyles.black8w300),
            ],
          ),
        ],
      ));

  Widget buttonBought() => Container(
        color: AppColors.black,
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
              icon: Icon(Icons.remove, color: AppColors.yellow, size: 14.sp),
              onPressed: () {
                int prevQuantity = int.parse(_controller.text) - 1;
                widget.decrementQuantity();
                if (prevQuantity <= 0) return widget.onTap();

                _controller.text = prevQuantity.toString();
              }),
          Expanded(
              child: TextField(
                  textAlign: TextAlign.center,
                  enabled: false,
                  controller: _controller,
                  style: AppFontStyles.yellow16w700)),
          IconButton(
              icon: Icon(Icons.add, color: AppColors.yellow, size: 14.sp),
              onPressed: () {
                int prevQuantity = int.parse(_controller.text) + 1;

                widget.incrementQuantity();

                _controller.text = prevQuantity.toString();
              }),
        ]),
      );
}
