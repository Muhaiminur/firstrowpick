import 'dart:io';
import 'dart:math';
import 'dart:developer' as dev;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/themeController.dart';
import 'package:halftimepick/models/chatmsg.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/utils/shared_pref.dart';
import 'package:intl/intl.dart';
import 'package:pubnub/pubnub.dart';

class GlobalChat extends StatefulWidget {
  const GlobalChat({
    super.key,
  });

  @override
  _GlobalChatState createState() => _GlobalChatState();
}

class _GlobalChatState extends State<GlobalChat> {
  final ThemeController themeController = Get.find<ThemeController>();
  late PubNub pubNub;
  late Subscription subscription;
  TextEditingController messageController = TextEditingController();
  List<ChatMessage> messages = [];
  String channelName = "ALL";
  SharedPref sharedPref = SharedPref();
  List<String> userDetail = [];
  String deviceid = "";
  Future<List<String>> getUser() async {
    var userDel = await sharedPref.readStringList("userDet") ?? <String>[];
    setState(() {
      userDetail = userDel;
    });
    return userDetail;
  }

  ScrollController scrollController = ScrollController();

  Color getRandomColor() {
    Random random = Random();
    int red = random.nextInt(256);
    int green = random.nextInt(256);
    int blue = random.nextInt(256);
    return Color.fromRGBO(red, green, blue, 1);
  }

  String formatTimetoken(Timetoken timetoken) {
    int microseconds = int.parse(timetoken.toString());
    int millisecondsSinceEpoch =
        microseconds ~/ 10000; // Convert Timetoken to milliseconds since epoch
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        millisecondsSinceEpoch); // Convert milliseconds to DateTime
    String formattedDateTime = DateFormat('MMM dd, hh:mm a').format(dateTime);
    return formattedDateTime;
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 120,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  String getDeviceId() {
    var deviceId = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        deviceInfo.androidInfo.then((AndroidDeviceInfo info) {
          deviceId = info.id; // Unique Android ID
        });
      } else if (Platform.isIOS) {
        deviceInfo.iosInfo.then((IosDeviceInfo info) {
          deviceId = info.identifierForVendor!;
          // Unique iOS ID
        });
      }
    } catch (e) {
      print('Failed to get device info: $e');
    }
    return deviceId;
  }

  @override
  void initState() {
    super.initState();
    dev.log("ALL");
    deviceid = getDeviceId();
    getUser().then((value) {
      pubNub = PubNub(
        defaultKeyset: Keyset(
          subscribeKey: 'sub-c-bceb9e2e-5124-4849-a9c6-76690408f2f3',
          publishKey: 'pub-c-fb12aeec-9332-4cb1-ad18-751fead78f6a',
          userId: UserId(userDetail.first),
        ),
      );
      subscription = pubNub.subscribe(channels: {channelName});
      subscription.messages.listen((event) {
        setState(() {
          //   messages.add('${event.uuid}: ${event.payload}');
          messages.add(ChatMessage(
              timetoken: event.timetoken,
              channel: channelName,
              uuid: event.uuid.toString(),
              message: event.payload));
          scrollToBottom();
        });
      });
      fetchHistory();
    });
  }

  bool selfOrOther(String uuid) {
    if (userDetail.last.toLowerCase().toString() ==
            deviceid.toLowerCase().toString() &&
        userDetail.first.toLowerCase().toString() ==
            uuid.toLowerCase().toString()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void sendMessage() async {
    await pubNub.publish(channelName, messageController.text);
    messageController.clear();
    scrollToBottom();
  }

  void fetchHistory() async {
    var result = await pubNub.batch.fetchMessages({channelName},
        count: 10); // Fetching 10 previous messages
    List<BatchHistoryResultEntry> historyResults =
        result.channels[channelName] ?? [];
    setState(() {
      messages.addAll(historyResults.map((entry) {
        return ChatMessage(
            timetoken: entry.timetoken,
            channel: channelName,
            uuid: entry.uuid!,
            message: entry.message);
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    const double bottomNavigationBarHeight = kBottomNavigationBarHeight;
    final double screenHeight = MediaQuery.of(context).size.height;
    print(screenHeight);
    final double screenHeightWithoutAppBarAndBottomNavigationBar =
        screenHeight - appBarHeight - bottomNavigationBarHeight;

    return Container(
      color: themeController.isDarkMode.value ? Colors.black : Colors.white,
      height: screenHeight < 670
          ? screenHeightWithoutAppBarAndBottomNavigationBar - 30
          : screenHeightWithoutAppBarAndBottomNavigationBar - 90,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: EdgeInsets.zero,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return selfOrOther(messages[index].uuid)
                    ? ListTile(
                        contentPadding: const EdgeInsets.only(right: 10),
                        dense: true,
                        isThreeLine: true,
                        trailing: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ProjectColors
                                .bottomnavselectedcolor, // Change color as needed
                          ),
                          child: Center(
                            child: Text(
                              messages[index].uuid[0].toString().toUpperCase(),
                              style: const TextStyle(
                                color:
                                    Colors.white, // Change text color as needed
                                fontSize: 16, // Change font size as needed
                              ),
                            ),
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Spacer(),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Text(
                                  messages[index].message,
                                  textAlign: TextAlign.end,
                                )),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            const Spacer(),
                            Text(
                              formatTimetoken(
                                messages[index].timetoken,
                              ),
                              style: TextStyle(color: Colors.grey.shade600),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      )
                    : ListTile(
                        contentPadding: const EdgeInsets.only(left: 10),
                        dense: true,
                        isThreeLine: true,
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: getRandomColor(), // Change color as needed
                          ),
                          child: Center(
                            child: Text(
                              messages[index].uuid[0].toString().toUpperCase(),
                              style: const TextStyle(
                                color:
                                    Colors.white, // Change text color as needed
                                fontSize: 16, // Change font size as needed
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                            "${messages[index].uuid}: ${messages[index].message}"),
                        subtitle:
                            Text(formatTimetoken(messages[index].timetoken)),
                      );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  decoration: !themeController.isDarkMode.value
                      ? const BoxDecoration()
                      : BoxDecoration(
                          color: ProjectColors.secondaryColor,
                          borderRadius: BorderRadius.circular(4)),
                  height: 44,
                  width: MediaQuery.of(context).size.width - 74,
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter message',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                          color: Colors.grey, // Default border color
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                          color: ProjectColors
                              .bottomnavselectedcolor, // Border color when focused
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (messageController.text.isNotEmpty) {
                      sendMessage();
                    }
                  },
                  child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                          color: ProjectColors.bottomnavselectedcolor,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
