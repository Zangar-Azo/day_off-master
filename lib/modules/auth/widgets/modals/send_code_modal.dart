import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendCodeModal extends StatefulWidget {
  final Function callback;
  final String phone;
   SendCodeModal({Key key, this.callback, this.phone,}) : super(key: key);

  @override
  State<SendCodeModal> createState() => _SendCodeModalState();
}

class _SendCodeModalState extends State<SendCodeModal> {
  TextEditingController _controller = TextEditingController();
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
          'Для проверки телефона введите номер и мы вышлем SMS с проверочным кодом',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
        SizedBox(height: 8),
        SizedBox(height: 14),
        TextFormField(
          controller: _controller,
          keyboardType: TextInputType.number,
          inputFormatters: [(FilteringTextInputFormatter.digitsOnly)],
          keyboardAppearance: Brightness.light,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Номер телефона'
          ),
          validator: (value){
            if(value == null || value.isEmpty){
              return 'pl';
            }
            return null;
          },

        ),
        SizedBox(height: 18),
        Container(
          width: 300,
          height: 50,
          color: Colors.black,
          child: TextButton(
              onPressed: widget.callback,
              child: Text(
                'Запросить код',
                style: TextStyle(
                  color: Color(0xFFFFD800),
                ),
              )),
        )
      ],
    );
  }
}
