import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_app/core/config/notifications.dart';
import 'package:new_app/core/theme/appTheme.dart';
import 'package:new_app/core/utils/convert.dart';
import 'package:new_app/core/utils/snackbar_utils.dart';
import 'package:new_app/core/widgets/buttons/buttonToPop.dart';
import 'package:new_app/modules/home/views/topItems/top_part.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/modules/product-place/views/controller/CartController.dart';
import 'package:new_app/modules/product-place/views/google_map/google_map.dart';
import 'package:new_app/modules/product-place/views/order/loading_order.dart';
import 'package:new_app/modules/product-place/views/order/successful_order.dart';
import 'package:new_app/modules/product-place/views/widgets/delivery_selector.dart';
import 'package:new_app/modules/product-place/views/widgets/payment_button.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../../../../locator.dart';

class OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final List<String> _paymentMethods = ['Apple Pay'];
  final List<String> _initialText = [
    'Доставка курьером',
    'Адрес доставка',
    'Комментарий к заказу'
  ];
  String _chosenMethod = 'Apple Pay';
  bool _recall = false;
  bool _contactlessDeliver = false;
  bool _clicked = false;
  bool _loaded = false;

  TextEditingController _deliveryController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _commentController = TextEditingController();

  // Google Map
  Completer<GoogleMapController> _controller = Completer();

  @override
  void dispose() {
    _deliveryController.dispose();
    _addressController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final arguments = ModalRoute.of(context).settings.arguments as List;
    final _finalCost = arguments[0];

    if (_loaded)
      sl<NotificationHandler>().showNotification(
          title: 'VISA CLASSIC\nCpkz_de;-PAPA_1',
          body: '6499,00 тг',
          subtext: 'JSC HALYK BANK OF KAZAKHSTAN | WALLET');

    return Scaffold(
        body: SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
            child: _loaded
                ? SuccessOrderView()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopPart(title: 'Оформление заказа'),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: ButtonToPop()),
                      _clicked
                          ? LoadingOrder(text: 'Финализация заказа...')
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(20.w),
                                  child: Text('Доставка',
                                      style: AppFontStyles.mediumSubTitle),
                                ),
                                Column(
                                  children: [
                                    orderDetailsContainer(
                                      _deliveryController,
                                      _initialText[0],
                                      true,
                                      () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  DeliverySelectorView(
                                                    callback: (String address) {
                                                      setState(() =>
                                                          _deliveryController
                                                              .text = address);
                                                    },
                                                  ))),
                                    ),
                                    SizedBox(height: 6.h),
                                    orderDetailsContainer(
                                        _addressController,
                                        _initialText[1],
                                        true,
                                        () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => GoogleMapView(
                                                      callback:
                                                          (String address) {
                                                        _addressController
                                                            .text = address;
                                                      },
                                                    )))),
                                    SizedBox(height: 6.h),
                                    orderDetailsContainer(_commentController,
                                        _initialText[2], false, () {}),
                                    SizedBox(height: 12.h),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Не перезванивать'),
                                    Switch(
                                        activeColor: AppColors.yellow,
                                        value: _recall,
                                        onChanged: (val) =>
                                            setState(() => _recall = val))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Бесконтактная доставка'),
                                    Spacer(),
                                    IconButton(
                                        icon: Icon(Icons.info_outline,
                                            color: AppColors.darkGrey,
                                            size: 26.sp),
                                        onPressed: () {}),
                                    Switch(
                                        value: _contactlessDeliver,
                                        onChanged: (val) => setState(
                                            () => _contactlessDeliver = val))
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                PaymentButton(
                                  chosenMethod: _chosenMethod,
                                  paymentMethods: _paymentMethods,
                                  callback: (String value) =>
                                      setState(() => _chosenMethod = value),
                                ),
                                SizedBox(height: 30.h),
                                buildCostRow('Стоимость товаров:',
                                    interpretPrice(_finalCost)),
                                buildCostRow(
                                    'Apple Pay:', interpretPrice(_finalCost)),
                                SizedBox(height: 30.h),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.all(12.sp),
                                      backgroundColor: AppColors.yellow,
                                      minimumSize: Size(_width - 50.w, 40.h)),
                                  onPressed: () async {
                                    if (_addressController.text == '' ||
                                        _deliveryController.text == '' ||
                                        _commentController.text == '')
                                      return SnackUtil.showError(
                                          context: context,
                                          message:
                                              'Заполните все поля для оформление заказа');

                                    setState(() => _clicked = true);
                                    var success = await context
                                        .read<CartController>()
                                        .checkoutProducts(
                                          deliveryType:
                                              _deliveryController.text,
                                          recall: _recall,
                                          contactlessDelivery:
                                              _contactlessDeliver,
                                          address: _addressController.text,
                                          comment: _commentController.text,
                                        );

                                    success
                                        ? await Future.delayed(
                                            Duration(seconds: 2), () {
                                            setState(() => _loaded = true);
                                          })
                                        : SnackUtil.showError(
                                            context: context,
                                            message:
                                                'Checkout was not successful');
                                  },
                                  child: Image.asset(
                                      'assets/icons/apple_pay_2.png',
                                      height: 30.h),
                                ),
                              ],
                            )
                    ],
                  ),
          ),
        ),
      ),
    ));
  }

  Widget buildCostRow(String title, String price) => Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppFontStyles.mediumTitle(true)),
            Row(
              children: [
                Text(interpretPrice(price),
                    style: AppFontStyles.bigTitle(true)),
                Text(' ТГ', style: AppFontStyles.bigSubTitle)
              ],
            ),
          ],
        ),
      );

  Widget orderDetailsContainer(TextEditingController _controller, String hint,
          bool enable, Function onTap) =>
      GestureDetector(
        onTap: enable ? onTap : null,
        child: Container(
          padding: EdgeInsets.all(20.sp),
          decoration: BoxDecoration(border: Border.all()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  enabled: !enable,
                  style: TextStyle(color: Colors.black, fontSize: 14.sp),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
                  ),
                ),
              ),
              enable
                  ? Icon(Icons.arrow_forward_ios_outlined, size: 12.sp)
                  : SizedBox.shrink(),
            ],
          ),
        ),
      );
}
