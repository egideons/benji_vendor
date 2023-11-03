import 'package:benji_vendor/src/components/appbar/my%20appbar.dart';
import 'package:benji_vendor/src/components/card/customer_review_card.dart';
import 'package:benji_vendor/src/components/card/empty.dart';
import 'package:benji_vendor/src/controller/reviews_controller.dart';
import 'package:benji_vendor/src/providers/constants.dart';
import 'package:benji_vendor/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

const List<int> stars = [5, 4, 3, 2, 1];

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(
        backgroundColor: kPrimaryColor,
        title: "Reviews",
        actions: const [],
        elevation: 0.0,
      ),
      backgroundColor: kPrimaryColor,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: ListView(
          shrinkWrap: true,
          children: [
            kSizedBox,
            Container(
              width: media.width,
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: ShapeDecoration(
                color: const Color(0xFFFEF8F8),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 0.50,
                    color: Color(0xFFFDEDED),
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 24,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Reviews & Ratings",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: kDefaultPadding,
                      horizontal: kDefaultPadding * 0.5,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GetBuilder<ReviewsController>(
                            builder: (controller) => OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: controller.ratingValue.value == 0
                                      ? kAccentColor
                                      : const Color(
                                          0xFFA9AAB1,
                                        ),
                                ),
                                backgroundColor:
                                    controller.ratingValue.value == 0
                                        ? kAccentColor
                                        : kPrimaryColor,
                                foregroundColor:
                                    controller.ratingValue.value == 0
                                        ? kPrimaryColor
                                        : const Color(0xFFA9AAB1),
                              ),
                              onPressed: () async {
                                await controller.setRatingValue();
                              },
                              child: const Text(
                                'All',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          GetBuilder<ReviewsController>(
                            builder: (controller) => Row(
                              children: stars
                                  .map(
                                    (item) => Row(
                                      children: [
                                        kHalfWidthSizedBox,
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                              color: controller
                                                          .ratingValue.value ==
                                                      item
                                                  ? kStarColor
                                                  : const Color(0xFFA9AAB1),
                                            ),
                                            foregroundColor:
                                                controller.ratingValue.value ==
                                                        item
                                                    ? kStarColor
                                                    : const Color(0xFFA9AAB1),
                                          ),
                                          onPressed: () async {
                                            await controller
                                                .setRatingValue(item);
                                          },
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                width: kDefaultPadding * 0.2,
                                              ),
                                              Text(
                                                item.toString(),
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          kHalfWidthSizedBox,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            kSizedBox,
            GetBuilder<ReviewsController>(
              initState: (state) async {
                await ReviewsController.instance.getReviews();
              },
              builder: (controller) => Column(
                children: [
                  controller.isLoad.value && controller.reviews.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(
                            color: kAccentColor,
                          ),
                        )
                      : controller.reviews.isEmpty
                          ? const EmptyCard()
                          : ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, index) => kSizedBox,
                              shrinkWrap: true,
                              itemCount: controller.reviews.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  CostumerReviewCard(
                                      rating: controller.reviews[index]),
                            ),
                  kSizedBox,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
