import 'package:equatable/equatable.dart';

class AccessTokenModel extends Equatable {
  const AccessTokenModel({
    required this.accessToken,
    required this.refreshToken,
    required this.type,
  });

  final String accessToken;
  final String refreshToken;
  final String type;

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
        type,
      ];
}
