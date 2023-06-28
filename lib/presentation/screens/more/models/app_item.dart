import 'package:cifraclub/domain/app/models/app.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppItem extends Equatable {
  final String imageAsset;
  final String title;
  final String subtitle;
  final App app;

  const AppItem({
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    required this.app,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props => [imageAsset, title, subtitle, app];

  static List<AppItem> getAllApps(BuildContext context) {
    return [
      AppItem(
          imageAsset: AppWebp.appTuner,
          title: context.text.appTuner,
          subtitle: context.text.appTunerDescription,
          app: App.afinador),
      AppItem(
          imageAsset: AppWebp.appMetronome,
          title: context.text.appMetronome,
          subtitle: context.text.appMetronomeDescription,
          app: App.metronomo),
      AppItem(
          imageAsset: AppWebp.appTheLostPick,
          title: context.text.appTheLostPick,
          subtitle: context.text.appTheLostPickDescription,
          app: App.palheta),
      AppItem(
          imageAsset: AppWebp.appPalco,
          title: context.text.appPalco,
          subtitle: context.text.appPalcoDescription,
          app: App.palco),
      AppItem(
          imageAsset: AppWebp.appLetras,
          title: context.text.appLetras,
          subtitle: context.text.appLetrasDescription,
          app: App.letras),
    ];
  }
  // coverage:ignore-end
}
