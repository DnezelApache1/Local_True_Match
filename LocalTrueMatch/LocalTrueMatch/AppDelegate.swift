import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let LocalTrueMatchNavigationController = UINavigationController(rootViewController: LocalTrueMatchLoadingViewController())
        self.window?.rootViewController = LocalTrueMatchNavigationController
        self.window?.makeKeyAndVisible()
        return true
    }
}
