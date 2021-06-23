//
//  UserDefaults+Extension.swift
//  Parent
//
//  Created by Kala on 07/06/21.
//

import Foundation
import UIKit
public extension UserDefaults {
    func getColorFor(_ key: String) -> UIColor? {
        guard let data = data(forKey: key),
              let color = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor else { return nil }
        return color
    }
    
    func setColor(_ color: UIColor?, for key: String) {
        if let c = color {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: c, requiringSecureCoding: false) as NSData?
                set(data, forKey: key)
            } catch {}
        }
    }
    
    func getFontFor(_ key: String) -> UIFont? {
        if let data = data(forKey: key) {
            return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIFont
        }
        return nil
    }
    
    func setFont(_ font: UIFont?, for key: String) {
        if let c = font {
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
