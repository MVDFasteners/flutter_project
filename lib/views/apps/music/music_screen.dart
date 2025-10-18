import 'package:flatten/controllers/apps/music/music_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/images.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen>
    with TickerProviderStateMixin, UIMixin {
  late MusicController controller;

  @override
  void initState() {
    controller = Get.put(MusicController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<MusicController>(
        init: controller,
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Music",
                      fontWeight: 600,
                      fontSize: 18,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "Apps"),
                        MyBreadcrumbItem(name: "Music", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Column(
                  children: [
                    MySpacing.height(flexSpacing / 2),
                    MyFlex(contentPadding: false, children: [
                      MyFlexItem(
                        sizes: 'lg-9',
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyContainer(
                              paddingAll: 0,
                              height: 310,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              width: double.infinity,
                              child: Image.asset(
                                Images.musicPoster,
                                fit: BoxFit.cover,
                              ),
                            ),
                            MySpacing.height(flexSpacing),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText.bodyLarge(
                                  "Top Albums",
                                  fontWeight: 600,
                                ),
                                Row(
                                  children: [
                                    Icon(LucideIcons.move_left),
                                    MySpacing.width(8),
                                    Icon(LucideIcons.move_right),
                                  ],
                                ),
                              ],
                            ),
                            MySpacing.height(8),
                            SizedBox(
                              height: 225,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    controller.songsName['popular'].length,
                                itemBuilder: (context, index) {
                                  var music =
                                      controller.songsName['popular'][index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      MyContainer(
                                        height: 150,
                                        width: 150,
                                        paddingAll: 0,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Image.asset(
                                          Images.music[
                                              index % Images.music.length],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      MySpacing.height(16),
                                      MyText.bodyMedium(
                                        music['singer_name'],
                                        fontWeight: 600,
                                      ),
                                      MyText.bodyMedium(music['song_name']),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 20,
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText.bodyLarge(
                                  "Top Artist",
                                  fontWeight: 600,
                                ),
                                Row(
                                  children: [
                                    Icon(LucideIcons.move_left),
                                    MySpacing.width(8),
                                    Icon(LucideIcons.move_right),
                                  ],
                                ),
                              ],
                            ),
                            MySpacing.height(8),
                            SizedBox(
                              height: 160,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    controller.songsName['Latest'].length,
                                itemBuilder: (context, index) {
                                  var music =
                                      controller.songsName['Latest'][index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      MyContainer(
                                        height: 100,
                                        width: 100,
                                        borderRadiusAll: 100,
                                        paddingAll: 0,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Image.asset(
                                          Images.avatars[
                                              index % Images.avatars.length],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      MySpacing.height(16),
                                      MyText.bodyMedium(
                                        music['singer_name'],
                                        fontWeight: 600,
                                      ),
                                      MyText.bodyMedium(music['song_name']),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 20,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      MyFlexItem(
                        sizes: 'lg-3',
                        child: MyFlex(
                          contentPadding: false,
                          children: [
                            MyFlexItem(
                              child: MyContainer(
                                child: Column(
                                  children: [
                                    MyContainer.roundBordered(
                                      paddingAll: 0,
                                      child: MyContainer.rounded(
                                        height: 100,
                                        width: 100,
                                        paddingAll: 0,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Image.asset(
                                          Images.music[13],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    MySpacing.height(12),
                                    MyText.bodyLarge(
                                      "All Too Well",
                                      fontWeight: 600,
                                      muted: true,
                                    ),
                                    MyText.bodyMedium(
                                      "Tylor Swift",
                                      fontWeight: 600,
                                      xMuted: true,
                                    ),
                                    MySpacing.height(12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(right: 8),
                                          child: ClipOval(
                                            child: Material(
                                              color: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(28),
                                                  side: BorderSide.none),
                                              child: InkWell(
                                                splashColor:
                                                    theme.colorScheme.primary,
                                                child: SizedBox(
                                                    height: 48,
                                                    width: 48,
                                                    child: Icon(
                                                      LucideIcons.skip_back,
                                                      color: theme.colorScheme
                                                          .onSurface,
                                                      size: 28,
                                                    )),
                                                onTap: () {},
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(48),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: theme
                                                        .colorScheme.primary
                                                        .withAlpha(42),
                                                    spreadRadius: 1,
                                                    blurRadius: 6,
                                                    offset: Offset(0, 6))
                                              ]),
                                          child: ClipOval(
                                            child: Material(
                                              elevation: 5,
                                              color: theme.colorScheme.primary,
                                              child: InkWell(
                                                splashColor: Colors.white,
                                                child: IconButton(
                                                  iconSize: 28,
                                                  icon: AnimatedIcon(
                                                    icon: AnimatedIcons
                                                        .play_pause,
                                                    progress: controller
                                                        .animationController,
                                                    color: theme
                                                        .colorScheme.onPrimary,
                                                  ),
                                                  onPressed: () {
                                                    controller.musicPlay();
                                                  },
                                                ),
                                                onTap: () {},
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 8),
                                          child: ClipOval(
                                            child: Material(
                                              color: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(28),
                                                  side: BorderSide.none),
                                              child: InkWell(
                                                splashColor:
                                                    theme.colorScheme.primary,
                                                child: SizedBox(
                                                    height: 48,
                                                    width: 48,
                                                    child: Icon(
                                                      LucideIcons.skip_forward,
                                                      color: theme.colorScheme
                                                          .onSurface,
                                                      size: 28,
                                                    )),
                                                onTap: () {},
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 16, right: 16, top: 12),
                                      child: Row(
                                        children: <Widget>[
                                          ClipOval(
                                            child: Material(
                                              color: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(28),
                                                  side: BorderSide.none),
                                              child: InkWell(
                                                splashColor:
                                                    theme.colorScheme.primary,
                                                child: SizedBox(
                                                    height: 36,
                                                    width: 36,
                                                    child: Icon(
                                                      LucideIcons.shuffle,
                                                      color: theme.colorScheme
                                                          .onSurface,
                                                      size: 22,
                                                    )),
                                                onTap: () {},
                                              ),
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(left: 16),
                                              child: MyText.bodySmall(
                                                  controller.time,
                                                  fontWeight: 500)),
                                          Expanded(
                                            child: SliderTheme(
                                              data: SliderTheme.of(context)
                                                  .copyWith(trackHeight: 2.5),
                                              child: Slider(
                                                value: controller.position
                                                    .toDouble(),
                                                onChanged: controller
                                                    .onTrackDurationChange,
                                                min: 0,
                                                max: controller.duration
                                                    .toDouble(),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: MyText.bodySmall("3:20",
                                                  fontWeight: 500)),
                                          ClipOval(
                                            child: Material(
                                              color: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(28),
                                                  side: BorderSide.none),
                                              child: InkWell(
                                                splashColor:
                                                    theme.colorScheme.primary,
                                                child: SizedBox(
                                                    height: 36,
                                                    width: 36,
                                                    child: Icon(
                                                      controller.repeatType == 0
                                                          ? LucideIcons.repeat
                                                          : (controller
                                                                      .repeatType ==
                                                                  1
                                                              ? LucideIcons
                                                                  .repeat_1
                                                              : LucideIcons
                                                                  .repeat_2),
                                                      color: theme.colorScheme
                                                          .onSurface,
                                                      size: 22,
                                                    )),
                                                onTap: () {
                                                  setState(() {
                                                    controller.repeatType =
                                                        (++controller
                                                                .repeatType) %
                                                            3;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            MyFlexItem(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount:
                                    controller.songsName['songList'].length,
                                itemBuilder: (context, index) {
                                  var songList =
                                      controller.songsName['songList'][index];
                                  return MyContainer.bordered(
                                    width: double.infinity,
                                    borderRadiusAll: 100,
                                    paddingAll: 12,
                                    child: Row(
                                      children: [
                                        MyContainer.rounded(
                                          height: 32,
                                          width: 32,
                                          paddingAll: 0,
                                          color: contentTheme.primary
                                              .withAlpha(40),
                                          child: Center(
                                            child: Icon(
                                              LucideIcons.play,
                                              size: 16,
                                              color: contentTheme.primary,
                                            ),
                                          ),
                                        ),
                                        MySpacing.width(12),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyText(
                                              songList['singer_name'],
                                              fontWeight: 600,
                                            ),
                                            MyText(
                                              songList['song_name'],
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        MyContainer.rounded(
                                          height: 32,
                                          width: 32,
                                          paddingAll: 0,
                                          color: contentTheme.primary
                                              .withAlpha(40),
                                          child: Center(
                                            child: Icon(
                                              LucideIcons.thumbs_up,
                                              size: 16,
                                              color: contentTheme.primary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 12,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
