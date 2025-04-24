import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commercy/core/utils/dio_helper.dart';
import 'package:e_commercy/core/utils/service_locator.dart';
import 'package:e_commercy/core/utils/strings.dart';
import 'package:e_commercy/features/verification/data/repos/verification_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class VerificationRepoImpl extends VerificationRepo {
  VerificationRepoImpl();
  final DioHelper dioHelper = getIt.get<DioHelper>();

  @override
  Future<Either<String, void>> sendVerificationCode({
    required String recepientEmail,
    String? recepientName,
    required String verificationCode,
  }) async {
    try {
      final Response response = await dioHelper.post(
        endPoint: Strings.sendGridEndPoint,
        data: {
          "personalizations": [
            {
              "to": [
                {"email": recepientEmail, "name": recepientName ?? ""},
              ],
            },
          ],
          "from": {"email": "elnawawyseif@gmail.com"},
          "subject": "Verifying ECommercy account",
          "content": [
            {
              "type": "text/html",
              "value":
                  "<html><head><style>body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px; } .container { background-color: #fff; padding: 20px; border-radius: 8px; max-width: 500px; margin: auto; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); } h2 { color: #333; } p { font-size: 16px; color: #555; } .otp { font-size: 18px; font-weight: bold; color: #007BFF; }</style></head><body><div class='container'><h2>Hello Seif,</h2><p>Welcome to ECommercy! Your one-time password (OTP) is:</p><p class='otp'>$verificationCode</p><p>Please use this code to complete your verification.</p><p>Best regards,<br>ECommercy Team</p></div></body></html>",
            },
          ],
        },
      );
      return Right(null);
    } catch (e) {
      debugPrint(e.toString());

      return Left('Opps! Unable to send email now, please try again later');
    }
  }

  @override
  Future<void> verifyEmail() async {
    try {
      await getIt
          .get<FirebaseFirestore>()
          .collection(Strings.usersCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({Strings.isVerified: true});
    } catch (e) {
      if (kDebugMode) {
        print('unable to verify user');
      }
    }
  }

  @override
  Future<void> updateAccountToSeller() async {
    try {
      await getIt
          .get<FirebaseFirestore>()
          .collection(Strings.usersCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({Strings.role: Strings.seller});
    } catch (e) {
      debugPrint('unable to verify user');
    }
  }
}
