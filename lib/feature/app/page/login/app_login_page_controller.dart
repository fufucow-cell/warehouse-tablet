part of 'app_login_page.dart';

class AppLoginPageController extends BasePageController {
  // MARK: - Properties

  final _model = AppLoginPageModel();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool get isPasswordVisible =>
      _model.isPasswordVisible.value;
  bool get isButtonEnabled => _model.isButtonEnabled.value;

  // MARK: - Init

  AppLoginPageController() {
    super.init(isCallApiWhenInit: false);
    emailController.text = 'cow@gmail.com';
    passwordController.text = 'abc123';
    _initTextFieldListeners();
    _updateButtonStates();
  }

  // MARK: - Override Method

  @override
  void onClose() {
    emailController.removeListener(_updateButtonStates);
    passwordController.removeListener(_updateButtonStates);
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  @override
  Future<void> apiProcessing() async {
    UserLoginResponseModel? response;

    if (_model.isLoginProcess) {
      response =
          await ApiUtil.sendRequest<UserLoginResponseModel>(
        EnumApiInfo.userLogin,
        requestModel: UserLoginRequestModel(
          email: emailController.text,
          password: passwordController.text,
        ),
        fromJson: UserLoginResponseModel.fromJson,
      );
    } else {
      response =
          await ApiUtil.sendRequest<UserLoginResponseModel>(
        EnumApiInfo.userRegister,
        requestModel: UserLoginRequestModel(
          email: emailController.text,
          password: passwordController.text,
        ),
        fromJson: UserLoginResponseModel.fromJson,
      );
    }

    AppService.instance.updateUserLoginData(response);
  }

  @override
  Future<void> apiProcessDone() async {
    if (AppService.instance.getUserData != null) {
      await routerHandle(
        EnumAppLoginPageRoute.goToMainPage,
      );
    }
  }

  @override
  Future<void> apiProcessFail(
    ApiException error, {
    bool isFirstLoad = false,
  }) async {
    if (_model.isLoginProcess) {
      await routerHandle(
        EnumAppLoginPageRoute.showLoginFail,
        data: error.message,
      );
    } else {
      await routerHandle(
        EnumAppLoginPageRoute.showRegisterFail,
        data: error.message,
      );
    }
  }

  // MARK: - Private Method

  void _prepareToCallApi({required bool isLogin}) {
    if (_model.isButtonEnabled.value) {
      _model.isLoginProcess = isLogin;
      startApiProcess();
    }
  }

  void _togglePasswordVisibility() {
    _model.isPasswordVisible.value =
        !_model.isPasswordVisible.value;
    update();
  }

  void _initTextFieldListeners() {
    emailController.addListener(_updateButtonStates);
    passwordController.addListener(_updateButtonStates);
  }

  void _updateButtonStates() {
    final isValid = emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
    _model.isButtonEnabled.value = isValid;
  }
}
