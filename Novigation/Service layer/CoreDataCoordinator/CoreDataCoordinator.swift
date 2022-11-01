//
//  CoreDataCoordinator.swift
//  Novigation
//
//  Created by Александр Хмыров on 01.11.2022.
//

import Foundation
import CoreData

class CoreDataCoordinator {



    lazy var persistentCoreDataContainer: NSPersistentCloudKitContainer = {
        var persistentContainer = NSPersistentCloudKitContainer(name: "PostsCoreDadaModel")
        persistentContainer.loadPersistentStores { nsPersistentStoreDescription, error in

            if let error = error as NSError? {
                fatalError("\(error), \(error.userInfo)")
            }
        }
        return persistentContainer
    }()




    func safeCoreDataContext() {

        let context = persistentCoreDataContainer.viewContext

        do {
            try context.save()
        }
        catch {
            let nsError = error as NSError?
            fatalError("nsCoreDataError \(String(describing: nsError)), \(String(describing: nsError?.userInfo))")
        }
    }


}

