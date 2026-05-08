import 'package:another_flushbar/flushbar.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pix_revive/core/App/data/cubit/app_cubit.dart';

import 'package:pix_revive/core/constants/app_colors.dart';
import 'package:pix_revive/core/constants/app_fonts.dart';
import 'package:pix_revive/core/constants/app_icons.dart';
import 'package:pix_revive/core/router/go_router.dart';
import 'package:pix_revive/core/App/auth/Screen/auth_controller.dart';

const List<List<dynamic>> features = [
  ["Adjust brightness", true],
  ["Remove Blur", true],
  ["Adjust Contrast", true],
  ["Reduce Noise", true],
  ["High Resolotion", true],
  // ["Up to 10 Images", false],
];
const List<String> explain = [
  "Make your photo lighter or darker. Perfect for fixing dark indoor shots or washed-out outdoor photos.",
  "",
  "Increase the difference between light and dark areas. Makes colors pop and gives your photo more depth.",
];
const List<String> imagesPath = [
  Kicon.beforeAndafterBrightnessPNG,
  "",
  Kicon.afterContrastPNG,
];

class Home extends StatelessWidget {
  const Home({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // CircleAvatar(
            //   radius: 25,
            //   backgroundColor: Kcolor.mainColor.withValues(alpha: 0.3),

            //   child: CircleAvatar(
            //     radius: 23,
            //     backgroundColor: Kcolor.mainColor,
            //     child: Text(
            //       "JD",
            //       style: Kfonts.meduim16.copyWith(color: Kcolor.white),
            //     ),
            //   ),
            // ),
            const Gap(10),
            Expanded(
              child: Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Kfonts.regular16.copyWith(color: Kcolor.black),
                  ),
                  Text(
                    "Welcome back!",
                    style: Kfonts.regular16.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
            PlanContianer(
              color: Kcolor.gray,
              onTap: () => push(context, KRoutes.subscritptionPlan),
            ),
          ],
        ),
        Spacer(),
        const Text(
          "Transform your photos with AI",
          style: Kfonts.regular18Black,
        ),
        const Gap(25),

        WhiteBoardContainer(),
        Spacer(),
        const Text("What you can do", style: Kfonts.regular14),
        const Gap(20),
        Wrap(
          children: List.generate(
            features.length,
            (index) => GestureDetector(
              onTap: () {
                if (index == 0 || index == 2) {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      insetPadding: const EdgeInsets.all(16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Kcolor.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              spacing: 12,
                              children: [
                                Expanded(
                                  child: Text(
                                    features[index][0],
                                    style: Kfonts.bold18Black,
                                  ),
                                ),
                                CustomContainer(
                                  width: 35,
                                  height: 35,
                                  padding: 6,
                                  corner: 24,
                                  color: Colors.grey.shade300,
                                  onTap: () => pop(context),
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: Kcolor.gray,
                                    size: 14,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(10),
                            Text(explain[index], style: Kfonts.regular14),
                            const Gap(10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(imagesPath[index]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
              child: SizedBox(
                width: (MediaQuery.of(context).size.width / 2) - 24,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                  child: Features(
                    text: features[index][0],

                    icon: Icon(Icons.check, size: 16, color: Colors.green),
                  ),
                ),
              ),
            ),
          ),
        ),
        Spacer(flex: 3),
      ],
    );
  }
}

class ClickableText extends StatelessWidget {
  const ClickableText({
    super.key,
    required this.text,
    required this.onTap,
    required this.index,
    required this.color,
  });
  final String text;
  final int index;
  final Color color;
  final Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Text(
          text,
          style: Kfonts.bold18Black.copyWith(color: color),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.width,
    this.height,
    this.corner,
    this.child,
    this.padding,
    this.color,
    this.onTap,

    this.boxShadow,
    this.margin,
    this.border,
  });
  final double? width;
  final double? height;
  final double? corner;
  final EdgeInsetsGeometry? margin;

  final List<BoxShadow>? boxShadow;
  final double? padding;
  final Color? color;
  final Widget? child;
  final BoxBorder? border;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,

        margin: margin,
        padding: EdgeInsets.all(padding ?? 0),
        decoration: BoxDecoration(
          border: border,
          color: color ?? Kcolor.mainColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(corner ?? 0),
          boxShadow: boxShadow,
        ),
        child: child,
      ),
    );
  }
}

class PlanContianer extends StatelessWidget {
  const PlanContianer({super.key, required this.color, this.onTap});
  final Color color;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: Kcolor.white,
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: SvgPicture.asset(
          Kicon.crown,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class Features extends StatelessWidget {
  const Features({
    super.key,
    required this.text,
    this.icon,
    this.textColor,
    this.color,
  });
  final String text;
  final Widget? icon;
  final Color? textColor;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color ?? Kcolor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color != null
                ? Kcolor.gold.withValues(alpha: 0.1)
                : Kcolor.black.withValues(alpha: 0.09),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: Kfonts.semiBold14.copyWith(
                color: textColor ?? Kcolor.black,
                fontSize: 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          icon ?? SizedBox(),
        ],
      ),
    );
  }
}

class WhiteBoardContainer extends StatefulWidget {
  const WhiteBoardContainer({super.key});

  @override
  State<WhiteBoardContainer> createState() => _WhiteBoardContainerState();
}

class _WhiteBoardContainerState extends State<WhiteBoardContainer> {
  double topMargin = 0;
  final ImagePicker picker = ImagePicker();
  List<XFile> images = [];
  List<List<String>> imageInfo = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    jumpAnimation();
  }

  void jumpAnimation() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        topMargin = topMargin == 0 ? 10 : 0;
      });
      jumpAnimation();
    });
  }

  Future<void> pickImages() async {
    var result = await picker.pickMultiImage(requestFullMetadata: true);
    images.clear();
    imageInfo.clear();

    if (result.isNotEmpty) {
      imageInfo = await getImagesInfo(result);
      setState(() {
        images.addAll(result);
      });
      push(context, KRoutes.enhanceImages, extra: images);
    }
  }

  Future<List<List<String>>> getImagesInfo(List<XFile> images) async {
    List<List<String>> imageInfo = [];
    for (var i in images) {
      List<String> temp = [];
      temp.add("${((await i.length()) / (1024 * 1024)).toStringAsFixed(2)} MB");
      DateTime date = await i.lastModified();
      temp.add(
        "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}",
      );

      imageInfo.add(temp);
    }
    return imageInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await pickImages();
          },
          child: Imagesboard(
            height: 250,
            width: 400,
            corner: 24,
            padding: const EdgeInsets.all(0.7),
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(24),
                padding: EdgeInsets.all(2),
                color: Kcolor.black.withValues(alpha: 0.3),
                dashPattern: [4, 5],
                strokeWidth: 1.5,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        transform: Matrix4.translationValues(0, topMargin, 0),
                        curve: Curves.easeInOut,
                        child: CustomLogo(
                          height: 80,
                          width: 80,
                          corner: 16,
                          padding: EdgeInsets.all(20),
                          icon: Kicon.upload,
                        ),
                      ),
                      const Gap(40),
                      const Text(
                        "Upload your photos",
                        style: Kfonts.bold18Black,
                      ),
                      const Gap(10),
                      const Text(
                        "Tap to select an images and start editing",
                        style: Kfonts.regular14,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Imagesboard extends StatelessWidget {
  const Imagesboard({
    super.key,
    this.height,
    this.width,
    required this.corner,
    this.padding,
    this.child,
    this.color,
  });

  final double? height;
  final double? width;
  final double corner;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: color ?? Kcolor.white,
        borderRadius: BorderRadius.circular(corner),
        boxShadow: [
          if (color == null)
            BoxShadow(
              color: Kcolor.mainColor.withValues(alpha: 0.1),
              blurRadius: 10,
            ),
        ],
      ),
      child: child,
    );
  }
}
