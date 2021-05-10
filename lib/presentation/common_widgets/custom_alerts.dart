import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../cubit/notification/notification_cubit.dart';

/// ### Custom Alerts
/// ! Depends on EasyLoading Package
class CustomAlert {
  CustomAlert(String message, {NotificationType? notificationType}) {
    switch (notificationType) {
      case NotificationType.Loading:
        EasyLoading.show(
          status: message,
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        break;

      case NotificationType.Info:
        EasyLoading.showInfo(message);
        break;

      case NotificationType.Danger:
        EasyLoading.showError(message);
        break;

      case NotificationType.Success:
        EasyLoading.showSuccess(message);
        break;

      default:
        EasyLoading.showToast(message);
        break;
    }
  }
}
