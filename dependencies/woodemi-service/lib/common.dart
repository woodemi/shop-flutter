class WoodemiResponse {
  final WoodemiStatus status;
  final Object data;

  WoodemiResponse.fromMap(Map map)
      : this.status = WoodemiStatus.fromMap(map['status']),
        this.data = map['data'];
}

class WoodemiStatus {
  static const success = 0;
  static const accessExpire = -998;
  static const accessInvalid = -91004;

  final int statuscode;
  final String message;

  WoodemiStatus.fromMap(Map map)
      : this.statuscode = int.parse(map['statuscode']),
        this.message = map['message'];
}

class WoodemiException implements Exception {
  final int statuscode;
  final String message;
  
  WoodemiException(WoodemiStatus status)
      : statuscode = status.statuscode,
        message = status.message;
}

class NetException implements Exception {
  final int statuscode;
  final String message;

  NetException(int statuscode, String message)
      : statuscode = statuscode,
        message = message;
}