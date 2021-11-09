import 'package:flutter/material.dart';
import 'package:new_app/core/config/firebase_messaging.dart';
import 'package:new_app/core/config/notifications.dart';
import 'package:new_app/core/widgets/bottomBar/bottomBar.dart';
import 'package:new_app/modules/home/controllers/category_controller.dart';
import 'package:new_app/modules/home/views/catalog/products.dart';
import 'package:new_app/modules/home/views/topItems/top_items.dart';
import 'package:new_app/modules/home/views/topItems/top_part.dart';
import 'package:new_app/modules/home/views/widgets/homeHeader.dart';
import 'package:provider/provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../locator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  var _items = [1, 2, 3];
  String title = '';
  String categoryId = '';
  bool clicked = false;

  ScrollController _scrollController;

  String currentPage = '1';
  String totalPage = '100';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));

    // initialize onTapNotification
    sl<FirebaseMessagingNotification>().onClickNotificationView(context);

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;

      if (!isLoading && categoryId != '' && currentScroll == maxScroll)
        _loadNextPage();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  var _wine1 = "assets/icons/wine1.png";
  var _wine2 = "assets/icons/wine2.png";

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: GestureDetector(
              onTap: clicked ? toggleBottomSheet : null,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(height: _height - 100.h),
                  Column(
                    children: [
                      HomeHeader(),
                      title == ''
                          ? Column(
                              children: [
                                TopItems(
                                  title: 'НОВИНКИ',
                                  items: _items,
                                  wine: _wine1,
                                  price: '1 699',
                                  itemName:
                                      "Вино Sauvion Rose D'Anjou розовое полусухое 0,75 л",
                                  itemType: 'Вино',
                                  onTap: () async {
                                    await sl<NotificationHandler>()
                                        .showNotification();
                                  },
                                ),
                                TopItems(
                                  title: 'ТОП ПРОДАЖ',
                                  items: _items,
                                  wine: _wine2,
                                  revert: true,
                                  itemName:
                                      "Текила Leyenda del Milagro Reserve Anejo 0,75 л",
                                  price: '19 699',
                                  itemType: 'Текила',
                                  onTap: () async {
                                    await sl<NotificationHandler>()
                                        .showNotification();
                                  },
                                ),
                              ],
                            )
                          : Consumer<CategoryController>(
                              builder: (_, data, __) {
                                if (data.state == CategoryState.Loading)
                                  return CircularProgressIndicator();
                                else if (data.products.isNotEmpty)
                                  return ProductsView(
                                    title: title,
                                    items: data.products,
                                  );
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 24.h, horizontal: 18.w),
                                  child: TopPart(title: title),
                                );
                              },
                            ),
                    ],
                  ),
                  opacityToggle(clicked),
                  isLoading
                      ? Positioned(
                          left: _width / 2 - 20.w,
                          bottom: _height / 1.5,
                          height: 40.h,
                          width: 40.h,
                          child: CircularProgressIndicator())
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomBar(
          borderTop: true,
          clicked: clicked,
          callback: toggleBottomSheet,
          animationController: animationController,
          onPressed: (String name, String fetchedCategoryId) => setState(() {
            title = name;
            categoryId = fetchedCategoryId;
          }),
        ));
  }

  Widget opacityToggle(bool clicked) => clicked
      ? Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(color: Colors.black.withOpacity(0.4)),
        )
      : Container();

  void toggleBottomSheet() {
    setState(() => clicked = !clicked);
    clicked ? animationController.forward() : animationController.reverse();
  }

  Future<void> _loadNextPage() async {
    setState(() => isLoading = true);

    String nextPage = (int.parse(currentPage) + 1).toString();

    await context
        .read<CategoryController>()
        .getNextProductsById(token: '', categoryId: categoryId, page: nextPage);
    Future.delayed(
        Duration(milliseconds: 600),
        () => setState(() {
              currentPage = nextPage;
              isLoading = false;
            }));
  }
}
