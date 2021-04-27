part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent({
    @required this.message,
    this.title,
    this.notificationType,
  });

  final String title;
  final String message;
  final NotificationType notificationType;

  @override
  List<Object> get props => [title, message, notificationType];
}

class NotificationsServiceStarted extends NotificationEvent {}

class SnackBarRequested extends NotificationEvent {
  const SnackBarRequested(this.message, {this.title, this.notificationType});
  final NotificationType notificationType;
  final String message, title;

  @override
  List<Object> get props => [title, message, notificationType];
}

class DialogBoxRequested extends NotificationEvent {
  const DialogBoxRequested(
    this.message, {
    this.title,
    this.descriptionIcon,
    this.notificationType,
    this.positiveActionIcon,
    this.positiveActionLabel,
    this.negativeActionLabel,
    this.positiveActionOnPressed,
    this.negativeActionOnPressed,
  });

  final NotificationType notificationType;
  final IconData descriptionIcon, positiveActionIcon;
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

class SignOutDialogBoxRequested extends NotificationEvent {
  const SignOutDialogBoxRequested(this.context);
  final BuildContext context;

  @override
  List<Object> get props => [context];
}
