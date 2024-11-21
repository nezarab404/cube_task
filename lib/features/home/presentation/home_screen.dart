import 'package:cube_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:cube_task/features/home/presentation/widgets/gifs_grid.dart';
import 'package:cube_task/shared/components/custom_app_bar.dart';
import 'package:cube_task/shared/components/custom_text_field.dart';
import 'package:cube_task/shared/utils/debouncer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../shared/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../shared/utils/ui_helper.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.createAppBar(
        title: LocaleKeys.home.tr(),
      ),
      body: Padding(
          padding: UIHelper.pagePadding,
          child: Column(
            children: [
              CustomTextField(
                controller: context.read<HomeCubit>().searchController,
                hint: 'Search for gif...',
                onChange: (str) {
                  debouncer.run(() {
                    context.read<HomeCubit>().getGifs();
                  });
                },
              ),
              UIHelper.verticalSpaceMedium(),
              const Expanded(
                child: GifsGrid(),
              ),
            ],
          )),
    );
  }
}
