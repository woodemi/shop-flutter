import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class ClientAgent {
  static final aSmartnoteLight = ClientAgent(title: 'Smartnote Android Light', appId: 1);
  static final iSmartnoteLight = ClientAgent(title: 'Smartnote iOS Light', appId: 2);
  static final aSmartnote = ClientAgent(title: 'Smartnote Android', appId: 5);
  static final iSmartnote = ClientAgent(title: 'Smartnote iOS', appId: 6);
  static final aUgeenote = ClientAgent(title: 'Ugeenote Android', appId: 8);
  static final iUgeenote = ClientAgent(title: 'Ugeenote iOS', appId: 9);

  final String title;
  final int appId;

  ClientAgent({
    this.title,
    this.appId,
  });

  factory ClientAgent.fromJson(Map<String, dynamic> json) => _$ClientAgentFromJson(json);
  
  Map<String, dynamic> toJson() => _$ClientAgentToJson(this);
}

@JsonSerializable()
class Environment {
  static final sSmartnote = Environment(title: 'Smartnote Stage', urlPrefix: 'http://39.106.100.225/v2');
  static final pSmartnote = Environment(title: 'Smartnote Production', urlPrefix: 'https://service.36notes.com/v2');
  static final pUgeenote = Environment(title: 'Ugeenote Production', urlPrefix: 'http://mi.xp-pen.com/v2');

  final String title;
  final String urlPrefix;

  Environment({
    this.title,
    this.urlPrefix,
  });

  factory Environment.fromJson(Map<String, dynamic> json) => _$EnvironmentFromJson(json);

  Map<String, dynamic> toJson() => _$EnvironmentToJson(this);
}