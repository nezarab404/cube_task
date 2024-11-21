import 'package:cube_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/components/app_text.dart';
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
        final gifs = cubit.gifs;
        if (state is HomeInitial) {
          return const Center(
            child: AppText(text: 'Search for a GIF !'),
          );
        }
        if (state is HomeLoading && state.isRefresh) {
          return const LoadingWidget();
        }
        if (state is HomeFailed) {
          return RefreshWidget(
            error: state.message,
            onRefresh: cubit.getGifs,
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            context.read<HomeCubit>().getGifs(isRefresh: true);
          },
          child: GridView.builder(
            controller: context.read<HomeCubit>().scrollController,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.sizeOf(context).height / 3,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.w,
            ),
            itemBuilder: (context, index) {
              if (state is HomeLoading && index == gifs.length) {
                return SizedBox(
                  width: 50.w,
                  height: 50.w,
                  child: const CircularProgressIndicator(),
                );
              }
              if (state is HomeSuccess &&
                  !state.hasMore &&
                  index == state.gifs.length) {
                return const Text('NoMoreItemsWidget');
              }
              return GifCard(gifResponse: gifs[index]);
            },
            itemCount:
                (state is HomeLoading || state is HomeSuccess && !state.hasMore)
                    ? gifs.length + 1
                    : gifs.length,
          ),
        );
      },
    );
  }
}
