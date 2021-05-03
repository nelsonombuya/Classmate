import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../bloc/notification/notification_bloc.dart';

class CustomAlert {
  final NotificationType? notificationType;
  final String message;

  CustomAlert(this.message, {this.notificationType}) {
    _show();
  }
  _show() {
    switch (notificationType) {
      case NotificationType.Info:
        return EasyLoading.showInfo(message);
      case NotificationType.Loading:
        return EasyLoading.show(
          dismissOnTap: false,
          status: message,
          maskType: EasyLoadingMaskType.black,
        );
      case NotificationType.Success:
        return EasyLoading.showSuccess(message);
      case NotificationType.Danger:
        return EasyLoading.showError(message);
      default:
        return EasyLoading.showToast(message);
    }
  }
}
