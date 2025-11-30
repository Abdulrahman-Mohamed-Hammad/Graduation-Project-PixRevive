import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pix_revive/core/constants/app_colors.dart';
import 'package:pix_revive/core/constants/app_fonts.dart';
import 'package:pix_revive/core/constants/app_icons.dart';
import 'package:pix_revive/core/router/go_router.dart';
import 'package:pix_revive/presentation/providers/auth_controller.dart';

const List<List<dynamic>> features = [
  ["Adjust brightness", true],
  ["Remove Blur", true],
  ["Adjust Contrast", true],
  ["Reduce Noise", true],
  ["High Resolotion", true],
  ["Up to 10 Images", false],
];

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Kcolor.firstGradient.withValues(
                      alpha: 0.3,
                    ),

                    child: CircleAvatar(
                      radius: 23,
                      backgroundColor: Kcolor.firstGradient,
                      child: Text(
                        "JD",
                        style: Kfonts.meduim16.copyWith(color: Kcolor.white),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      spacing: 2,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "John Doe",
                          style: Kfonts.regular16.copyWith(
                            fontSize: 15,
                            color: Kcolor.black,
                          ),
                        ),
                        Text(
                          "Welcome back!",
                          style: Kfonts.regular16.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  PlanContianer(color: Kcolor.gray),
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
              const Gap(15),
              Wrap(
                children: List.generate(
                  features.length,
                  (index) => SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) - 24,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                      child: Features(
                        text: features[index][0],
                        textColor: features[index][1]
                            ? null
                            : Kcolor.inputTextFormField,
                        icon: features[index][1]
                            ? Icon(Icons.check, size: 16, color: Colors.green)
                            : SvgPicture.asset(
                                Kicon.crown,
                                width: 16,
                                colorFilter: ColorFilter.mode(
                                  Kcolor.gold,
                                  BlendMode.srcIn,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

class PlanContianer extends StatelessWidget {
  const PlanContianer({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: SvgPicture.asset(
        Kicon.crown,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}

class Features extends StatelessWidget {
  const Features({super.key, required this.text, this.icon, this.textColor});
  final String text;
  final Widget? icon;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Kcolor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Kcolor.black.withValues(alpha: 0.1),
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
              style: Kfonts.regular14.copyWith(
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
                color: Kcolor.bordorTextFormField,
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
                        style: Kfonts.regular18Black,
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
              color: Kcolor.endGradient.withValues(alpha: 0.15),
              blurRadius: 20,
            ),
        ],
      ),
      child: child,
    );
  }
}

// Widget imageDescriptipn() {
//   return Column(spacing: 10,
//         children: List.generate(images.length, (index) {
//           return Row(
//             children: [
//               SizedBox(
//                 width: 35,
//                 height: 35,
//                 child: ClipOval(

//                   child: Image.file(
//                     File(images[index].path),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//                  const Gap(10),
//               Expanded(flex: 3,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       images[index].name,
//                       style: Kfonts.regular14.copyWith(fontSize: 12,color: Kcolor.black),overflow: TextOverflow.ellipsis,
//                     ),
//                     Text(
//                       imageInfo[index][1],
//                       style: Kfonts.regular14.copyWith(fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),

//               Container(
//                 width: 1,
//                 height: 30,
//                 color: Kcolor.inputTextFormField,
//               ),
//               const Gap(10),
//               Expanded(
//                 child: Text(
//                   imageInfo[index][0],
//                   style: Kfonts.regular14.copyWith(fontSize: 12),
//                 ),
//               ),
//             ],
//           );
//         }),
//       );
// }

//     SizedBox(height: 300,
//       child: CarouselSlider.builder(itemCount: 3, itemBuilder: (context, index, realIndex) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Imagesboard(width: double.infinity,corner: 24,child: LayoutBuilder(builder: (context, constraints) {
//             return Container(child: Image.asset(assetName[index],fit:constraints.biggest.width <500? BoxFit.cover:BoxFit.cover));
//           } )),
//         );
//       }, options: CarouselOptions(
//       viewportFraction: 1,
// //      enlargeCenterPage: true,
// // enlargeFactor: 0.2
//       scrollPhysics: BouncingScrollPhysics()
//       )),
//     ),
