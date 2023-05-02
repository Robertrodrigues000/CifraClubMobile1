// coverage:ignore-file
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_state.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/widgets/cifras_collapsed_header.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/widgets/cifras_fixed_header.dart';
import 'package:cifraclub/presentation/widgets/cosmos_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nav/nav.dart';

class CifrasScreen extends StatefulWidget {
  const CifrasScreen({super.key, required this.isTablet, required this.songbook});
  final bool isTablet;
  final Songbook? songbook;

  @override
  State<CifrasScreen> createState() => _CifrasScreenState();
}

class _CifrasScreenState extends State<CifrasScreen> {
  late CifrasBloc _bloc;
  final scrollController = ScrollController();
  var isScrolledUnder = false;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<CifrasBloc>(context);
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final currentOffset = scrollController.offset;
    setState(() {
      isScrolledUnder = currentOffset > 0 ? true : false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.getCifras(widget.songbook);
  }

  @override
  void didUpdateWidget(covariant CifrasScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.songbook != widget.songbook) {
      _bloc.getCifras(widget.songbook);
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate,
      );
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CifrasBloc, CifrasState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CosmosAppBar(
            title: Text(context.text.lists, style: context.typography.title3),
            toolbarHeight: context.appDimensionScheme.appBarHeight,
            automaticallyImplyLeading: false,
            //TODO: implementar title spacing no cosmos e depois adicionar aqui
            leading: widget.isTablet
                ? null
                : Row(
                    children: [
                      SizedBox(width: context.appDimensionScheme.appBarMargin),
                      InkWell(
                        onTap: () => Nav.of(context).pop(),
                        child: SizedBox(
                          height: 48,
                          width: 48,
                          child: SvgPicture.asset(
                            AppSvgs.backArrowIcon,
                            fit: BoxFit.none,
                            color: context.colors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
            actions: [
              InkWell(
                onTap: () {},
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: SvgPicture.asset(
                    AppSvgs.shareIcon,
                    fit: BoxFit.none,
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: SvgPicture.asset(
                    AppSvgs.addIcon,
                    fit: BoxFit.none,
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: SvgPicture.asset(
                    AppSvgs.overflowIcon,
                    fit: BoxFit.none,
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
              SizedBox(width: context.appDimensionScheme.appBarMargin),
            ],
          ),
          body: CustomScrollView(
            controller: scrollController,
            slivers: [
              CifrasCollapsedHeader(
                isScrolledUnder: isScrolledUnder,
                isPublic: widget.songbook?.isPublic ?? false,
                songbookName: widget.songbook?.name ?? "",
              ),
              CifrasFixedHeader(
                isScrolledUnder: isScrolledUnder,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.cifras.length,
                  (context, index) => ListTile(
                    title: Text("Cifra numero $index -- ${state.cifras[index]}"),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
