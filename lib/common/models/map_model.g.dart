// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapModel _$MapModelFromJson(Map<String, dynamic> json) => MapModel(
      title: json['title'] as String,
      description: json['description'] as String,
      lat: json['lat'] as double,
      id: json['id'] as double,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$MapModelToJson(MapModel instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'lat': instance.lat,
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestMap implements RestMap {
  _RestMap(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://qutb.uz/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Response<dynamic>> saveMap(
    String title,
    String description,
    double lat,
    double lot,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    final Map<String, dynamic> _data = {
      "title": title,
      "description": description,
      "lot": lot,
      "lat": lat,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<Response<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/ads',
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
