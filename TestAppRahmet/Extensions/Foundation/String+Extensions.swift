import Foundation
import UIKit

extension String {
    
    var firstUppercased: String {
        return firstUppercasedLetter + dropFirst()
    }
    
    var firstUppercasedLetter: String {
        guard let first = first else {
            return ""
        }
        return String(first).uppercased()
    }
    
}
