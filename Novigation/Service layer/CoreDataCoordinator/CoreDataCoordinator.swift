//
//  CoreDataCoordinator.swift
//  Novigation
//
//  Created by Александр Хмыров on 01.11.2022.
//

import Foundation
import CoreData



final class CoreDataCoordinator {



    static var shared = CoreDataCoordinator()

    lazy var folder: [FoldersPostCoreData] = []

    var savedPosts: [PostCoreData] = []





    lazy var persistentContainer: NSPersistentContainer = {

        var persistentContainer = NSPersistentContainer(name: "CoreDadaModel")

        persistentContainer.loadPersistentStores { nsPersistentStoreDescription, error in

            if let error = error as NSError? {
                fatalError("\(error), \(error.userInfo)")
            }
        }
        return persistentContainer
    }()




    lazy var backgroundContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()



    private init() {
        self.reloadFolders()
        self.reloadPosts()

        if  self.folder == [] {
                self.appendFolder(name: "SavedPosts")
            }

        }




    func savePersistentContainerContext() {

//        if  self.persistentContainer.viewContext.hasChanges {
//
//            do {
//                try persistentContainer.viewContext.save()
//            }
//            catch {
//                let nsError = error as NSError?
//                fatalError("Error viewContext.save = \(String(describing: nsError)), \(String(describing: nsError?.userInfo))")
//            }
//        }

        if self.backgroundContext.hasChanges {

            do {
                try self.backgroundContext.save()
            }
            catch {
                if let error = error as NSError? {
                    print("Error backgroundContext.save = \(error), \(error.userInfo)")
                }
            }
        }
    }




    func reloadFolders() {

        
        let request = FoldersPostCoreData.fetchRequest()

        do {

            let folderBackgroundQueue = try self.backgroundContext.fetch(request)

            self.folder = folderBackgroundQueue


//            DispatchQueue.main.async {
//                self.folder = folderBackgroundQueue
//                completionHandler(folderBackgroundQueue)
//            }
        }
        catch {
            print(error.localizedDescription)


        }
    }




    func reloadPosts() {

        let request = PostCoreData.fetchRequest()


        // сортировка
        //   request.sortDescriptors = [
        //   NSSortDescriptor(key: "likes", ascending: true)
        //    ]

        // для фильтрации постов
       // request.predicate

       // получить 12 элементов
       // request.fetchLimit = 12
        // начиная с 11
        // request.fetchOffset = 11

        // оптимизация это загружаем сохраняем изменяем в бэкграунд контексте а в комплишени обрисовываем в главном



        do {

            let savedPosts = try self.backgroundContext.fetch(request)
            self.savedPosts = savedPosts

//            DispatchQueue.main.async {
//                self.savedPosts = savedPosts
//                completionHandler(savedPosts)
//            }
        }
        catch {
            print(error.localizedDescription)
        }
    }




    func appendFolder(name: String) {

        let folder = FoldersPostCoreData(context: self.backgroundContext
        )
        folder.name = name
        self.savePersistentContainerContext()
        self.reloadFolders()
    }




    func appendPost(author: String?, image: String?, likes: String?, text: String?, views: String?, folder: FoldersPostCoreData?, completion: (String?) -> Void) {

        var folderObject: FoldersPostCoreData

        if folder == nil {
            folderObject = self.folder[0]
        }
        else {
            folderObject = folder!
        }

        let post = PostCoreData(context: self.backgroundContext)
        post.author = author
        post.image = image
        post.text = text
        post.likes = likes
        post.views = views


        post.relationFolder = folderObject

        for postInCoreData in self.savedPosts {

            if postInCoreData.text == post.text {
                self.deletePost(post: post)
                completion("Этот пост уже сохранен")
            }
        }
        self.savePersistentContainerContext()
        self.reloadPosts()


    }



    func deleteFolder(folder: FoldersPostCoreData) {


        self.backgroundContext.delete(folder)
        self.savePersistentContainerContext()
        self.reloadFolders()
    }



    func deletePost(post: PostCoreData) {

        self.backgroundContext.delete(post)
        self.savePersistentContainerContext()
        self.reloadPosts()
    }

}

