import 'dart:developer' as prints;

import 'dart:io';
import 'dart:math';

import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gal/gal.dart';
import 'package:gap/gap.dart';

import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pix_revive/core/App/data/cubit/cubit_state.dart';
import 'package:pix_revive/core/Functions/custom_flushbar.dart';
import 'package:pix_revive/core/api/dio_client.dart';
import 'package:pix_revive/core/constants/app_colors.dart';
import 'package:pix_revive/core/constants/app_fonts.dart';
import 'package:pix_revive/core/constants/app_icons.dart';
import 'package:pix_revive/core/router/go_router.dart';
import 'package:pix_revive/core/App/data/cubit/app_cubit.dart';

import 'package:pix_revive/core/App/screen/splash_screen.dart';
import 'package:color_filter_extension/color_filter_extension.dart';

enum Filters { brightness, contrast, noun }

final controller = PageController();
final globalKey = GlobalKey();

class EnhanceImages extends StatelessWidget {
  const EnhanceImages({super.key, required this.images});

  final List<XFile> images;

  static const List<List<String>> basic = [
    ["Brightness", Kicon.brightness],
    ["Contrast", Kicon.contrast],
    ["SuperRes", Kicon.superResolution],
    ["Deblur", Kicon.deblur],
    ["Denoise", Kicon.denoising],
    ["Colorization", Kicon.colorlization],

    ["Filters", Kicon.mathFilters],
  ];

  @override
  Widget build(BuildContext context) {
    int rotate = 0;
    var cubit = context.read<AppCubit>();
    var newImages = images;
    return Scaffold(
      backgroundColor: Kcolor.white,
      body: BlocConsumer<AppCubit, AppCubitState>(
        listener: (context, state) {
          if (state is SuccessState) {
            pushReplacement(context, KRoutes.saved);
          }
          if (state is LoadingStateAi) {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: Colors.transparent,
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Lottie.asset(Kicon.aiLoading),
                ),
              ),
            );
          }
          if (state is Finish) {
            newImages[0] = state.image!;
            pop(context);
          }
          if (state is ErrorState) {
            pop(context);
            customFlushbar(state.message ?? "Network Error").show(context);
          }
        },
        buildWhen: (previous, current) => current is! FilterRebuildState,
        builder: (context, state) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Kcolor.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 4,
                      offset: Offset(0, 2), // ✅ only bottom shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 45, 16, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Kcolor.lightgray,
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: SvgPicture.asset(Kicon.backArrow, width: 20),
                        ),
                      ),

                      LogoText(size: 20),
                      GestureDetector(
                        onTap: () async {
                          await cubit.saveInGallery(
                            newImages[0],
                            rotate,
                            cubit,
                          );
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            color: Kcolor.mainColor,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF00c2a8).withValues(alpha: 0.4),
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),

                          child: state is LoadingState
                              ? CircularProgressIndicator(
                                  color: Kcolor.white,
                                  padding: const EdgeInsets.all(10),
                                  strokeWidth: 3,
                                )
                              : Icon(
                                  Icons.file_download_rounded,
                                  color: Kcolor.white,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Gap(20),
              Expanded(
                flex: 9,
                child: SizedBox(
                  width: double.infinity,
                  // height: MediaQuery.of(context).size.height * 0.5,
                  child: BlocBuilder<AppCubit, AppCubitState>(
                    buildWhen: (previous, current) =>
                        current is FilterRebuildState,
                    builder: (context, state) {
                      return PageView.builder(
                        itemCount: newImages.length,
                        itemBuilder: (context, index) => ColorFiltered(
                          colorFilter: ColorFilterExt.merged([
                            ColorFilterExt.brightness(
                              cubit.filterModel.brightness,
                            ),
                            ColorFilterExt.contrast(cubit.filterModel.contrast),
                          ]).colorFilter,
                          child: RotatedBox(
                            quarterTurns: rotate % 4,
                            child: Image.file(
                              File(newImages[index].path),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RotateIcon(
                        icon: Icons.rotate_left_outlined,
                        onTap: () {
                          rotate--;
                          cubit.changeFilter();
                        },
                      ),
                    ),
                    CustomButtonApplyFilter(
                      cubit: cubit,
                      onTap: () async {
                        if (cubit.indexFeature < 2 && !cubit.secoundy) {
                          cubit.apply = !cubit.apply;
                          cubit.changeFilter();
                          return;
                        }
                        prints.log(cubit.indexFeature.toString());

                        await cubit.uploadImageInServer(
                          Endpoints.uploadImage,
                          newImages[0],
                          feature: _getFeature(
                            cubit.indexFeature,
                            cubit.secoundy,
                          ),
                          cubit: cubit,
                          loading: true,
                        );
                      },
                      currentIndex: cubit.indexFeature,
                    ),
                    Expanded(
                      child: RotateIcon(
                        icon: Icons.rotate_right_outlined,
                        onTap: () {
                          rotate++;
                          cubit.changeFilter();
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NAVToolBar(
                      mainList: basic,
                      cubit: cubit,
                      index: (index) {
                        cubit.indexFeature = index;
                      },
                      boolSecoundry: (value) {
                        cubit.secoundy = value;

                        cubit.emitInitial();
                      },
                      apply: cubit.apply,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getFeature(int index, bool isSecondary) {
    if (isSecondary) {
      switch (index) {
        case 0:
          return 'GAUSSIAN_FILTER';
        case 1:
          return 'BILATERAL_FILTER';
        case 2:
          return 'GUIDED_FILTER';
        case 3:
          return 'MEDIAN_FILTER';
        default:
          return 'GAUSSIAN_FILTER';
      }
    } else {
      switch (index) {
        case 2:
          return 'SUPER_RESOLUTION';
        case 3:
          return 'DE_BLUR';
        case 4:
          return 'DE_NOISE';
        case 5:
          return 'COLORIZATION';
        default:
          return 'NONE'; // Or your default primary feature
      }
    }
  }
}

class CustomButtonApplyFilter extends StatefulWidget {
  const CustomButtonApplyFilter({
    super.key,
    required this.onTap,
    required this.currentIndex,
    required this.cubit,
  });
  final VoidCallback onTap;
  final int currentIndex;
  final AppCubit cubit;
  @override
  State<CustomButtonApplyFilter> createState() =>
      _CustomButtonApplyFilterState();
}

class _CustomButtonApplyFilterState extends State<CustomButtonApplyFilter> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Kcolor.mainColor,
      ),
      onPressed: widget.onTap,
      child: SizedBox(
        height: 45,
        child: Center(
          child: Text(
            ((widget.currentIndex == 0 || widget.currentIndex == 1) &&
                    !widget.cubit.secoundy)
                ? "Apply"
                : "Use AI Feature",
            style: Kfonts.semiBold14.copyWith(color: Kcolor.white),
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CustomButtonApplyFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      setState(() {
        //   apply = true;
      });
    }
  }
}

class RotateIcon extends StatelessWidget {
  const RotateIcon({super.key, required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: Icon(icon, size: 30));
  }
}

class NAVToolBar extends StatefulWidget {
  const NAVToolBar({
    super.key,
    required this.mainList,
    required this.cubit,
    required this.index,
    required this.apply,
    required this.boolSecoundry,
  });

  final List<List<String>> mainList;
  final AppCubit cubit;
  final Function(int) index;
  final Function(bool) boolSecoundry;
  final bool apply;
  static const List<String> list = [
    "Gaussian",
    "Bilateral ",
    "Guided",
    "Median",
  ];
  static const List<String> listIcons = [
    Kicon.gaussian,
    Kicon.bilateralFilter,
    Kicon.guided,
    Kicon.madian,
  ];

  @override
  State<NAVToolBar> createState() => _NAVToolBarState();
}

class _NAVToolBarState extends State<NAVToolBar> {
  int currentIndex = 0;

  bool secoundry = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 95,
          width: double.infinity,

          child: ListView.builder(
            padding: EdgeInsets.only(right: 16),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: secoundry
                ? NAVToolBar.list.length
                : widget.mainList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 5,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (!secoundry && index == 6) {
                            // CHANGED: go to filters immediately in one tap
                            secoundry = true;
                            currentIndex = 0;
                          } else {
                            currentIndex = index;
                          }
                        });

                        widget.index(currentIndex);
                        widget.boolSecoundry(secoundry);
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: (currentIndex == index)
                              ? Kcolor.mainColor
                              : Kcolor.white,
                          borderRadius: BorderRadius.circular(90),
                          boxShadow: currentIndex == index
                              ? [
                                  BoxShadow(
                                    color: Color(
                                      0xFF00c2a8,
                                    ).withValues(alpha: 0.4),
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                        child: SvgPicture.asset(
                          secoundry
                              ? NAVToolBar.listIcons[index]
                              : widget.mainList[index][1],
                          width: 20,
                          colorFilter: ColorFilter.mode(
                            (currentIndex == index)
                                ? Colors.amberAccent
                                : Kcolor.gray,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      secoundry
                          ? NAVToolBar.list[index]
                          : widget.mainList[index][0],
                      style: Kfonts.regular16.copyWith(
                        fontSize: 13,
                        color: (currentIndex == index)
                            ? Kcolor.mainColor
                            : Kcolor.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // CHANGED: wrap with Expanded to take remaining column space
        if (secoundry)
          GestureDetector(
            onTap: () {
              setState(() {
                secoundry = !secoundry;
                currentIndex = 0;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 13, bottom: 13),
              child: Row(
                spacing: 5,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    color: Kcolor.mainColor,
                    size: 18,
                  ),
                  Text(
                    "Back",
                    style: Kfonts.regular16.copyWith(color: Kcolor.mainColor),
                  ),
                ],
              ),
            ),
          ),
        if (!secoundry)
          CusomSlider(
            cubit: widget.cubit,
            text: '',
            min: -1,
            max: 1,
            filter: selectFilter(currentIndex),
            Apply: widget.apply,
          ),
      ],
    );
  }

  Filters selectFilter(int index) {
    Filters filter;
    switch (index) {
      case 0:
        filter = Filters.brightness;
        break;
      case 1:
        filter = Filters.contrast;
        break;
      default:
        filter = Filters.noun;
    }
    return filter;
  }

  @override
  void didUpdateWidget(covariant NAVToolBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.apply != oldWidget.apply) {
      setState(() {});
    }
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
    required this.Apply,
  });

  final VoidCallback? onTap;
  final String text;
  final double min;
  final double max;
  final AppCubit cubit;
  final Filters filter;
  final bool Apply;

  @override
  State<CusomSlider> createState() => _CusomSliderState();
}

class _CusomSliderState extends State<CusomSlider> {
  late double value;
  late double reversedValue;
  int index = 0;
  @override
  void initState() {
    super.initState();

    setData();
  }

  @override
  Widget build(BuildContext context) {
    return widget.filter != Filters.noun
        ? Row(
            spacing: 5,
            children: [
              Expanded(
                child: Slider.adaptive(
                  secondaryActiveColor: Kcolor.mainColor,
                  activeColor: Kcolor.mainColor,
                  inactiveColor: Kcolor.lightgray,
                  value: value,
                  divisions: 200,
                  max: widget.max,
                  min: widget.min,
                  thumbColor: Kcolor.backgroundColor,
                  onChanged: (value) {
                    setState(() {
                      this.value = value;
                      typeOfFilter(value);
                      widget.cubit.changeFilter();
                    });
                  },
                ),
              ),
              Text(
                value > 0
                    ? "+ ${value.toStringAsFixed(2)}"
                    : " ${value.toStringAsFixed(2)}",
                style: Kfonts.semiBold14.copyWith(color: Kcolor.mainColor),
              ),
              const Gap(10),
            ],
          )
        : const Gap(48);
  }

  void typeOfFilter(double data) {
    if (widget.filter == Filters.brightness) {
      widget.cubit.filterModel.brightness = data;
    }
    if (widget.filter == Filters.contrast) {
      widget.cubit.filterModel.contrast = data;
    }
  }

  void setData() {
    if (widget.filter == Filters.brightness) {
      value = widget.cubit.filterModel.brightness;
      widget.cubit.filterModel.previuseBrightines = value;
    }
    if (widget.filter == Filters.contrast) {
      value = widget.cubit.filterModel.contrast;
      widget.cubit.filterModel.previuseContrast = value;
    }
  }

  @override
  void didUpdateWidget(covariant CusomSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      setData();
    });

    if (widget.filter != oldWidget.filter) {
      setState(() {
        if (widget.Apply == oldWidget.Apply) {
          if (oldWidget.filter == Filters.brightness) {
            widget.cubit.filterModel.brightness =
                widget.cubit.filterModel.previuseBrightines;
            value = widget.cubit.filterModel.previuseContrast;
          } else if (oldWidget.filter == Filters.contrast) {
            widget.cubit.filterModel.contrast =
                widget.cubit.filterModel.previuseContrast;
            value = widget.cubit.filterModel.previuseBrightines;
          }

          widget.cubit.changeFilter();
        }
      });
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

Future<void> saveIMageinGallery(XFile image, int rotate, AppCubit cubit) async {
  final codec = await instantiateImageCodec(
    await File(image.path).readAsBytes(),
  );
  final original = (await codec.getNextFrame()).image; // 👈 HERE

  // draw
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);

  final isRotated = rotate % 2 != 0;
  final outW = isRotated ? original.height : original.width; // uses original ✅
  final outH = isRotated ? original.width : original.height; // uses original ✅

  if (rotate % 4 != 0) {
    canvas.translate(outW / 2, outH / 2);
    canvas.rotate((rotate % 4) * pi / 2);
    canvas.translate(
      -original.width / 2,
      -original.height / 2,
    ); // uses original ✅
  }

  canvas.drawImage(
    original, // uses original ✅
    Offset.zero,
    Paint()
      ..colorFilter = ColorFilterExt.merged([
        ColorFilterExt.brightness(cubit.filterModel.brightness),
        ColorFilterExt.contrast(cubit.filterModel.contrast),
      ]).colorFilter,
  );

  // save
  final byteData = await (await recorder.endRecording().toImage(
    outW,
    outH,
  )).toByteData(format: ImageByteFormat.png);

  await Gal.putImageBytes(byteData!.buffer.asUint8List());
}

Future<XFile> imageToXFile(XFile image, int rotate, AppCubit cubit) async {
  final codec = await instantiateImageCodec(
    await File(image.path).readAsBytes(),
  );
  final original = (await codec.getNextFrame()).image;

  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);

  final isRotated = rotate % 2 != 0;
  final outW = isRotated ? original.height : original.width;
  final outH = isRotated ? original.width : original.height;

  if (rotate % 4 != 0) {
    canvas.translate(outW / 2, outH / 2);
    canvas.rotate((rotate % 4) * pi / 2);
    canvas.translate(-original.width / 2, -original.height / 2);
  }

  canvas.drawImage(
    original,
    Offset.zero,
    Paint()
      ..colorFilter = ColorFilterExt.merged([
        ColorFilterExt.brightness(cubit.filterModel.brightness),
        ColorFilterExt.contrast(cubit.filterModel.contrast),
      ]).colorFilter,
  );

  final byteData = await (await recorder.endRecording().toImage(
    outW,
    outH,
  )).toByteData(format: ImageByteFormat.png);

  final dir = await getTemporaryDirectory();
  final filePath =
      '${dir.path}/edited_${DateTime.now().millisecondsSinceEpoch}.png';
  await File(filePath).writeAsBytes(byteData!.buffer.asUint8List());

  return XFile(filePath);
}
