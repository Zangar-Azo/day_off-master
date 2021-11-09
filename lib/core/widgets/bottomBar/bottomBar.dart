import 'package:flutter/material.dart';
import 'package:new_app/core/config/routes.dart';
import 'package:new_app/core/theme/appTheme.dart';
import 'package:new_app/core/utils/snackbar_utils.dart';
import 'package:new_app/core/widgets/bottomBar/bottomBarItem.dart';
import 'package:new_app/modules/auth/views/auth_view.dart';
import 'package:new_app/modules/home/controllers/category_controller.dart';
import 'package:new_app/modules/product-place/views/controller/CartController.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomBar extends StatefulWidget {
  final bool borderTop;
  final bool clicked;
  final VoidCallback callback;
  final AnimationController animationController;
  final Function onPressed;

  const CustomBottomBar({
    this.borderTop = false,
    this.clicked,
    this.callback,
    this.animationController,
    this.onPressed,
  });

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  ScrollController _scrollController = ScrollController();
  int prevIndex = -1;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BottomAppBar(
      color: AppColors.black,
      child: Container(
        decoration: BoxDecoration(
            border: widget.borderTop
                ? Border(top: BorderSide(color: Colors.grey[900], width: 0.5))
                : Border.all(width: 0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomBarItem(
                  icon: Icons.wine_bar_sharp,
                  onPressed: () => onPressed(0),
                ),
                BottomBarItem(
                  icon: Icons.favorite_outline,
                  onPressed: () => onPressed(1),
                ),
                BottomBarItem(
                  icon: Icons.phone,
                  onPressed: () => onPressed(2),
                ),
                BottomBarItem(
                  icon: Icons.shopping_cart_outlined,
                  onPressed: () => onPressed(3),
                ),
                BottomBarItem(
                  icon: Icons.people_alt_outlined,
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthView())),
                ),
              ],
            ),
            Consumer<CategoryController>(builder: (_, data, __) {
              return SizeTransition(
                sizeFactor: CurvedAnimation(
                  parent: widget.animationController,
                  curve: Curves.easeOutQuad,
                ),
                child: Container(
                  color: AppColors.yellow,
                  height: height / 2 - 50.h,
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 30.h, horizontal: 26.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Продукция",
                          style: AppFontStyles.headingBlackSpacing),
                      SizedBox(height: 34.h),
                      Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemBuilder: (_, i) {
                            // print(_scrollController.position.maxScrollExtent);
                            var id = data.categories[i].id;
                            var name = data.categories[i].name.toUpperCase();
                            var stock = data.categories[i].number;

                            return TextButton(
                                onPressed: () => fetchProductsById(
                                    token: '',
                                    categoryId: id,
                                    page: '1',
                                    name: name),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    name + '\($stock)',
                                    textAlign: TextAlign.left,
                                    style: AppFontStyles.black14w300,
                                  ),
                                ));
                          },
                          itemCount: data.categories.length,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Future<void> fetchProductsById(
      {String token, String categoryId, String page, String name}) async {
    var success = await context
        .read<CategoryController>()
        .getProductsById(token: '', categoryId: categoryId, page: '1');

    // widget.onPressed push products onto Home View
    if (success)
      widget.onPressed(name, categoryId);
    else
      SnackUtil.showError(context: context, message: 'Something went wrong');

    widget.callback();
  }

  Future<void> onPressed(int currentIndex) async {
    // if another tab is chosen, do not close bottom sheet

    if (currentIndex == 3) {
      await fetchCartProducts();
      if (widget.clicked) widget.callback();
      return;
    }
    if (widget.clicked && prevIndex != currentIndex) {
      return setState(() => prevIndex = currentIndex);
    }

    widget.callback();

    if (prevIndex == currentIndex) return;
    setState(() => prevIndex = currentIndex);
  }

  Future<void> fetchCartProducts() async {
    var success = await context.read<CartController>().getCartProducts('token');
    success
        ? Navigator.pushNamed(context, Routes.CART_VIEW)
        : SnackUtil.showError(context: context, message: 'err msg');
  }
}
