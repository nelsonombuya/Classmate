part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class NotificationsServiceStarted extends NotificationsEvent {}

class SnackBarRequested extends NotificationsEvent {
  const SnackBarRequested(this.message, {this.title, this.notificationType});
  final NotificationType notificationType;
  final String message, title;

  @override
  List<Object> get props => [title, message, notificationType];
}

class DialogBoxRequested extends NotificationsEvent {
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

  final String message, title, positiveActionLabel, negativeActionLabel;
  final Function positiveActionOnPressed, negativeActionOnPressed;
  final IconData descriptionIcon, positiveActionIcon;
  final NotificationType notificationType;

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

class SignOutDialogBoxRequested extends NotificationsEvent {
  const SignOutDialogBoxRequested(this.context);
  final BuildContext context;

  @override
  List<Object> get props => [context];
}
