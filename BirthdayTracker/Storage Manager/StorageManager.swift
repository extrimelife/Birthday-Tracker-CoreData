//
//  StorageManager.swift
//  BirthdayTracker
//
//  Created by roman Khilchenko on 08.12.2022.
//

import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BirthdayTracker")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private let viewContext: NSManagedObjectContext
    
    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    
    // Метод для сопоставления модели из Entity c моделью ячейки
    func create(_ firstName: String,_ secondName: String,_ birthDate: Date, completion: (Birthday) -> Void) {
        let task = Birthday(context: viewContext)
        task.firstName = firstName
        task.secondName = secondName
        task.birthDate = birthDate
        completion(task)
        saveContext()
    }
    
    // Get data from Storage
    func fetchData(completion: (Result<[Birthday], Error>) -> Void) {
        let fetchRequest = Birthday.fetchRequest()
        
        do {
            let tasks = try viewContext.fetch(fetchRequest)
            completion(.success(tasks))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func update(_ task: Birthday, name: String, surname: String, data: Date) {
        task.firstName = name
        task.secondName = surname
        task.birthDate = data
        saveContext()
    }
    
    func delete(_ task: Birthday) {
        viewContext.delete(task)
        saveContext()
    }

    // MARK: - Core Data Saving support
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
