//
//  CoreDataCoordinator.swift
//  Novigation
//
//  Created by Александр Хмыров on 01.11.2022.
//

import Foundation
import CoreData



final class CoreDataCoordinator {



    var searchNameAuthor: String?

    var fetchedResultsControllerPostCoreData: NSFetchedResultsController<PostCoreData>?

    var fetchedResultsControllerFoldersPostCoreData:
    NSFetchedResultsController<FoldersPostCoreData>?



    private lazy var persistentContainer: NSPersistentContainer = {

        var persistentContainer = NSPersistentContainer(name: "CoreDadaModel")

        persistentContainer.loadPersistentStores { nsPersistentStoreDescription, error in

            if let error = error as NSError? {
                fatalError("\(error), \(error.userInfo)")
            }
        }
        return persistentContainer
    }()



    private lazy var backgroundContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()



    init() {

        self.createFetchedResultsControllerFolderPostsCoreData()

        self.performFetchFolderPostsCoreData()

        self.createFetchedResultsControllerPostCoreData()

        self.performFetchPostCoreData()


        if self.fetchedResultsControllerFoldersPostCoreData?.sections?[0].objects?.isEmpty == true {
                self.appendFolder(name: "SavedPosts")
            }
        }





    func performFetchPostCoreData() {

        do {
            try self.fetchedResultsControllerPostCoreData?.performFetch()
        }
        catch {
            print(error)
        }
    }




    func performFetchFolderPostsCoreData() {

        do {
            try self.fetchedResultsControllerFoldersPostCoreData?.performFetch()
        }
        catch {
            print(error.localizedDescription)
        }
    }


    func createFetchedResultsControllerPostCoreData() {

        let request = PostCoreData.fetchRequest()

        if self.searchNameAuthor != nil {
            request.predicate = NSPredicate(format: "author contains[c] %@", searchNameAuthor!)
        }

        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]

        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.backgroundContext, sectionNameKeyPath: nil, cacheName: nil)

        self.fetchedResultsControllerPostCoreData = fetchResultController
    }




    func createFetchedResultsControllerFolderPostsCoreData() {

        let request = FoldersPostCoreData.fetchRequest()

        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        let fetchedResultsControllerFolderPostsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.backgroundContext, sectionNameKeyPath: nil, cacheName: nil)

        self.fetchedResultsControllerFoldersPostCoreData = fetchedResultsControllerFolderPostsController
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




    func appendPost(author: String?, image: String?, likes: String?, text: String?, views: String?, folder: FoldersPostCoreData?, completion: (String?) -> Void) {

        var folderObject: FoldersPostCoreData

        if folder == nil {
            folderObject = self.fetchedResultsControllerFoldersPostCoreData?.sections?.first?.objects?.first as! FoldersPostCoreData

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

        for postInCoreData in (self.fetchedResultsControllerPostCoreData?.sections![0].objects) as! [PostCoreData] {

            if postInCoreData.text == post.text {
                self.deletePost(post: post)
                completion("Этот пост уже сохранен")
            }
        }
        self.savePersistentContainerContext()
        self.performFetchPostCoreData()

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
