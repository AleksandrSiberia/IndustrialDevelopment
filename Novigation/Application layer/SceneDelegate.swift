//
//  SceneDelegate.swift
//  Novigation
//
//  Created by Александр Хмыров on 22.05.2022.
//

import UIKit
import FirebaseAuth
import KeychainSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var rootCoordinator: AppCoordinatorProtocol?
    var appConfiguration: String?

    var keychainSwift = KeychainSwift()
    



//    var premium: Bool {
//        get {
//            return UserDefaults.standard.object(forKey: "premium") as! String == UIDevice.current.identifierForVendor!.uuidString
//        }
//        set {
//            let uIDevice = UIDevice.current.identifierForVendor?.uuidString
//            if newValue == true {
//                UserDefaults.standard.set(uIDevice, forKey: "premium")
//            }
//            else {
//                UserDefaults.standard.removeObject(forKey: "premium")
//            }
//            UserDefaults.standard.synchronize()
//        }
//    }




    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        self.appConfiguration = AppConfiguration.url

   //     keychainSwift.delete("realmKey")


        if keychainSwift.getData("realmKey") == nil {
            self.keychainSwift.set(RealmService.shared.setRealmKey(), forKey: "realmKey")
        }

        
   //     ManagerDataResidentsPlanet.loadResidentsPlanet()


        
        // Код ошибки без интернета:
//         2022-10-10 17:52:13.115317+0800 Novigation[58973:2094250] Connection 1: received failure notification
//        2022-10-10 17:52:13.115458+0800 Novigation[58973:2094250] Connection 1: failed to connect 1:50, reason -1
//        2022-10-10 17:52:13.115512+0800 Novigation[58973:2094250] Connection 1: encountered error(1:50)
//        2022-10-10 17:52:13.116249+0800 Novigation[58973:2094248] Task <B0876AE3-4DF3-40E4-888F-00CD90C24E7D>.<1> HTTP load failed, 0/0 bytes (error code: -1009 [1:50])
//        2022-10-10 17:52:13.118287+0800 Novigation[58973:2094250] Task <B0876AE3-4DF3-40E4-888F-00CD90C24E7D>.<1> finished with error [-1009] Error Domain=NSURLErrorDomain Code=-1009 "The Internet connection appears to be offline." UserInfo={_kCFStreamErrorCodeKey=50, NSUnderlyingError=0x60000385e5e0 {Error Domain=kCFErrorDomainCFNetwork Code=-1009 "(null)" UserInfo={_NSURLErrorNWPathKey=unsatisfied (No network route), _kCFStreamErrorCodeKey=50, _kCFStreamErrorDomainKey=1}}, _NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <B0876AE3-4DF3-40E4-888F-00CD90C24E7D>.<1>, _NSURLErrorRelatedURLSessionTaskErrorKey=(
//            "LocalDataTask <B0876AE3-4DF3-40E4-888F-00CD90C24E7D>.<1>"
//        ), NSLocalizedDescription=The Internet connection appears to be offline., NSErrorFailingURLStringKey=https://swapi.dev/api/people/2, NSErrorFailingURLKey=https://swapi.dev/api/people/2, _kCFStreamErrorDomainKey=1}
//        The Internet connection appears to be offline.
//        Status code != 200, statusCode = nil
//        data = nil

//        let queue = DispatchQueue(label: "serial")
//        queue.async {
//            NetworkService.request(for: self.appConfiguration!) { people in
//                if people != nil {
//                    print(people!)
//                            }
//            }
//        }
        


        guard let windowScene = (scene as? UIWindowScene) else { return }

        self.window = UIWindow.init(windowScene: windowScene)

        let tabBarController = UITabBarController()

        let coordinator = RootCoordinator(transitionHandler: tabBarController)
        self.rootCoordinator = coordinator


        self.window?.rootViewController = coordinator.start()
        self.window?.makeKeyAndVisible()

    }




    func sceneDidDisconnect(_ scene: UIScene) {

        do {
            try Auth.auth().signOut()
        }
        catch {
            print(error)
        }

        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

