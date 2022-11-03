//
//  CoreDataCoordinator.swift
//  Novigation
//
//  Created by Александр Хмыров on 01.11.2022.
//

import Foundation
import CoreData


class CoreDataCoordinator {



    static var shared = CoreDataCoordinator()

    var folder: [FoldersPostCoreData] = []

    var posts: [PostCoreData] = []




    lazy var persistentContainer: NSPersistentContainer = {

        var persistentContainer = NSPersistentContainer(name: "CoreDadaModel")

        persistentContainer.loadPersistentStores { nsPersistentStoreDescription, error in

            if let error = error as NSError? {
                fatalError("\(error), \(error.userInfo)")
            }
        }
        return persistentContainer
    }()




    private init() {
        self.reloadFolders()
        self.reloadPosts()
        if self.folder == [] {
            self.appendFolder(name: "SavedPosts")
        }
        print("folder >>>>>>>>", self.folder[0].name)
     //   print("posts >>>>>>>>", self.posts[0])
    }




    func savePersistentContainerContext() {

        do {
            try persistentContainer.viewContext.save()
        }
        catch {
            let nsError = error as NSError?
            fatalError("nsCoreDataError \(String(describing: nsError)), \(String(describing: nsError?.userInfo))")
        }
    }




    func reloadFolders()  {

        let request = FoldersPostCoreData.fetchRequest()

        do {
            self.folder = try self.persistentContainer.viewContext.fetch(request)
        }
        catch {
            print(error.localizedDescription)

        }
    }




    func reloadPosts() {

        let request = PostCoreData.fetchRequest()

    //    request.sortDescriptors = [NSSortDescriptor(key: "likes", ascending: true)]

        do {

            self.posts = try persistentContainer.viewContext.fetch(request)
        }
        catch {
            print(error.localizedDescription)
        }
    }




    func appendFolder(name: String) {

        let folder = FoldersPostCoreData(context: self.persistentContainer.viewContext
        )
        folder.name = name
        self.savePersistentContainerContext()
        self.reloadFolders()
    }




    func appendPost(author: String?, image: String?, likes: String?, text: String?, views: String?, folder: FoldersPostCoreData?) {

        var folderObject: FoldersPostCoreData

        if folder == nil {
            folderObject = self.folder[0]
        }
        else {
            folderObject = folder!
        }

        let post = PostCoreData(context: self.persistentContainer.viewContext)
        post.author = author
        post.image = image
        post.text = text
        post.likes = likes
        post.views = views

        post.relationFolder = folderObject

        self.savePersistentContainerContext()
        self.reloadPosts()
    }



    func deleteFolder(folder: FoldersPostCoreData) {

        self.persistentContainer.viewContext.delete(folder)
        self.savePersistentContainerContext()
        self.reloadFolders()
    }


    func deletePost(post: PostCoreData) {
        self.persistentContainer.viewContext.delete(post)
        self.savePersistentContainerContext()
        self.reloadPosts()
    }

}

