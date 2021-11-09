import 'package:flutter/material.dart';

class CheckCodeModal extends StatelessWidget {
  final Function callback;
  final String phone;

  const CheckCodeModal({Key key, this.callback, this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Проверка телефона',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
        ),
        SizedBox(height: 16),
        Text(
          'Для проверки...',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
        SizedBox(height: 22),
        Text(
          'Номер телефона',
          style: TextStyle(
            color: Colors.black38,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 18),
        Text(
          phone,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        SizedBox(height: 8,),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Полученный код'
          ),
        ),
        SizedBox(height: 32),
        Container(
          width: 300,
          height: 50,
          color: Colors.black,
          child: TextButton(
              onPressed: callback,
              child: Text(
                'Подтвердить',
                style: TextStyle(
                  color: Color(0xFFFFD800),
                ),
              )),
        ),
        SizedBox(height: 10),
        Text('Если сообщение не пришло, ...',
            style: TextStyle(color: Colors.black38, fontSize: 12)),
      ],
    );
  }
}
