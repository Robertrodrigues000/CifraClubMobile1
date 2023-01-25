import Foundation

class LoginCcidPlugin {
    static func createChannel(
        application: UIApplication,
        flutterViewController: FlutterViewController,
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?,
        flutterBinaryMessenger : FlutterBinaryMessenger
    ){
        
        let loginChannel = FlutterMethodChannel(name: "com.studiosol.flutter/login_ccid", binaryMessenger: flutterBinaryMessenger)
        loginChannel.setMethodCallHandler({ (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
                case "initializeCcid":
                    LogginCcid.sharedInstance.initialize(app: application, launchOptions: launchOptions, flutterChannel: loginChannel)
                    result(true)
                case "openLoginView":
                    LogginCcid.sharedInstance.showCCID(fromViewController: flutterViewController)
                    result("")
                case "logout":
                    LogginCcid.sharedInstance.logOut()
                    result("")
                case "getUserData":
                    do {
                        if let userData = LogginCcid.sharedInstance.getUserData() {
                            let jsonData = try JSONSerialization.data(withJSONObject: userData)
                            if let json = String(data: jsonData, encoding: .utf8) {
                                result(json)
                            }
                        } else {
                            result("")
                        }
                    } catch {
                        print("something went wrong with parsing json")
                        result("")
                    }
                case "getToken":
                    result(LogginCcid.sharedInstance.getUserToken())
                case "resendEmail":
                    LogginCcid.sharedInstance.resendEmail()
                    result("")
                case "refreshUserData":
                    LogginCcid.sharedInstance.refreshUserData()
                    result("")
                case "addRegId":
                    if let userData = LogginCcid.sharedInstance.getUserData() {
                        guard let userId = userData["userID"] as? Int,
                              userId != 0 else {
                            result("")
                            return
                        }
                        
                        LogginCcid.sharedInstance.addRegId(userId: userId) { (success, data) in
                            result(success)
                        }
                        
                    } else {
                        result("")
                    }
                case "isUserLoggedIn":
                    result(LogginCcid.sharedInstance.isLoggedIn())
                default:
                    result("")
            }
        })
    }
}
