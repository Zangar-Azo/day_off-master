import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String phone;

  UserModel({this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(phone: json['phone']);

  Map<String, dynamic> toJson() => {
        'phone': this.phone,
      };

  @override
  List<Object> get props => [phone];
}
