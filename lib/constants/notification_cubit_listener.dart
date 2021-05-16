import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/cubit/notification/notification_cubit.dart';
import '../presentation/common_widgets/custom_alerts.dart';
import '../presentation/common_widgets/custom_dialog.dart';
import '../presentation/common_widgets/custom_snack_bar.dart';

/// # Notification Cubit Listener
/// Contains the presets for the different kinds of notifications used in the app:
///   - Alerts
///   - SnackBar
///   - Dialog Box
/// * Check the Notifications Cubit for more info
/// ! Make sure Notifications Cubit is in the Global BLoC Providers
class NotificationCubitListener extends StatelessWidget {
  const NotificationCubitListener({
    Key? key,
    required Widget child,
  })   : _child = child,
        super(key: key);

  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationCubit, NotificationState>(
      listener: (context, state) {
        if (state is ShowAlert) {
          CustomAlert(
            state.message,
            notificationType: state.notificationType,
          );
        }

        if (state is ShowSnackBar) {
          CustomSnackBar(
            context,
            message: state.message,
            type: state.notificationType,
          );
        }

        if (state is ShowDialogBox) {
          CustomDialog(
            context,
            title: state.title,
            description: state.message,
            type: state.notificationType,
            descriptionIcon: state.descriptionIcon,
            positiveActionIcon: state.positiveActionIcon,
            positiveActionLabel: state.positiveActionLabel,
            positiveActionOnPressed: state.positiveActionOnPressed,
            negativeActionLabel: state.negativeActionLabel,
            negativeActionOnPressed: state.negativeActionOnPressed,
          );
        }
      },
      child: _child,
    );
  }
}
