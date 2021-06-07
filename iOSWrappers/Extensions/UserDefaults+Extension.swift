//
//  UserDefaults+Extension.swift
//  Parent
//
//  Created by Kala on 07/06/21.
//

import Foundation
import UIKit
extension UserDefaults {
    func getColorFor(_ key: String) -> UIColor? {
        if let data = data(forKey: key) {
            return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
        }
        return nil
    }
    
    func setColor(_ color: UIColor?, for key: String) {
        if let c = color {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: c, requiringSecureCoding: false) as NSData?
                set(data, forKey: key)
            } catch {}
        }
    }
    
    func getDoubleFor(_ key: String) -> Double {
        return UserDefaults.standard.double(forKey: key)
    }
    
    func setDouble(_ value: Double, for key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
}
