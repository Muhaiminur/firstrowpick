//  Class to represent a message object, used to display messages
import 'package:pubnub/pubnub.dart';

class ChatMessage {
  final Timetoken timetoken;
  final String channel;
  final String uuid;
  final String message;

  ChatMessage(
      {required this.timetoken,
      required this.channel,
      required this.uuid,
      required this.message});
}
