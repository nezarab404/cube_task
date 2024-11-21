import 'package:cube_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/components/loading_widget.dart';
import '../../../../shared/components/refresh_widget.dart';
import 'gif_card.dart';

class GifsGrid extends StatelessWidget {
  const GifsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return switch (state) {
          HomeInitial() => const LoadingWidget(),
          HomeLoading() => const LoadingWidget(),
          HomeSuccess() => RefreshIndicator(
              onRefresh: () async {
                context.read<HomeCubit>().getGifs();
              },
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.w,
                ),
                itemBuilder: (context, index) {
                  return GifCard(gifResponse: state.gifs[index]);
                },
                itemCount: state.gifs.length,
              ),
            ),
          HomeFailed() => RefreshWidget(
              error: state.message,
              onRefresh: cubit.getGifs,
            ),
        };
      },
    );
  }
}
