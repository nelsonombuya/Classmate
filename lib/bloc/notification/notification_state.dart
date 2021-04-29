part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  final String message;

  const NotificationState(this.message);

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationState {
  NotificationsInitial() : super('Notifications initialized');
}

class ShowSnackBar extends NotificationState {
  const ShowSnackBar(
    this.message, {
    this.title,
    this.notificationType,
  }) : super(message);

  final String message;
  final String? title;
  final NotificationType? notificationType;

  @override
  List<Object> get props => [message];
}

class ShowDialogBox extends NotificationState {
  const ShowDialogBox(
    this.message, {
    this.title,
    required this.positiveActionLabel,
    required this.positiveActionOnPressed,
    required this.negativeActionLabel,
    required this.negativeActionOnPressed,
    this.descriptionIcon,
    this.notificationType,
    this.positiveActionIcon,
  }) : super(message);

  final String? title;
  final NotificationType? notificationType;
  final IconData? positiveActionIcon, descriptionIcon;
  final String message, positiveActionLabel, negativeActionLabel;
  final void Function() positiveActionOnPressed, negativeActionOnPressed;

  @override
  List<Object> get props => [
        message,
        positiveActionLabel,
        positiveActionOnPressed,
        negativeActionLabel,
        negativeActionOnPressed,
      ];
}
