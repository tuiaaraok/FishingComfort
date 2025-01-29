import SwiftUI

struct AppInfo: Codable,Hashable {
    var id : UUID = UUID()
    var name: String = ""
    var car: String = ""
    var dataTime: Date = Foundation.Date()
    
    var category: String = ""
    var payment: String = ""
    var price: String = ""
    var description: String = ""
    var content: String = ""
    var phone: String = ""
    var forecast: String = ""
    var count: Int = 0
    var weight: Decimal = 0
   
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
