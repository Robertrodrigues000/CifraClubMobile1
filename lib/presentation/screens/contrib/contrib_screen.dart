// coverage:ignore-file
// ignore_for_file: avoid_print
import 'package:cifraclub/domain/version/models/instrument_contrib.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/contrib/contrib_screen_bloc.dart';
import 'package:cifraclub/presentation/screens/contrib/contrib_screen_state.dart';
import 'package:cifraclub/presentation/screens/home/widgets/list_animation.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContribScreenBloc, ContribScreenState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            Row(
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
            )
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.colors.neutralTertiary),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: context.typography.title5,
                children: [
                  TextSpan(text: context.text.seeOur, style: context.typography.body11),
                  TextSpan(
                    text: context.text.publicationRules,
                    style: context.typography.body11.copyWith(color: context.colors.primary),
                  ),
                ],
              ),
            ),
          ),
        ),
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
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
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
                      columnCount: 3,
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
                                Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.amber,
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  height: 24,
                                  child: Text(instrument.instrumentName, style: context.typography.body5),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
