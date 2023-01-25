import Foundation
import Firebase
import LoginCCID

class LogginCcid: NSObject{
    private let ccid = CCID.shared
    
    public static let sharedInstance: LogginCcid = LogginCcid()

    private static let privacyPolicyUrl = URLComponents(string: "https://m.cifraclub.com.br/politica-privacidade.html")!
    private static let termsOfUseUrl = URLComponents(string: "https://m.cifraclub.com.br/aviso-legal.html")!
    
    private var presentingViewController: UIViewController?
    private var flutterMethodChannel: FlutterMethodChannel?
    
    private override init() { }
    
    private func getLoginTheme() -> Theme {
        let patternImage = UIImage(named: "login_bg")!
        let backgroundImagePattern = UIColor(patternImage: patternImage)
        
        let orange = UIColor.orangeCifraClub
        let highlighted = UIColor.orangeHighlighted
        
        let backgroundView = LoginBackgroundView()
        backgroundView.patternView.backgroundColor = backgroundImagePattern.withAlphaComponent(0.1)
        
        let gradient = CAGradientLayer()
        var frame = UIScreen.main.bounds
        if frame.size.height > frame.size.width {
            frame.size.width = frame.size.height
        } else {
            frame.size.height = frame.size.width
        }
        gradient.frame = frame
        gradient.colors = [UIColor.gray26.cgColor, UIColor.gray2A.cgColor]
        backgroundView.layer.insertSublayer(gradient, at: 0)
        
        let logoImage = UIImage(named: "login_logo")!
        let theme = Theme(mainColor: orange,
                          highlightColor: highlighted,
                          logo: logoImage,
                          backgroundView: backgroundView,
                          closeButtonHidden: false,
                          navigationBarTint: .black,
                          statusBarStyle: .default,
                          enableLoginWithGoogle: true,
                          enableLoginWithFacebook: true,
                          enableLoginWithApple: true)
        return theme
    }
    
    func initialize(app: UIApplication, launchOptions options: [UIApplication.LaunchOptionsKey : Any]?, flutterChannel: FlutterMethodChannel) {
        flutterMethodChannel = flutterChannel
        
        var params: [ExternalAuthParameter: Any?] = [:]
        params[.googleClientID] = "1046541148461-6ufda75hpccojg4f2o2qasgthgn8sda0.apps.googleusercontent.com"
        params[.googleServerClientID] = "1046541148461-csqnsr99di77j72am8gpr0grjc4o6n0u.apps.googleusercontent.com"
        params[.facebookApplication] = app
        params[.facebookLaunchOptions] = options
        params[.facebookPermissions] = ["public_profile", "email"]
        
        ccid.initialize(appID: .CIFRA_CLUB, theme: getLoginTheme(), eventLoggers: [], externalAuthParams: params, loginViewControllerDelegate: nil)
        ccid.setPrivacyPolicyURL(LocaleHelper.getLocalized(url: Self.privacyPolicyUrl))
        ccid.setTermsOfUseURL(LocaleHelper.getLocalized(url: Self.termsOfUseUrl))
        ccid.registerListener(self, key: String(describing: LogginCcid.self))
    }
    
    func showCCID(fromViewController viewController:UIViewController) {
        presentingViewController = viewController
        ccid.showCCIDViewController(fromViewController: viewController)
    }
    
    func application(_ app: UIApplication, open url: URL, sourceApplication source: String?, annotation: Any) -> Bool {
        return ccid.application(app, open: url, sourceApplication: source, annotation: annotation)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return ccid.application(app, open: url, options: options)
    }
    
    func isLoggedIn() -> Bool {
        return ccid.getAuthToken() != nil
    }
    
    func getUserData() -> NSDictionary? {
        return parseUserData(ccid.getUserData())
    }
    
    func getUserToken() -> String? {
        return ccid.getAuthToken()
    }
    
    func logOut() {
        ccid.logOut()
    }
    
    func resendEmail() {
        ccid.resendConfirmationEmail { (success, error) in }
    }
    
    func refreshUserData() {
        ccid.refreshUserData()
    }
    
    private func parseUserData(_ userData: UserData) -> NSDictionary? {
        
        let dictionary: NSMutableDictionary = [:]
        dictionary.setValue(userData.userID, forKey: "userID")
        dictionary.setValue(userData.name, forKey: "name")
        dictionary.setValue(userData.email, forKey: "email")
        dictionary.setValue(userData.avatarURL, forKey: "avatarURL")
        dictionary.setValue(userData.cityID, forKey: "cityID")
        dictionary.setValue(userData.cityName, forKey: "cityName")
        dictionary.setValue(userData.countryID, forKey: "countryID")
        dictionary.setValue(userData.countryName, forKey: "countryName")
        dictionary.setValue(userData.id, forKey: "id")
        dictionary.setValue(userData.stateID, forKey: "stateID")
        dictionary.setValue(userData.stateInitials, forKey: "stateInitials")
        dictionary.setValue(userData.verified, forKey: "verified")
        return dictionary
    }
    
    
}

extension LogginCcid: AuthListener {
    func onLoginCompleted(loginMethod: AuthProviderType) {
        flutterMethodChannel?.invokeMethod("onLoginComplete", arguments: [
            "method": loginMethod.rawValue
        ])
    }
    
    func onLogoutCompleted() {
        flutterMethodChannel?.invokeMethod("onLogoutComplete", arguments: nil)
    }
    
    func onUserDataUpdated(_ data: UserData) {
        flutterMethodChannel?.invokeMethod("onUserDataChanged", arguments: nil)
    }
}

extension LogginCcid {
    
    func addRegId(userId: Int, completion: @escaping (Bool,[String:Any]?) -> Void) {
        
        Installations.installations().installationID { (id, error) in
            if let error = error {
                print("Error fetching id: \(error)")
                return
            }
            guard let instanceId = id else { return }
            
            Messaging.messaging().token { (token, error) in
                if let error = error {
                    print("Error fetching token: \(error)")
                    return
                }
                guard let token = token else { return }
                self.ccid.addRegId(userId: userId, token: token, instanceId: instanceId) { (success, data) in
                    completion(success, data)
                }
            }
        }
    }
    
}
