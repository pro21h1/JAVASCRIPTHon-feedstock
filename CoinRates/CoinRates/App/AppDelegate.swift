
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    var exchangeRatesHandler: BitcoinRateHandler?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UIApplication.shared.setMinimumBackgroundFetchInterval(60 * 60 * 24)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        window?.tintColor = .darkGray
        
        exchangeRatesHandler = BitcoinRateController(connection: RemoteConnection(), exchangeRateDataStore: ExchangeRateDataStoreDiskUserPrefs(currency: .EUR))
        let coinRatesViewController = CoinRatesTableViewController(exchangeRatesHandler: exchangeRatesHandler!)
        window?.rootViewController = UINavigationController(rootViewController: coinRatesViewController)
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        if backgroundTaskIdentifier == UIBackgroundTaskInvalid {
            backgroundTaskIdentifier = application.beginBackgroundTask {[weak self] in
                guard let strongSelf = self else { return }
                application.endBackgroundTask(strongSelf.backgroundTaskIdentifier)
                strongSelf.backgroundTaskIdentifier = UIBackgroundTaskInvalid
            }
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        if backgroundTaskIdentifier != UIBackgroundTaskInvalid {
            application.endBackgroundTask(self.backgroundTaskIdentifier)
        }
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        self.exchangeRatesHandler?.fetchRatesForEUR(completion: { result in
            DispatchQueue.main.async {
                completionHandler(.newData)
            }
        })
    }
}
