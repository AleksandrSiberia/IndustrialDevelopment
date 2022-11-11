//
//  CoreDataCoordinator.swift
//  Novigation
//
//  Created by Александр Хмыров on 01.11.2022.
//

import Foundation
import CoreData



final class CoreDataCoordinator {




    private lazy var persistentContainer: NSPersistentContainer = {

        var persistentContainer = NSPersistentContainer(name: "CoreDadaModel")

        persistentContainer.loadPersistentStores { nsPersistentStoreDescription, error in

            if let error = error as NSError? {
                fatalError("\(error), \(error.userInfo)")
            }
        }
       persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        return persistentContainer
    }()




    private lazy var backgroundContext: NSManagedObjectContext = {
 //       backgroundContext.automaticallyMergesChangesFromParent = true
        return persistentContainer.newBackgroundContext()
    }()


    

    lazy var fetchedResultsControllerPostCoreData: NSFetchedResultsController<PostCoreData> = {

        let request = PostCoreData.fetchRequest()


        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]


        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.backgroundContext, sectionNameKeyPath: nil, cacheName: nil)


        return fetchResultController
    }()




    lazy var fetchedResultsControllerFoldersPostCoreData:
    NSFetchedResultsController<FoldersPostCoreData> = {

        let request = FoldersPostCoreData.fetchRequest()

        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        let fetchedResultsControllerFolderPostsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.backgroundContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsControllerFolderPostsController
    }()





    init() {

        self.performFetchFolderPostsCoreData()

        self.performFetchPostCoreData()


        if self.getFolderByName(nameFolder: "SavedPosts") == nil {
            self.appendFolder(name: "SavedPosts")
        }
        if self.getFolderByName(nameFolder: "AllPosts") == nil {
            self.appendFolder(name: "AllPosts")
        }
    }



    func getSavedPosts(nameFolder: String) {

        let folder = self.getFolderByName(nameFolder: nameFolder)

        self.fetchedResultsControllerPostCoreData.fetchRequest.predicate = NSPredicate(format: "relationFolder contains %@", folder!)

        self.performFetchPostCoreData()
    }




    func performFetchPostCoreData() {

        do {
            try self.fetchedResultsControllerPostCoreData.performFetch()
            print("🦴", self.fetchedResultsControllerPostCoreData.sections?.first?.objects?.count)
        }
        catch {
            print(error)
        }
    }




    func performFetchFolderPostsCoreData() {

        do {
            try self.fetchedResultsControllerFoldersPostCoreData.performFetch()
        }
        catch {
            print(error.localizedDescription)
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




    func appendFolder(name: String) {

        let folder = FoldersPostCoreData(context: self.backgroundContext
        )
        folder.name = name
        self.savePersistentContainerContext()
        self.performFetchFolderPostsCoreData()

    }




    func appendPost(author: String?, image: String?, likes: String?, text: String?, views: String?, folderName: String, completion: (String?) -> Void) {


        for postInCoreData in (self.fetchedResultsControllerPostCoreData.sections![0].objects) as! [PostCoreData] {

            if postInCoreData.text == text {
                completion("Этот пост уже сохранен")
                return
            }
        }

        let post = PostCoreData(context: self.backgroundContext)
        post.author = author
        post.image = image
        post.text = text
        post.likes = likes
        post.views = views

        let folder = self.getFolderByName(nameFolder: folderName)

        post.addToRelationFolder(folder!)

   //     post.relationFolder = [folder!]

        self.savePersistentContainerContext()
        self.performFetchPostCoreData()

    }



    func getFolderByName(nameFolder: String) -> FoldersPostCoreData? {


//        if self.getFolderByName(nameFolder: "SavedPosts") == nil {
//            self.appendFolder(name: "SavedPosts")
//        }
//        if self.getFolderByName(nameFolder: "AllPosts") == nil {
//            self.appendFolder(name: "AllPosts")
//        }


        let request = FoldersPostCoreData.fetchRequest()

        request.predicate = NSPredicate(format: "name == %@", nameFolder)

        do {
            let folder = try self.backgroundContext.fetch(request).first
            return folder
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }



    func deleteFolder(folder: FoldersPostCoreData) {


        self.backgroundContext.delete(folder)
        self.savePersistentContainerContext()
        self.performFetchFolderPostsCoreData()
    }



    func deletePost(post: PostCoreData) {

        self.backgroundContext.delete(post)
        self.savePersistentContainerContext()
        self.performFetchPostCoreData()
    }

}







//    func reloadFolders() {
//
//        let request = FoldersPostCoreData.fetchRequest()
//
//        do {
//
//            let folderBackgroundQueue = try self.backgroundContext.fetch(request)
//
//            self.folder = folderBackgroundQueue
//
////            DispatchQueue.main.async {
////                self.folder = folderBackgroundQueue
////                completionHandler(folderBackgroundQueue)
////            }
//        }
//        catch {
//            print(error.localizedDescription)
//        }
//    }




//    func reloadPosts(searchAuthor: String?) {
//
//        let request = PostCoreData.fetchRequest()
//
//        if searchAuthor != nil {
//
//            request.predicate = NSPredicate(format: "author contains[c] %@", searchAuthor!)
//        }
//
//        do {
//
//            let savedPosts = try self.backgroundContext.fetch(request)
//
//            self.savedPosts = savedPosts
//
////            DispatchQueue.main.async {
////                self.savedPosts = savedPosts
////                completionHandler(savedPosts)
////            }
//        }
//
//        catch {
//            print(error.localizedDescription)
//        }
//    }
