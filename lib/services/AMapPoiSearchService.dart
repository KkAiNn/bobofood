import 'dart:convert';
import 'dart:async';

import 'package:bobofood/constants/amap.dart';
import 'package:http/http.dart' as http;

/// POI 搜索工具类（含节流）
class AMapPoiSearch {
  static const String _baseUrl = "https://restapi.amap.com/v3/place";
  static String key = AmapConfig.webKey;

  static DateTime _lastAroundSearch = DateTime.fromMillisecondsSinceEpoch(0);

  /// 关键词搜索（节流控制）
  static Future<List<Map<String, dynamic>>> keywordSearch({
    required String keywords,
    String city = '',
    int page = 1,
    int offset = 20,
  }) async {
    final uri = Uri.parse("$_baseUrl/text").replace(
      queryParameters: {
        "key": key,
        "keywords": keywords,
        "city": city,
        "page": "$page",
        "offset": "$offset",
        "output": "json",
      },
    );

    final response = await http.get(uri);
    final data = jsonDecode(response.body);
    if (data['status'] == '1') {
      return List<Map<String, dynamic>>.from(data['pois']);
    } else {
      throw Exception("POI 搜索失败: ${data['info']}");
    }
  }

  /// 周边搜索（节流控制）
  static Future<List<Map<String, dynamic>>> aroundSearch({
    required double latitude,
    required double longitude,
    String keywords = '',
    int radius = 30000,
    int page = 1,
    int offset = 20,
  }) async {
    final uri = Uri.parse("$_baseUrl/around").replace(
      queryParameters: {
        "key": key,
        "location": "$longitude,$latitude",
        "keywords": keywords,
        "radius": "$radius",
        "page": "$page",
        "offset": "$offset",
        "output": "json",
      },
    );

    final response = await http.get(uri);
    final data = jsonDecode(response.body);
    if (data['status'] == '1') {
      return List<Map<String, dynamic>>.from(data['pois']);
    } else {
      throw Exception("周边搜索失败: ${data['info']}");
    }
  }
}
