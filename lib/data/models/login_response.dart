import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:submision_flutter_intermediate/utils/hive/adapters/user.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    bool? error,
    String? message,
    UserData? loginResult,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(json) => _$LoginResponseFromJson(json);
}
