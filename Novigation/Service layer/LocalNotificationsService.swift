//
//  LocalNotificationsService.swift
//  Novigation
//
//  Created by Александр Хмыров on 29.12.2022.
//

import Foundation
import UserNotifications
import UserNotificationsUI




class LocalNotificationsService {


    let unCenter = UNUserNotificationCenter.current()


    func registerForLatestUpdatesIfPossible(completionHandler: @escaping (String, LocalNotificationsService?) -> Void) {

        self.unCenter.requestAuthorization(options: [.sound, .badge, .provisional ] ) { success, error in

            if let error {

                print(error.localizedDescription)
                completionHandler(error.localizedDescription, nil)
            }

            else {

                    print(String(success))
                    completionHandler(String(success), self)

                    let content = UNMutableNotificationContent()

                    content.badge = 1
                    content.title = "Напоменаем"
                    content.body = "Посмотрите последние обновления"

                    var dateComponents = DateComponents()
                    dateComponents.hour = 19
                    dateComponents.minute = 00


                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

              //      let triggerTwo = UNTimeIntervalNotificationTrigger(timeInterval: 9, repeats: false)

                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger )

                    self.unCenter.add(request)


            }
        }
    }
}
