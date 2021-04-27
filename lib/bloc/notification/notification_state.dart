part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationState {}

class ShowSnackBar extends NotificationState {
  const ShowSnackBar({
    this.title,
    @required this.message,
    this.notificationType,
  });

  final String message, title;
  final NotificationType notificationType;

  @override
  List<Object> get props => [title, message, notificationType];
}

class ShowDialogBox extends NotificationState {
  const ShowDialogBox({
    @required this.title,
    @required this.message,
    @required this.positiveActionLabel,
    @required this.positiveActionOnPressed,
    @required this.negativeActionLabel,
    @required this.negativeActionOnPressed,
    this.descriptionIcon,
    this.notificationType,
    this.positiveActionIcon,
  });

  final NotificationType notificationType;
  final IconData positiveActionIcon, descriptionIcon;
  final Function positiveActionOnPressed, negativeActionOnPressed;
  final String message, title, positiveActionLabel, negativeActionLabel;

  @override
  List<Object> get props => [
        title,
        message,
        descriptionIcon,
        notificationType,
        positiveActionIcon,
        positiveActionLabel,
        positiveActionOnPressed,
        negativeActionLabel,
        negativeActionOnPressed,
      ];
}
