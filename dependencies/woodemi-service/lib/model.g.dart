// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientAgent _$ClientAgentFromJson(Map<String, dynamic> json) {
  return ClientAgent(
    title: json['title'] as String,
    appId: json['appId'] as int,
  );
}

Map<String, dynamic> _$ClientAgentToJson(ClientAgent instance) =>
    <String, dynamic>{
      'title': instance.title,
      'appId': instance.appId,
    };

Environment _$EnvironmentFromJson(Map<String, dynamic> json) {
  return Environment(
    title: json['title'] as String,
    urlPrefix: json['urlPrefix'] as String,
  );
}

Map<String, dynamic> _$EnvironmentToJson(Environment instance) =>
    <String, dynamic>{
      'title': instance.title,
      'urlPrefix': instance.urlPrefix,
    };
