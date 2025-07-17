import 'package:uuid/uuid.dart';

class IdUtils {
  static final _uuid = Uuid();

  static String uuid() => _uuid.v4();

  static String messageId() => 'msg_${uuid()}';

  static String orderId() =>
      'order_${DateTime.now().millisecondsSinceEpoch}_${uuid().substring(0, 6)}';
}
