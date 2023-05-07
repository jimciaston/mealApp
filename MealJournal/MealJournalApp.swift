//
//  MealJournalApp.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/2/22.
//app delegate

import SwiftUI
import CoreData
import Foundation
import Firebase
import Kingfisher
import UserNotifications
import FirebaseMessaging

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        //grab token
        let deviceToken:[String] = [fcmToken ?? ""]
        //save bad boy to firestore
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).getDocument { (document, error) in
                if let error = error {
                    print("Error checking for device token: \(error.localizedDescription)")
                    return
                }
                
                // If the document exists, the device token is already saved
                //token for Firestore messenger cloud
                if let data = document?.data(), let existingToken = data["token"] as? String {
                               print("Device token already saved")
                               return
                   }
                
                // If the document doesn't exist, save the device token to Firestore
                FirebaseManager.shared.firestore.collection("users").document(uid).setData(["token": deviceToken], merge: true) { (error) in
                    if let error = error {
                        print("Error saving device token: \(error.localizedDescription)")
                        return
                    }
                    
                    print("Device token saved")
                }
            }
    }
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo

    if let messageID = userInfo["gcm.message_id"] {
        print("Message ID: \(messageID)")
    }

    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([[.banner, .badge, .sound]])
  }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

    }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

    if let messageID = userInfo["gcm.message_id"] {
      print("Message ID from userNotificationCenter didReceive: \(messageID)")
    }

    print(userInfo)

    completionHandler()
  }
}


//must keep for firebase to run
class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        Messaging.messaging().delegate = self

        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        return true
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }
}

@main
struct MealJournalApp: App {
    let cache = ImageCache.default
        let cacheSizeLimit = 200 * 1024 * 1024 // 200MB
        
    @Environment(\.managedObjectContext) var managedObjectContext
    //fetch user journals
    
    //firebase connectivity help
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init(){
        cache.diskStorage.config.sizeLimit = UInt(UInt64(cacheSizeLimit))
        cache.calculateDiskStorageSize { result in
              switch result {
                  case .success(let size):
                      print("Current cache size: \(Double(size) / (1024 * 1024)) MB")
                  case .failure(let error):
                      print("Error retrieving cache size: \(error.localizedDescription)")
                  }
              }
        
    }
    @StateObject var calendarHelper = CalendarHelper()
    @StateObject var vm = DashboardLogic()
    @StateObject var mealEntrys = MealEntrys()
    @StateObject var userJournalController = UserJournalHelper()
    var body: some Scene {
        //load and ready coredata
        WindowGroup{
             ContentView()
                .environmentObject(vm)
                .environmentObject(mealEntrys)
                .environment(\.managedObjectContext, UserJournalHelper.persistentContainer.viewContext)
                .onAppear{
                    print(UIDevice.current.systemVersion)
                }
        }
    }
}
