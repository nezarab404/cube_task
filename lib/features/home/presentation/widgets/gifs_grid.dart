import 'package:cube_task/features/home/data/models/gif_response.dart';
import 'package:cube_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:cube_task/shared/components/app_text.dart';
import 'package:cube_task/shared/utils/observers/custom_bloc_observer.dart';
import 'package:cube_task/shared/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'gif_card.dart';

class GifsGrid extends StatelessWidget {
  const GifsGrid({super.key, required this.gifs});

  final List<GifResponse> gifs;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeCubit>().getGifs();
      },
      child: Padding(
        padding: UIHelper.pagePadding,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.w,
          ),
          itemBuilder: (context, index) {
            return GifCard(gifResponse: gifs[index]);
          },
          itemCount: gifs.length,
        ),
      ),
    );
  }
}
