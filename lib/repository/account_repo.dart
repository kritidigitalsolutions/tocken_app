import 'package:token_app/data/network/network_api_service.dart';
import 'package:token_app/model/request_model/account/feedback_req_model.dart';
import 'package:token_app/resources/app_url.dart';

class AccountRepo {
  final _api = NetworkApiService();

  // Feedback

  Future<void> postFeedback(FeedbackReqModel model) async {
    try {
      await _api.postApi(AppUrl.feedback, model.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
