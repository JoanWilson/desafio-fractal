//
//  CoreDataManager.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 01/02/24.
//

import Foundation
import CoreData

final class CoreDataContainer: BeerLocalRepository {
    
    var container: NSPersistentContainer
    
    private var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    public init?(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FavoriteDatabase")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        var loadError: Error?
        container.loadPersistentStores { (_, error) in
            loadError = error
        }
        
        if loadError != nil {
            return nil
        }
    }
    
    func listAllFavoriteBeer() throws -> [FavoriteBeer] {
        let fetchRequest = NSFetchRequest<FavoriteBeer>(entityName: "FavoriteBeer")
        return try viewContext.fetch(fetchRequest)
    }
    
    func saveFavoriteBeer(using dto: FavoriteBeerDTO) throws -> FavoriteBeer {
        let favoriteBeer = FavoriteBeer(context: viewContext)
        favoriteBeer.id = dto.id
        favoriteBeer.name = dto.name
        favoriteBeer.descriptionBeer = dto.description
        favoriteBeer.tagline = dto.tagline
        favoriteBeer.image = dto.imageData
        favoriteBeer.imageURL = dto.imageURL
        
        do {
            try saveContext()
            return favoriteBeer
        } catch {
            throw ErrorFavoriteBeer.unableToSaveData
        }
        
    }
    
    func getFavoriteBeerById(id: Int64) -> FavoriteBeer? {
        let fetchRequest = NSFetchRequest<FavoriteBeer>(entityName: "FavoriteBeer")
        fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
        do {
            let results = try viewContext.fetch(fetchRequest)
            return results.first
        } catch {
            print("Failed to fetch favorite beer: \(error)")
            return nil
        }
    }
    
    func deleteBeerById(id: Int64) throws {
        let fetchRequest = NSFetchRequest<FavoriteBeer>(entityName: "FavoriteBeer")
        fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
        do {
            let results = try viewContext.fetch(fetchRequest)
            for beer in results {
                viewContext.delete(beer)
            }
            try saveContext()
        } catch {
            throw ErrorFavoriteBeer.couldntDeleteData
        }
    }

    private func saveContext() throws {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                throw ErrorFavoriteBeer.unableToSaveData
            }
        }
    }
}
