//
//  NotasR.swift
//  Notas
//
//  Created by Marco Alonso Rodriguez on 03/06/23.
//

import Foundation
import RealmSwift

class NotasR: Object {
    @objc dynamic var fecha: Date?
    @objc dynamic var imagen: NSData?
    @objc dynamic var texto: String?
}
