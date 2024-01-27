// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      firstName: json['firstname'] as String,
      lastName: json['lastname'] as String,
      phone: json['phone'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    )..emailVerifiedAt = json['email_verified_at'];

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'firstname': instance.firstName,
      'lastname': instance.lastName,
      'phone': instance.phone,
      'email_verified_at': instance.emailVerifiedAt,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestUser implements RestUser {
  _RestUser(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://qutb.uz/api/auth';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Response<dynamic>> signIn(
    String firstName,
    String password,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    final Map<String, dynamic> _data = {
      "firstname": firstName,
      "password": password,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Response<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = _result;
    return value;
  }

  @override
  Future<Response<dynamic>> signUp(
    String firstName,
    String lastName,
    String phone,
    String password,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    final Map<String, dynamic> _data = {
      "firstname": firstName,
      "lastname": lastName,
      "phone": phone,
      "password": password,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Response<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/register',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = _result;
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
