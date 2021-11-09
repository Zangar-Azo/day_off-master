import 'package:flutter/material.dart';
import 'package:new_app/core/theme/appTheme.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: AppColors.black,
                height: 1,
                width: 85,
              ),
              Container(
                height: 60,
                width: 140,
                child: Image.asset('assets/icons/logo2.png'),
              ),
              Container(
                color: AppColors.black,
                height: 1,
                width: 85,
              ),
            ],
          ),
          Container(
              height: 70,
              color: AppColors.black,
              child: Center(
                child: ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Ранг:\t\t\t',
                          style: TextStyle(color: Colors.grey[600])),
                      Text('3+\t\t\t/\t\t\t',
                          style: TextStyle(color: Colors.white)),
                      Text('Бонусы:\t\t\t',
                          style: TextStyle(color: Colors.grey[600])),
                      Text('373\t', style: TextStyle(color: Colors.white)),
                      Text('тенге', style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_outlined,
                      color: Colors.white, size: 14),
                  dense: true,
                ),
              ))
        ],
      ),
    );
  }
}
