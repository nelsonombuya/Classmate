part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent(
    this.message, {
    this.title,
    this.notificationType,
  });

  final String message;
  final String? title;
  final NotificationType? notificationType;

  @override
  List<Object> get props => [message];
}

class SnackBarRequested extends NotificationEvent {
  final String message;
  final String? title;
  final NotificationType? notificationType;

  const SnackBarRequested(this.message, {this.title, this.notificationType})
      : super(message);

  @override
  List<Object> get props => [message];
}

class DialogBoxRequested extends NotificationEvent {
  const DialogBoxRequested(
    this.message, {
    this.title,
    this.descriptionIcon,
    this.notificationType,
    this.positiveActionIcon,
    required this.positiveActionLabel,
    required this.negativeActionLabel,
    required this.positiveActionOnPressed,
    required this.negativeActionOnPressed,
  }) : super(message);

  final String? title;
  final NotificationType? notificationType;
  final IconData? descriptionIcon, positiveActionIcon;
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

class AlertRequested extends NotificationEvent {
  final String message;
  final NotificationType? notificationType;

  const AlertRequested(this.message, {this.notificationType}) : super(message);

  @override
  List<Object> get props => [message];
}

class SignOutDialogBoxRequested extends NotificationEvent {
  final BuildContext context;

  const SignOutDialogBoxRequested(this.context)
      : super('Are you sure you want to sign out?');

  @override
  List<Object> get props => [context];
}

class DeleteDialogBoxRequested extends NotificationEvent {
  final BuildContext context;
  final Function deleteFunction;

  const DeleteDialogBoxRequested(this.context, this.deleteFunction)
      : super('Are you sure you want to delete this?');

  @override
  List<Object> get props => [context, deleteFunction];
}
