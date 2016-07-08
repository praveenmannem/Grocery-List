//
//  List+CoreDataProperties.swift
//  GroceryList
//


import Foundation
import CoreData

extension List {

    @NSManaged var item: String?
    @NSManaged var note: String?
    @NSManaged var qty: String?

}
