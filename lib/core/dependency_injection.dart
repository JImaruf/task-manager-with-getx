import 'package:get/get.dart';
import 'package:task_manager_with_getx/controllers/update_profile_controller.dart';

import '../controllers/add_new_task_controller.dart';
import '../controllers/auth/login_controller.dart';
import '../controllers/auth/otp_send_controller.dart';
import '../controllers/auth/otp_verification_controller.dart';
import '../controllers/auth/reset_password_controller.dart';
import '../controllers/auth/signup_controller.dart';
import '../controllers/auth/user_controller.dart';
import '../controllers/cancelled_task_controller.dart';
import '../controllers/complete_task_controller.dart';
import '../controllers/in_progress_task_controller.dart';
import '../controllers/internet_connection_controller.dart';
import '../controllers/main_bottom_bar_controller.dart';
import '../controllers/new_task_controller.dart';


class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => SignupController(), fenix: true);
    Get.lazyPut(() => OtpSendController(), fenix: true);
    Get.lazyPut(() => OtpVerificationController(), fenix: true);
    Get.lazyPut(() => ResetPasswordController(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => InternetConnectionController(), fenix: true);
    Get.lazyPut(() => MainBottomBarController(), fenix: true);
    Get.lazyPut(() => UpdateProfileController(), fenix: true);
    Get.lazyPut(() => NewTaskController(), fenix: true);
    Get.lazyPut(() => CompleteTaskController(), fenix: true);
    Get.lazyPut(() => AddNewTaskController(), fenix: true);
    Get.lazyPut(() => CancelledTaskController(), fenix: true);
    Get.lazyPut(() => InProgressTaskController(), fenix: true);
  }
}
