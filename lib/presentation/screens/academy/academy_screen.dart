import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/screens/academy/academy_bloc.dart';
import 'package:cifraclub/presentation/screens/academy/academy_state.dart';
import 'package:cifraclub/presentation/screens/academy/widgets/academy_screen_phone.dart';
import 'package:cifraclub/presentation/screens/academy/widgets/academy_screen_tablet.dart';
import 'package:cifraclub/presentation/widgets/device_type_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcademyScreen extends StatefulWidget {
  const AcademyScreen({super.key});

  @override
  State<AcademyScreen> createState() => _AcademyScreenState();
}

class _AcademyScreenState extends State<AcademyScreen> {
  late AcademyBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<AcademyBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.initInstructors();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AcademyBloc, AcademyState>(
      builder: (context, state) {
        if (state.instructors.isEmpty) {
          return Container();
        }
        final safeAreaTopOffset = MediaQuery.of(context).padding.top;
        return DeviceTypeBuilder(builder: (context, device) {
          if (device == DeviceType.tablet) {
            return AcademyScreenTablet(
              safeAreaTopOffset: safeAreaTopOffset,
              backgroundImagePath: AppWebp.academyBgTablet,
              instructors: state.instructors,
              isAcademyInstalled: state.isAcademyInstalled,
              openAppOrStore: bloc.openAppOrStore,
            );
          } else {
            return AcademyScreenPhone(
              safeAreaTopOffset: safeAreaTopOffset,
              backgroundImagePath: AppWebp.academyBg,
              instructors: state.instructors,
              isAcademyInstalled: state.isAcademyInstalled,
              openAppOrStore: bloc.openAppOrStore,
            );
          }
        });
      },
    );
  }
}
