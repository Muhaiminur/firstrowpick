import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/events_controller.dart';
import 'package:halftimepick/controllers/themeController.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/utils/routes.dart';

class FantasyList extends StatefulWidget {
  const FantasyList({super.key});

  @override
  State<FantasyList> createState() => _FantasyListState();
}

class _FantasyListState extends State<FantasyList> {
  final EventController eventController = Get.put(EventController());
  final ThemeController themeController = Get.find<ThemeController>();
  @override
  void initState() {
    eventController.getFantasyList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Text(
            "SPECIAL",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: themeController.isDarkMode.value
                    ? Colors.white
                    : Colors.black),
          ),
        ),
        const Divider(),
        GetBuilder<EventController>(builder: (controller) {
          return controller.fantasyModelloading.value
              ? controller.fantasyModel.value.data!.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: ProjectColors.primaryColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: Image.network(
                                        controller.fantasyModel.value.data!
                                            .elementAt(index)
                                            .image
                                            .toString(),
                                        width: 30, // set your desired width
                                        height: 30, // set your desired height
                                        fit: BoxFit
                                            .cover, // adjust this according to your needs
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.74,
                                      child: Text(
                                        controller.fantasyModel.value.data!
                                            .elementAt(index)
                                            .title
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      stripHtmlTags(controller
                                          .fantasyModel.value.data!
                                          .elementAt(index)
                                          .description!),
                                      maxLines: 4,
                                    ),
                                  ),
                                  controller.fantasyModel.value.data!
                                          .elementAt(index)
                                          .imageUrl!
                                          .isNotEmpty
                                      ? Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 0.5,
                                              color: ProjectColors.grey,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Image.network(
                                            controller.fantasyModel.value.data!
                                                .elementAt(index)
                                                .imageUrl!,
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const SizedBox(
                                          height: 120,
                                          width: 120,
                                        )
                                ],
                              )
                              /*   Html(
                                  data: controller.fantasyModel.value.data!
                                      .elementAt(index)
                                      .description!,
                                  shrinkWrap: true,
                                  style: {
                                    "body": Style(
                                      maxLines: 2,
                                      textOverflow: TextOverflow.ellipsis,
                                      color: Colors.white,
                                      fontSize: FontSize(14.0),
                                    ),
                                  }), */

                              ,
                              InkWell(
                                onTap: () {
                                  Get.toNamed(fantasyDetailPage,
                                      arguments: controller
                                          .fantasyModel.value.data!
                                          .elementAt(index)
                                          .description!);
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 4),
                                    alignment: Alignment.center,
                                    height: 32,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: ProjectColors
                                            .bottomnavselectedcolor),
                                    child: const Text(
                                      "See More",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    )),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: controller.fantasyModel.value.data!.length)
                  : const Center(
                      heightFactor: 3,
                      child: Text(
                        "No Data Found",
                        style: TextStyle(fontSize: 16),
                      ))
              : Center(
                  heightFactor: 3,
                  child: CupertinoActivityIndicator(
                      color: themeController.isDarkMode.value
                          ? Colors.white
                          : Colors.grey),
                );
        }),
      ],
    );
  }
}

String stripHtmlTags(String htmlString) {
  // Replace line break tags with actual newlines
  htmlString =
      htmlString.replaceAll(RegExp(r"<br\s*/?>", caseSensitive: false), '\n');
  htmlString =
      htmlString.replaceAll(RegExp(r"</p>", caseSensitive: false), '\n');

  // Remove all other HTML tags
  htmlString = htmlString
      .replaceAll(RegExp(r"<[^>]*>", multiLine: true, caseSensitive: false), '')
      .trim();

  // Replace common HTML entities
  htmlString = htmlString
      .replaceAll('&nbsp;', ' ') // Non-breaking space
      .replaceAll('&amp;', '&') // Ampersand
      .replaceAll('&lt;', '<') // Less than
      .replaceAll('&gt;', '>') // Greater than
      .replaceAll('&quot;', '"') // Double quote
      .replaceAll('&apos;', "'"); // Single quote

  return htmlString;
}
