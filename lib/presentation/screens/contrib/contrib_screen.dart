// coverage:ignore-file
// ignore_for_file: avoid_print
import 'package:cifraclub/domain/version/models/instrument_contrib.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/contrib_help_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/contrib/contrib_screen_bloc.dart';
import 'package:cifraclub/presentation/screens/contrib/contrib_screen_state.dart';
import 'package:cifraclub/presentation/screens/contrib/widgets/contrib_bottom_rules.dart';
import 'package:cifraclub/presentation/screens/home/widgets/list_animation.dart';
import 'package:cifraclub/presentation/widgets/device_type_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ContribScreen extends StatefulWidget {
  const ContribScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ContribScreen> createState() => _ContribScreenState();
}

class _ContribScreenState extends State<ContribScreen> {
  late final ContribScreenBloc _bloc = BlocProvider.of<ContribScreenBloc>(context);
  final String patternLink =
      "https://suporte.cifraclub.com.br/pt-BR/support/solutions/articles/64000236814-conheca-o-padr%C3%A3o-para-envio-de-cifras-e-tablaturas";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContribScreenBloc, ContribScreenState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: () {
                  ContribHelpBottomSheet(
                    onTap: () => _bloc.openUrl(patternLink),
                    youtubeThumbnail: _bloc.getYoutubeThumbnail(),
                  ).show(context);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.help_outline,
                      size: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 16),
                      child: Text(context.text.help, style: context.typography.body9),
                    ),
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: ContribBottomRules(openUrl: () => _bloc.openUrl(patternLink)),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 16,
                    left: context.appDimensionScheme.screenMargin,
                    right: context.appDimensionScheme.screenMargin,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.text.sendTabs, style: context.typography.title5),
                      const SizedBox(height: 8),
                      Text(context.text.selectTabType, style: context.typography.subtitle5),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(context.appDimensionScheme.screenMargin),
                sliver: DeviceTypeBuilder(
                  builder: (context, device) {
                    return SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: device == DeviceType.tablet ? 3 : 2,
                        crossAxisSpacing: context.appDimensionScheme.internalMargin,
                        mainAxisSpacing: context.appDimensionScheme.internalMargin,
                        childAspectRatio: 156 / 132,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        childCount: InstrumentContrib.values.length,
                        (context, index) {
                          final instrument = InstrumentContrib.values[index];
                          return AnimationConfiguration.staggeredGrid(
                            duration: ListAnimation.duration,
                            position: index,
                            columnCount: device == DeviceType.tablet ? 2 : 3,
                            child: ListAnimation(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: context.colors.neutralTertiary),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: Image.asset(
                                          instrument.instrumentImage,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      SizedBox(
                                        height: 24,
                                        child: Text(instrument.instrumentName, style: context.typography.body5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
