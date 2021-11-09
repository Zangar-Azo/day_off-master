import 'package:flutter/material.dart';
import 'package:new_app/core/config/routes.dart';
import 'package:new_app/core/theme/appTheme.dart';
import 'package:new_app/core/utils/convert.dart';
import 'package:new_app/core/utils/snackbar_utils.dart';
import 'package:new_app/core/widgets/buttons/buttonToPop.dart';
import 'package:new_app/modules/home/controllers/category_controller.dart';
import 'package:new_app/modules/home/models/product_model.dart';
import 'package:new_app/modules/home/utils/const.dart';
import 'package:new_app/modules/product-place/views/widgets/bottom_description.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'controller/CartController.dart';

class ProductPlaceView extends StatefulWidget {
  @override
  _ProductPlaceViewState createState() => _ProductPlaceViewState();
}

class _ProductPlaceViewState extends State<ProductPlaceView>
    with SingleTickerProviderStateMixin {
  bool _bought = false;

  void buyORdeleteProduct(ProductModel product) {
    _bought
        ? context.read<CartController>().deleteFromCart(product, '')
        : context.read<CartController>().addToCart(product, '');
    setState(() => _bought = !_bought);
  }

  void decrement(ProductModel product) {
    setState(() {
      context.read<CartController>().decreaseCartQuantity(product, '');
    });
  }

  void increment(ProductModel product) {
    setState(() {
      context.read<CartController>().incrementCardCount(product, '');
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: getProductByID
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    final arguments = ModalRoute.of(context).settings.arguments as List;
    final productIndex = arguments[0];
    final productName = arguments[1];
    final ProductModel product =
        context.watch<CategoryController>().products[productIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  top: _height / 3,
                  left: 0,
                  right: 0,
                  child: BottomDescription(
                    product: product,
                    productType: productName,
                    onTap: () => buyORdeleteProduct(product),
                    incrementQuantity: () => increment(product),
                    decrementQuantity: () => decrement(product),
                  )),
              Positioned(
                top: 0,
                left: _width / 2 - 30.w,
                height: _height / 3 + 30.h,
                child: Image.network(imgSource + product.largeImg),
              ),
              Positioned(
                top: 50.h,
                left: 20.w,
                right: 8.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonToPop(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(7.sp),
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(color: Colors.grey),
                                    bottom: BorderSide(color: Colors.grey[200]),
                                    top: BorderSide(color: Colors.grey[200]))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    interpretPrice(
                                      '${num.parse(product.price.toString().isEmpty ? 0 : product.price.toString()) * int.parse(product.quantity)}',
                                    ),
                                    style: AppFontStyles.bigTitle(true)),
                                Text(' ТГ', style: AppFontStyles.black8w300),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => fetchCartProducts(),
                            child: Container(
                              padding: EdgeInsets.all(14.sp),
                              color: AppColors.yellow,
                              child: Icon(Icons.shopping_cart_outlined,
                                  color: AppColors.black, size: 24.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // to make stack scrollable, and take up height of children
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  height: _height),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchCartProducts() async {
    var success = await context.read<CartController>().getCartProducts('token');
    success
        ? Navigator.pushNamed(context, Routes.CART_VIEW)
        : SnackUtil.showError(context: context, message: 'err msg');
  }
}
