import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_app/core/theme/appTheme.dart';
import 'package:new_app/core/utils/convert.dart';
import 'package:new_app/modules/home/views/topItems/item_container.dart';
import 'package:new_app/modules/home/views/topItems/top_part.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopItems extends StatefulWidget {
  final String wine;
  final String title;
  final List items;
  final bool revert;
  final String itemType;
  final String itemName;
  final String price;

  final Function onTap;

  const TopItems({
    Key key,
    this.wine,
    this.items,
    this.title,
    this.revert = false,
    this.price,
    this.itemType,
    this.itemName,
    this.onTap,
  }) : super(key: key);

  @override
  _TopItemsState createState() => _TopItemsState();
}

class _TopItemsState extends State<TopItems> {
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        color: widget.revert ? AppColors.black : AppColors.yellow,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 18.w),
          child: Column(
            children: [
              TopPart(title: widget.title, revert: widget.revert),
              SizedBox(height: 16),
              CarouselSlider(
                  items: widget.items.map((n) {
                    return ItemContainer(
                      imgAsset: widget.wine,
                      itemName: widget.itemName,
                      price: interpretPrice(widget.price),
                      revert: widget.revert,
                      itemType: widget.itemType,
                      color: widget.revert ? AppColors.yellow : AppColors.black,
                    );
                  }).toList(),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    aspectRatio: 1.5,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  )),
              bottomSlider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.items.length, (index) {
        return Flexible(
          child: Container(
            width: 95,
            height: 2,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            color: _currentIndex == index
                ? Colors.white
                : widget.revert
                    ? AppColors.yellow
                    : AppColors.black,
          ),
        );
      }),
    );
  }
}
