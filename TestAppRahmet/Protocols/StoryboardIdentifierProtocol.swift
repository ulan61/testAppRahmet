import UIKit

protocol StoryboardIdentifierProtocol {
    
    static var storyboardIdentifier: String { get }
    
}

extension StoryboardIdentifierProtocol where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
}
