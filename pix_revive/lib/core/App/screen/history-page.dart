import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pix_revive/core/App/data/cubit/app_cubit.dart';
import 'package:pix_revive/core/App/screen/home_screen.dart';
import 'package:pix_revive/core/constants/app_colors.dart';
import 'package:pix_revive/core/constants/app_fonts.dart';
import 'package:pix_revive/core/router/go_router.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>()..getHistory();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("History", style: Kfonts.bold30Black),
          Text(
            "${cubit.responseHistory.length} edited Photos",
            style: Kfonts.regular16,
          ),
          const Gap(16),
          cubit.responseHistory.length != 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cubit.responseHistory.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    String url =
                        cubit.responseHistory[index]?.restoredImage ?? "";
                    String fileName = url.split('/').last;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        splashFactory: InkRipple.splashFactory,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => GestureDetector(
                              onTap: () => pop(context),
                              child: Dialog(
                                backgroundColor: Colors.transparent,
                                insetPadding: EdgeInsets.zero,
                                child: PhotoView(
                                  backgroundDecoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(
                                        Icons.broken_image,
                                        color: Kcolor.white,
                                      ),
                                  imageProvider: NetworkImage(url),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Ink(
                          width: double.infinity,
                          height: 100,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Kcolor.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Kcolor.black.withValues(alpha: 0.09),
                                blurRadius: 16,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),

                          child: Row(
                            spacing: 16,
                            children: [
                              CustomContainer(
                                width: 68,
                                height: 68,
                                color: Kcolor.gray.withValues(alpha: 0.2),
                                corner: 16,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),

                                  child: Image.network(
                                    url,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value:
                                                  loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Icon(Icons.broken_image),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  spacing: 5,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      fileName,
                                      style: Kfonts.meduim16.copyWith(
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),

                                    Text(
                                      "${cubit.responseHistory[index]!.createdAt?.toIso8601String().split("T").first}",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      "No history yet",
                      style: Kfonts.regular16.copyWith(color: Kcolor.gray),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
