import 'dart:math';

import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class ListLimitWarningSnackBar {
  static SnackBar getListLimitSnackBar({
    required int limit,
    required bool isVersionLimit,
    required int count,
    required ListLimitState listLimitState,
    required int proLimit,
    required bool isPro,
  }) {
    return SnackBar(
      duration: const Duration(milliseconds: 3500),
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      content: LimitWarning(
        limit: limit,
        isVersionLimit: isVersionLimit,
        count: count,
        listLimitState: listLimitState,
        proLimit: proLimit,
        isPro: isPro,
      ),
    );
  }
}

class LimitWarning extends StatelessWidget {
  const LimitWarning(
      {super.key,
      required this.limit,
      required this.isVersionLimit,
      required this.count,
      required this.listLimitState,
      required this.proLimit,
      required this.isPro});

  final int limit;
  final bool isVersionLimit;
  final ListLimitState listLimitState;
  final int count;
  final int proLimit;
  final bool isPro;

  @override
  Widget build(BuildContext context) {
    final listType = isVersionLimit ? context.text.versions : context.text.lists;
    return isPro
        ? Padding(
            padding: const EdgeInsetsDirectional.all(8),
            child: Text(
              getProListLimitText(context, isVersionLimit),
              style: TextStyle(color: context.colors.textPrimaryInverse),
            ))
        : Padding(
            padding: const EdgeInsetsDirectional.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  listLimitState == ListLimitState.reached
                      ? context.text.listLimitReached(limit, proLimit, listType)
                      : context.text.listLimitWarning(limit, proLimit, listType),
                  key: const Key("warning-message"),
                ),
                if (listLimitState == ListLimitState.atWarning) ...[
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    context.text.joinCifraClubPro,
                  )
                ],
                const SizedBox(
                  height: 16,
                ),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        highlightColor: CosmosColors.transparent,
                        splashColor: CosmosColors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        // coverage:ignore-start
                        onTap: () {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        },
                        // coverage:ignore-end
                        child: Text(
                          context.text.notNow.toUpperCase(),
                          style: TextStyle(color: context.colors.textPrimaryInverse, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        // coverage:ignore-start
                        onTap: () {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        },
                        // coverage:ignore-end
                        highlightColor: CosmosColors.transparent,
                        splashColor: CosmosColors.transparent,
                        splashFactory: NoSplash.splashFactory,

                        child: Text(
                          context.text.testPro.toUpperCase(),
                          style: TextStyle(
                            color: context.colors.successSecondary,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  String getProListLimitText(BuildContext context, bool isVersionLimit) {
    String message;

    if (listLimitState == ListLimitState.reached) {
      message = isVersionLimit ? context.text.versionsLimitReachedPro : context.text.listLimitReachedPro;
    } else {
      message = isVersionLimit ? context.text.versionsLimitWarningPro : context.text.listLimitWarningPro;
    }

    return message;
  }
}
