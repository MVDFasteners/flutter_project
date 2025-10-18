import 'package:flatten/app_constant.dart';
import 'package:flatten/controllers/apps/ecommerce/reviews_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/utils.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_responsiv.dart';
import 'package:flatten/helpers/widgets/my_screen_media_type.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_star_rating.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/helpers/widgets/my_text_style.dart';
import 'package:flatten/models/reviews.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late ReviewsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ReviewsController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Reviews",
                      fontWeight: 600,
                      fontSize: 18,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "UI"),
                        MyBreadcrumbItem(name: "Reviews", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyResponsive(builder: (_, _, type) {
                  return Padding(
                    padding: MySpacing.x((type == MyScreenMediaType.xl ||
                            type == MyScreenMediaType.xxl)
                        ? 150
                        : type == MyScreenMediaType.lg
                            ? 100
                            : 0),
                    child: Column(
                      children: [
                        MyFlex(
                          contentPadding: false,
                          children: [
                            MyFlexItem(
                              sizes: "lg-4",
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.bodySmall(
                                    "Total Reviews",
                                    fontWeight: 600,
                                  ),
                                  MySpacing.height(12),
                                  Row(
                                    children: [
                                      MyText.bodyLarge(
                                        "25.0k",
                                        fontSize: 24,
                                        fontWeight: 600,
                                      ),
                                      MySpacing.width(8),
                                      MyContainer(
                                        color:
                                            contentTheme.primary.withAlpha(20),
                                        padding: MySpacing.xy(8, 4),
                                        borderRadiusAll: 100,
                                        child: Row(
                                          children: [
                                            MyText.titleSmall(
                                              "21%",
                                              fontSize: 12,
                                              color: contentTheme.primary,
                                            ),
                                            Icon(
                                              LucideIcons.trending_up,
                                              color: contentTheme.primary,
                                              size: 12,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  MySpacing.height(12),
                                  MyText.bodySmall(
                                    "Growth in reviews on this year",
                                    muted: true,
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                            MyFlexItem(
                              sizes: "lg-4",
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.bodySmall(
                                    "Average Reviews",
                                    fontWeight: 600,
                                  ),
                                  MySpacing.height(12),
                                  Row(
                                    children: [
                                      MyText.bodyLarge(
                                        "4.5",
                                        fontSize: 24,
                                        fontWeight: 600,
                                      ),
                                      MySpacing.width(8),
                                      MyStarRating(
                                        rating: 4.5,
                                        size: 20,
                                        activeColor: AppColors.star,
                                      ), // buildReviewStar(),
                                    ],
                                  ),
                                  MySpacing.height(12),
                                  MyText.bodySmall(
                                    "Average Rating on This year",
                                    muted: true,
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                            MyFlexItem(
                              sizes: "lg-4",
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildReviewRatingChart(
                                      "5", 150, contentTheme.primary, "5.0k"),
                                  buildReviewRatingChart(
                                      "4", 120, contentTheme.title, "3.0k"),
                                  buildReviewRatingChart(
                                      "3", 90, contentTheme.warning, "400"),
                                  buildReviewRatingChart(
                                      "2", 15, contentTheme.success, "100"),
                                  buildReviewRatingChart(
                                      "1", 25, contentTheme.info, "4k"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        MySpacing.height(16),
                        Divider(),
                        MySpacing.height(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MyButton.outlined(
                              onPressed: () {
                                controller.pickDateRange();
                              },
                              borderColor: contentTheme.primary,
                              padding: MySpacing.xy(16, 16),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    LucideIcons.calendar,
                                    color: contentTheme.primary,
                                    size: 16,
                                  ),
                                  MySpacing.width(10),
                                  MyText.labelMedium(
                                      controller.selectedDateTimeRange != null
                                          ? "${dateFormatter.format(controller.selectedDateTimeRange!.start)} - ${dateFormatter.format(controller.selectedDateTimeRange!.end)}"
                                          : "Date Between",
                                      fontWeight: 600,
                                      color: contentTheme.primary),
                                ],
                              ),
                            ),
                          ],
                        ),
                        MySpacing.height(8),
                        SizedBox(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: controller.reviews.length,
                            itemBuilder: (context, index) {
                              return ReviewWidget(
                                review: controller.reviews[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                height: 36,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildReviewRatingChart(
      String number, double width, Color color, String ratingNumber) {
    return Row(
      children: [
        Icon(
          LucideIcons.star,
          size: 16,
          color: contentTheme.onBackground.withAlpha(64),
        ),
        MySpacing.width(8),
        MyText.bodyMedium(
          number,
          fontSize: 12,
        ),
        MySpacing.width(8),
        MyContainer.none(
          width: width,
          paddingAll: 4,
          borderRadiusAll: 12,
          color: color,
        ),
        MySpacing.width(8),
        MyText.titleMedium(
          ratingNumber,
          fontSize: 12,
        ),
      ],
    );
  }

  Widget buildButtons(String buttonText) {
    return MyButton.outlined(
      onPressed: () {},
      elevation: 0,
      padding: MySpacing.xy(20, 16),
      borderColor: contentTheme.primary,
      splashColor: contentTheme.primary.withValues(alpha: 0.1),
      borderRadiusAll: AppStyle.buttonRadius.medium,
      child: MyText.bodySmall(
        buttonText,
        color: contentTheme.primary,
      ),
    );
  }
}

class ReviewWidget extends StatefulWidget {
  final Review review;

  const ReviewWidget({required this.review, super.key});

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> with UIMixin {
  late Review review;
  bool isLiked = false;
  int initialRating = -1;

  @override
  void initState() {
    super.initState();
    review = widget.review;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            MyContainer(
              paddingAll: 0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                review.image,
                height: 58,
                fit: BoxFit.cover,
              ),
            ),
            MySpacing.width(16),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.titleMedium(
                  review.name,
                  fontWeight: 600,
                  overflow: TextOverflow.ellipsis,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Total Spend: ',
                          style: MyTextStyle.bodySmall()),
                      TextSpan(
                        text: "\$${review.totalSpend}",
                        style: MyTextStyle.bodyMedium(
                          fontWeight: 600,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Total Review: ',
                        style: MyTextStyle.bodySmall(),
                      ),
                      TextSpan(
                        text: "${review.totalReview}",
                        style: MyTextStyle.bodyMedium(
                          fontWeight: 600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        MySpacing.height(12),
        Row(
          children: [
            buildReviewStar(),
            MySpacing.width(12),
            MyText.bodyMedium(
              '${Utils.getDateStringFromDateTime(review.date)}',
            ),
          ],
        ),
        MySpacing.height(12),
        MyText.bodySmall(review.comment),
        MySpacing.height(12),
        Row(
          children: [
            buildButtons("Public Comment"),
            MySpacing.width(16),
            buildButtons("Direct Message"),
            MySpacing.width(16),
            IconButton(
              onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                });
              },
              icon: Icon(!isLiked ? Icons.favorite_outline : Icons.favorite,
                  size: 24, color: contentTheme.primary),
            ),
          ],
        )
      ],
    );
  }

  Widget buildReviewStar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < 5; i++)
          GestureDetector(
            onTap: () {
              setState(() {
                initialRating = i;
              });
            },
            child: i <= initialRating
                ? Icon(
                    Icons.star,
                    color: AppColors.star,
                  )
                : Icon(
                    LucideIcons.star,
                    color: AppColors.star,
                  ),
          ),
      ],
    );
  }

  Widget buildButtons(String buttonText) {
    return MyButton.outlined(
      onPressed: () {},
      elevation: 0,
      padding: MySpacing.xy(20, 16),
      borderColor: contentTheme.primary,
      splashColor: contentTheme.primary.withValues(alpha: 0.1),
      borderRadiusAll: AppStyle.buttonRadius.medium,
      child: MyText.bodySmall(
        buttonText,
        color: contentTheme.primary,
      ),
    );
  }
}
