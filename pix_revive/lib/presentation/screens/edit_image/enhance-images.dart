import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pix_revive/core/constants/app_colors.dart';
import 'package:pix_revive/core/constants/app_fonts.dart';
import 'package:pix_revive/core/constants/app_icons.dart';
import 'package:pix_revive/core/router/go_router.dart';
import 'package:pix_revive/presentation/providers/AppCubit/app_cubit.dart';
import 'package:pix_revive/presentation/providers/auth_provider.dart';
import 'package:pix_revive/presentation/screens/home/home_screen.dart';
import 'package:pix_revive/presentation/screens/splash/splash_screen.dart';
import 'package:color_filter_extension/color_filter_extension.dart';

enum Filters { brightness, contrast }

final controller = PageController();

class EnhanceImages extends StatelessWidget {
  const EnhanceImages({super.key, required this.images});
  final List<XFile> images;
 static const List<List<List<String>>> mainList = [basic, advance];
  static const List<List<String>> basic = [
    ["Brightness", Kicon.brightness],
    ["Contrast", Kicon.contrast],
  ];

  static const List<List<String>> advance = [
    ["Deblurring", Kicon.deblur],
    ["Denoising", Kicon.denoising],
    ["Super Resolution", Kicon.superResolution],
  ];

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AppCubit>();
    final List<Widget> features = [
      CusomSlider(
        min: -1,
        max: 1,
        cubit: cubit,
        onTap: () => cubit.reversePage(),
        text: "Brightness",
        filter: Filters.brightness,
      ),
      CusomSlider(
        min: -1,
        max: 1,
        cubit: cubit,
        onTap: () => cubit.reversePage(),
        text: "Contrast",
        filter: Filters.contrast,
      ),
    ];
    return Scaffold(
      bottomNavigationBar: BlocBuilder<AppCubit, AppCubitState>(
        buildWhen: (previous, current) =>
            (current is ReversePageState ||
            current is InitialState ||
            current is NextPageState),
        builder: (context, state) {
          if (state is ReversePageState || state is InitialState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: NavBar(controller: controller),
              ),
            );
          }
          return SizedBox(height: 53);
        },
      ),
      body: SafeArea(
        child: BlocBuilder<AppCubit, AppCubitState>(
          buildWhen: (previous, current) => current is! FilterRebuildState,
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => pop(context),
                        child: SvgPicture.asset(Kicon.backArrow),
                      ),

                      LogoText(size: 24),
                      ClipOval(
                        child: Container(
                          width: 40,
                          height: 40,
                          padding: EdgeInsets.all(6),
                          color: Kcolor.mainColor,
                          child: SvgPicture.asset(Kicon.download),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                BlocBuilder(
                  buildWhen: (previous, current) =>
                      current is InitState || current is FilterRebuildState,
                  bloc: context.read<AppCubit>(),
                  builder: (context, state) {
                    return SizedBox(
                    width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: ColorFiltered(
                        colorFilter: ColorFilterExt.merged([
                          ColorFilterExt.brightness(
                            cubit.filterModel.brightness,
                          ),
                          ColorFilterExt.contrast(cubit.filterModel.contrast),
                        ]).colorFilter,
                        child: PageView.builder(
                          itemCount: images.length,
                          itemBuilder: (context, index) => Image.file(
                            File(images[index].path),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Spacer(),
                SizedBox(
                  height: 150,
                  child: PageView.builder(
                    controller: controller,
                    itemCount: mainList.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (state is! NextPageState) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            spacing: 3,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(mainList[index].length, (
                              currentindex,
                            ) {
                              return Expanded(
                                child: GestureDetector(
                                  onTap: index==0? () {
                                    cubit.nextPage(currentindex);
                                  }:null,
                                  child: Imagesboard(
                                    corner: 9,
                                    height: 115,
                                    padding: EdgeInsets.fromLTRB(12,12,12,0),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Gap(5),
                                          SizedBox(width:36 ,height: 36,
                                            child: SvgPicture.asset(
                                              mainList[index][currentindex][1]
                                            ),
                                          ),
                                          const Gap(15),
                                          Expanded(
                                            child: Text(
                                              mainList[index][currentindex][0],
                                              style: Kfonts.semiBold14,
                                              overflow: TextOverflow.fade,textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      }
                      return features[state.index];
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CusomSlider extends StatefulWidget {
  const CusomSlider({
    super.key,
    this.onTap,
    required this.text,
    required this.min,
    required this.max,
    required this.cubit,
    required this.filter,
  });

  final VoidCallback? onTap;
  final String text;
  final double min;
  final double max;
  final AppCubit cubit;
  final Filters filter;
  @override
  State<CusomSlider> createState() => _CusomSliderState();
}

class _CusomSliderState extends State<CusomSlider> {
  late double value;
  late double reversedValue;

  @override
  void initState() {
    // TODO: implement initState
    value = widget.cubit.filterModel.brightness;
    reversedValue = widget.cubit.filterModel.brightness;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      child: Row(
        spacing: 5,
        children: [
          Expanded(
            child: Imagesboard(
              height: 120,
              corner: 9,
              padding: EdgeInsets.all(10),
              child: Column(
                spacing: 5,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.text, style: Kfonts.semiBold14),
                        InkWell(
                          onTap: () {
                            typeOfFilter(reversedValue);
                            widget.onTap!();
                          },
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: Kcolor.grayOpacity,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Slider.adaptive(
                    secondaryActiveColor: Kcolor.mainColor,
                    activeColor: Kcolor.mainColor,
                    inactiveColor: Kcolor.grayOpacity,
                    value: value,
                    divisions: 200,
                    max: widget.max,
                    min: widget.min,

                    thumbColor: Kcolor.mainColor,
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                        debugPrint(value.toString());
                        typeOfFilter(value);
                        widget.cubit.changeFilter();
                      });
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      (100 * value).toStringAsFixed(0),
                      style: Kfonts.semiBold14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              typeOfFilter(value);
              widget.cubit.reversePage();
              widget.cubit.changeFilter();
            },
            child: Imagesboard(
              height: 120,
              width: 80,
              corner: 9,
              padding: EdgeInsets.all(10),
              child: Center(child: Text("Apply", style: Kfonts.semiBold14)),
            ),
          ),
        ],
      ),
    );
  }

  void typeOfFilter(double data) {
    if (widget.filter == Filters.brightness) {
      widget.cubit.filterModel.brightness = data;
    } else {
      widget.cubit.filterModel.contrast = data;
    }
  }
}

class NavBar extends StatefulWidget {
  const NavBar({super.key, required this.controller});
  final PageController controller;
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<Color> colors = [Kcolor.mainColor, Kcolor.grayOpacity];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: currentIndex != 0
              ? () {
                  whereIam(currentIndex);
                }
              : null,
          child: NavbarText(text: "Basic", color: colors[0]),
        ),
        GestureDetector(
          onTap: currentIndex != 1
              ? () {
                  whereIam(currentIndex);
                }
              : null,
          child: NavbarText(text: "Advance", color: colors[1]),
        ),
      ],
    );
  }

  void whereIam(int index) {
    setState(() {
      if (index == 0) {
        currentIndex = 1;
        colors[0] = Kcolor.grayOpacity;
        colors[1] = Kcolor.mainColor;
        widget.controller.animateToPage(
          currentIndex,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeIn,
        );
      } else {
        currentIndex = 0;
        colors[0] = Kcolor.mainColor;
        colors[1] = Kcolor.grayOpacity;
        widget.controller.animateToPage(
          currentIndex,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeIn,
        );
      }
    });
  }
}

class NavbarText extends StatelessWidget {
  const NavbarText({super.key, required this.text, required this.color});

  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: Kfonts.semiBold20.copyWith(color: color));
  }
}
