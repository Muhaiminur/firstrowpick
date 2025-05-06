import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/models/nhl_games/datum.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/utils/routes.dart';
import 'package:halftimepick/utils/timeZone_format.dart';

class NhlScoreItem extends StatefulWidget {
  final NhlGamesData item;
  const NhlScoreItem({super.key, required this.item});

  @override
  State<NhlScoreItem> createState() => _NhlScoreItemState();
}

class _NhlScoreItemState extends State<NhlScoreItem> {
  bool hasMinusSign(double moneylinehome) {
    if (moneylinehome < 0) {
      if (kDebugMode) {
        print("home ");
      }
    } else {
      if (kDebugMode) {
        print("away");
      }
    }
    return moneylinehome < 0 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          color: ProjectColors.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: ProjectColors.secondaryTextColor,
                        ),
                        child: const Text(
                          "A",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          widget.item.teamsNormalized!.first.abbreviation!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,

                        alignment: Alignment.center,

                        //AWAY
                        //if - 14.5 at Home than Total will be beside Away
                        // if -5.5 is at Away than Total will be beside home, like this example
                        child: widget.item.lines!.isNotEmpty
                            ? hasMinusSign(widget.item.lines!.first.moneyline!
                                    .moneylineHome!)
                                ? Text(
                                    widget.item.lines!.first.total!.totalOver
                                                .toString() ==
                                            "0.0001"
                                        ? "--"
                                        : widget
                                            .item.lines!.first.total!.totalOver
                                            .toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  )
                                : Text(
                                    widget.item.lines!.first.moneyline!
                                                .moneylineAway
                                                .toString() ==
                                            "0.0001"
                                        ? "--"
                                        : widget.item.lines!.first.moneyline!
                                            .moneylineAway!
                                            .toInt()
                                            .toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  )
                            : const Text("-"),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        alignment: Alignment.center,
                        child: Text(
                          widget.item.score!.scoreAway!.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: ProjectColors.secondaryTextColor,
                        ),
                        child: const Text(
                          "H",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          widget.item.teamsNormalized!
                              .elementAt(1)
                              .abbreviation!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        alignment: Alignment.center,

                        //HOME
                        child: widget.item.lines!.isNotEmpty
                            ? hasMinusSign(widget.item.lines!.first.moneyline!
                                    .moneylineHome!)
                                ? Text(
                                    widget.item.lines!.first.moneyline!
                                                .moneylineHome
                                                .toString() ==
                                            "0.0001"
                                        ? "--"
                                        : widget.item.lines!.first.moneyline!
                                            .moneylineHome!
                                            .toInt()
                                            .toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  )
                                : Text(
                                    widget.item.lines!.first.total!.totalOver
                                                .toString() ==
                                            "0.0001"
                                        ? "--"
                                        : widget
                                            .item.lines!.first.total!.totalOver
                                            .toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  )
                            : const Text("-"),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        alignment: Alignment.center,
                        child: Text(
                          widget.item.score!.scoreHome!.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        convertTo12HourFormat(
                            widget.item.score!.eventStatusDetail!),
                        textAlign: TextAlign.end,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        widget.item.score!.broadcast!,
                        textAlign: TextAlign.end,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          width: double.infinity,
          color: ProjectColors.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.item.message!.isNotEmpty
                  ? Container(
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width * 0.7,
                      padding: const EdgeInsets.all(12),
                      color: ProjectColors.primaryColor,
                      child: Text(
                        widget.item.message!,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
              InkWell(
                onTap: () {
                  Get.toNamed(livepage);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ProjectColors.secondaryTextColor),
                  child: const Text(
                    "View Live",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
