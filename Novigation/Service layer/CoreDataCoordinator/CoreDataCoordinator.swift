//
//  CoreDataCoordinator.swift
//  Novigation
//
//  Created by Александр Хмыров on 01.11.2022.
//

import Foundation
import CoreData




final class CoreDataCoordinator: CoreDataCoordinatorProtocol {




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




    lazy var backgroundContext: NSManagedObjectContext = {
        //       backgroundContext.automaticallyMergesChangesFromParent = true
        return persistentContainer.newBackgroundContext()
    }()





    lazy var fetchedResultsControllerPostCoreData: NSFetchedResultsController<PostCoreData>? = {

        let request = PostCoreData.fetchRequest()

        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]

        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.backgroundContext, sectionNameKeyPath: nil, cacheName: nil)

        return fetchResultController
    }()




    init() {

        if self.getFolderByName(nameFolder: "SavedPosts") == nil {
                    self.appendFolder(name: "SavedPosts")
                }
                if self.getFolderByName(nameFolder: "AllPosts") == nil {
                    self.appendFolder(name: "AllPosts")
                }

        self.performFetchPostCoreData()

    }



    func getPosts(nameFolder: String) {

        let folder = self.getFolderByName(nameFolder: nameFolder)

        
        self.fetchedResultsControllerPostCoreData?.fetchRequest.predicate = NSPredicate(format: "relationFolder contains %@", folder!)

        self.performFetchPostCoreData()
    }




    func performFetchPostCoreData() {

        do {
            try self.fetchedResultsControllerPostCoreData?.performFetch()

        }
        catch {
            print(error)
        }
    }





    func savePersistentContainerContext() {

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
//        self.reloadFolders()

    }




    func appendPost(author: String?, image: String?, likes: String?, text: String?, views: String?, folderName: String, completion: (String?) -> Void) {

        self.getPosts(nameFolder: "SavedPosts")

        for postInCoreData in (self.fetchedResultsControllerPostCoreData?.sections![0].objects) as! [PostCoreData] {

            if postInCoreData.text == text {
                completion(NSLocalizedString("appendPost", tableName: "ProfileViewControllerLocalizable", comment: "This post has already been saved"))
                return
            }
        }

        self.getPosts(nameFolder: "AllPosts")



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


        let request = FoldersPostCoreData.fetchRequest()

        request.predicate = NSPredicate(format: "name == %@", nameFolder)

        do {
            let folders = try self.backgroundContext.fetch(request) as NSArray


            if folders.count >= 1 {

                print("🥀", folders, folders.count)
                let folder = (folders.filter { ($0 as AnyObject).name == nameFolder }).first

                return folder as? FoldersPostCoreData
            }
            else {
                return nil
            }
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }




    func getAllFolders() -> [FoldersPostCoreData]? {

        let request = FoldersPostCoreData.fetchRequest()

        do {
            return try self.backgroundContext.fetch(request)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }



    func deleteFolder(folder: FoldersPostCoreData) {

        self.backgroundContext.delete(folder)
        self.savePersistentContainerContext()
//        self.reloadFolders()
    }



    func deletePost(post: PostCoreData) {

        self.backgroundContext.delete(post)
        self.savePersistentContainerContext()
        self.performFetchPostCoreData()
    }

}










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
