// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CityModel {
  final int id;
  final String name;
  final String country;
  final Map<String,double> coord;   // stores "lat" and "lon"

  const CityModel({
    required this.id,
    required this.name,
    required this.country,
    required this.coord,
  });


  CityModel copyWith({
    int? id,
    String? name,
    String? country,
    Map<String,double>? coord,
  }) {
    return CityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      coord: coord ?? this.coord,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'country': country,
      'coord': coord,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: (map["id"] ?? 0) as int,
      name: (map["name"] ?? '') as String,
      country: (map["country"] ?? '') as String,
      // coord: Map<String,double>.from(((map['coord'] ?? Map<String, dynamic>.from({})) as Map<String,double>),),
      coord: {
        "lon": (map['coord']['lon'] as num).toDouble(),
        "lat": (map['coord']['lat'] as num).toDouble(),
      },
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) => CityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CityModel(id: $id, name: $name, country: $country, coord: $coord)';
  }

  @override
  bool operator ==(covariant CityModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.country == country &&
      mapEquals(other.coord, coord);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      country.hashCode ^
      coord.hashCode;
  }
}

