import 'package:equatable/equatable.dart';
import 'package:mbl/feature/auth/data/model/this_user_model.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.accessToken,
    required this.user

  });

  final String? accessToken;
  final ThisUserModel? user;




  @override
  List<Object?> get props => [
    accessToken,
    user,
  ];
}
