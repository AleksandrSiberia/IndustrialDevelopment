//
//  LocalNotificationsService.swift
//  Novigation
//
//  Created by Александр Хмыров on 29.12.2022.
//

import Foundation
import UserNotifications
import UserNotificationsUI




class LocalNotificationsService: NSObject {


    let unCenter = UNUserNotificationCenter.current()


    func registerForLatestUpdatesIfPossible(completionHandler: @escaping (String, LocalNotificationsService?) -> Void) {

        self.registerUpdatesCategory()

        self.unCenter.requestAuthorization(options: [.sound, .badge ] ) { success, error in

            if let error {

                print(error.localizedDescription)
                completionHandler(error.localizedDescription, nil)
            }

            else {

                print(String(success))
                completionHandler(String(success), self)

                self.addNotificationRequest(timer: false)

            }
        }
    }



    private func addNotificationRequest(timer: Bool) {

        let content = UNMutableNotificationContent()

        content.badge = 1
        content.title = "Напоменаем"
        content.body = "Посмотрите последние обновления"
        content.categoryIdentifier = "updates"

        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 00


        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        if timer {

            let triggerTimer = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triggerTimer)

            self.unCenter.add(request)

        }

        else {

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger )

            self.unCenter.add(request)

        }
    }



    func registerUpdatesCategory() {

        self.unCenter.delegate = self

        let actionButtonRemove = UNNotificationAction(identifier: "actionButtonRemove", title: "Отключить это уведомление", options: .destructive)

        let actionButtonRepeat = UNNotificationAction(identifier: "actionButtonRepeat", title: "Напомнить через 5 секунд")

        let category = UNNotificationCategory(identifier: "updates", actions: [actionButtonRemove, actionButtonRepeat ], intentIdentifiers: [])

        self.unCenter.setNotificationCategories([category])
    }

}


extension LocalNotificationsService: UNUserNotificationCenterDelegate {



    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        switch response.actionIdentifier {

        case "actionButtonRemove":
            self.unCenter.removePendingNotificationRequests(withIdentifiers: [response.notification.request.identifier])

        case "actionButtonRepeat":
            self.addNotificationRequest(timer: true)

        default:
            print("кнопка дефолт")
        }

        completionHandler()
    }
}


