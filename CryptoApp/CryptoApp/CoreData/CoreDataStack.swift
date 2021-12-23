//
//  CoreDataStack.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import Foundation
import CoreData
import CryptoKit

final class CoreDataStack {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CryptoApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataStack {
    func getUser(login: String, password: String) -> AuthModel? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let md5Password = MD5(string: password)
        fetchRequest.predicate = NSPredicate(format: "\(#keyPath(User.login)) = '\(login)' && \(#keyPath(User.password)) = '\(md5Password)'")
        guard let object = try? self.persistentContainer.viewContext.fetch(fetchRequest).first else { return nil }
        return AuthModel(user: object)
    }

    func saveUser(user: AuthModel, completion: @escaping () -> Void) {
        self.persistentContainer.performBackgroundTask { [weak self] context in
            let object = User(context: context)
            object.uid = user.uid
            object.login = user.login
            guard let md5Password = self?.MD5(string: user.password) else { return }
            object.password = md5Password
            try? context.save()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { completion() })
        }
    }
    
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
