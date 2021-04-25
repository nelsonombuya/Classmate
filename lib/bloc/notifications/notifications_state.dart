part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class ShowSnackBar extends NotificationsState {
  const ShowSnackBar(this.message, {this.title, this.notificationType});
  final NotificationType notificationType;
  final String message, title;

  @override
  List<Object> get props => [title, message, notificationType];
}

class ShowDialogBox extends NotificationsState {
  const ShowDialogBox(
    this.message, {
    this.title,
    this.descriptionIcon,
    this.notificationType,
    this.positiveActionIcon,
    this.positiveActionLabel,
    this.positiveActionOnPressed,
    this.negativeActionLabel,
    this.negativeActionOnPressed,
  });

  final NotificationType notificationType;
  final String message, title, positiveActionLabel, negativeActionLabel;
  final IconData positiveActionIcon, descriptionIcon;
  final Function positiveActionOnPressed, negativeActionOnPressed;

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

class Reset extends NotificationsState {}
