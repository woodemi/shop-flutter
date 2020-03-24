import 'package:woodemi_service/WoodemiService.dart';
import 'package:woodemi_service/model.dart';

final sServerManager = ServerManager._init();

class ServerManager extends WoodemiService {

  Environment environment;

  String get userServiceUrl {
    return environment == Environment.sSmartnote
        ? 'http://39.106.100.225/v2'
        : 'https://36noteservice.woodemi.com/v2';
  }

  ServerManager._init() {
    WoodemiService.clientAgent = ClientAgent.aSmartnoteLight;
    environment = Environment.sSmartnote;
  }
}