import 'package:flutter/material.dart';
import 'package:new_app/core/config/routes.dart';
import 'package:new_app/core/theme/appTheme.dart';
import 'package:new_app/core/utils/convert.dart';
import 'package:new_app/core/widgets/buttons/button.dart';
import 'package:new_app/modules/home/views/topItems/top_part.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:new_app/modules/product-place/views/controller/CartController.dart';
import 'package:new_app/modules/product-place/views/widgets/go_green.dart';
import 'package:new_app/modules/product-place/views/widgets/single_item.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  TextEditingController _controller = TextEditingController();
  bool _switch = false;
  final _goGreenPrice = '199';
  String _finalCost = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
          child: Column(
            children: [
              TopPart(title: 'Корзина'),
              SizedBox(height: 20.h),
              Consumer<CartController>(builder: (_, data, __) {
                print('rebuilt cart view');
                if (data.state == CartState.Loaded) {
                  print('rebuilt cartstate loaded');

                  int _price = 0;
                  data.cartProducts.forEach((product) {
                    var _temp = product.price.split('.');
                    _price += int.parse(_temp[0])* int.parse(product.quantity);
                  });
                  _price = _switch ? _price + int.parse(_goGreenPrice) : _price;
                  _finalCost = _price.toString();

                  print('final cost: $_finalCost');
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (_, i) => SingleItemContainer(
                      product: data.cartProducts[i],
                      itemType: 'Вино',
                      quantity: data.cartProducts[i].quantity,
                    ),
                    separatorBuilder: (_, __) => SizedBox(height: 1),
                    itemCount: data.cartProducts.length,
                  );
                }

                return CircularProgressIndicator();
              }),
              SizedBox(height: 10.h),
              TextField(
                controller: _controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Ввести промо-код',
                  hintStyle: TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: AppColors.black)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: GoGreenContainer(
                  enable: _switch,
                  callback: (bool val) => setState(() => _switch = val),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Стоимость товаров:',
                    style: AppFontStyles.mediumTitle(true),
                  ),
                  Consumer<CartController>(
                    builder: (_, data, ___) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(interpretPrice(_finalCost),
                            style: AppFontStyles.bigTitle(true)),
                        Text('\tТГ', style: AppFontStyles.bigSubTitle),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 70.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Минимальный заказ 2 500',
                        style: AppFontStyles.mediumSubTitle),
                    Text('\tТГ', style: AppFontStyles.bigSubTitle),
                  ],
                ),
              ),
              CustomButton(
                title: 'Оформить заказ',
                onTap: () {
                  Navigator.pushNamed(context, Routes.ORDER_VIEW,
                      arguments: [_finalCost]);
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
