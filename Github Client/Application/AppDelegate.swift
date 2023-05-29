import UIKit
import FirebaseCore
import Firebase
import FirebaseAuth

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init(idiom: .unspecified)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            print(components)
        }
        
        return true
    }
}
