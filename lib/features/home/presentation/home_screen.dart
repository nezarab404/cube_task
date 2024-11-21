import 'package:cube_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:cube_task/features/home/presentation/widgets/gifs_grid.dart';
import 'package:cube_task/shared/components/refresh_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../shared/components/loading_widget.dart';
import '../../../shared/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.home.tr(),
          style: const TextStyle(
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return switch (state) {
            HomeInitial() => const LoadingWidget(),
            HomeLoading() => const LoadingWidget(),
            HomeSuccess() => GifsGrid(gifs: state.gifs),
            HomeFailed() => RefreshWidget(
                error: state.message,
                onRefresh: context.read<HomeCubit>().getGifs,
              ),
          };
        },
      ),
    );
  }
}
