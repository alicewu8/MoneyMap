//
//  Purchase+CoreDataProperties.swift
//  
//
//  Created by Alice Wu on 5/3/20.
//
//

import Foundation
import CoreData


extension PurchaseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PurchaseEntity> {
        return NSFetchRequest<PurchaseEntity>(entityName: "PurchaseEntity")
    }

    @NSManaged public var cost: Double
    @NSManaged public var descr: String?

}
