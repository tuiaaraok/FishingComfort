
import SwiftUI

class Loader: ObservableObject{
    @Published var equipments: [AppInfo] = []
    @Published var fishs: [AppInfo] = []
    @Published var booking: [AppInfo] = []
    
    func Save(array: [AppInfo], key: String){
        print("Start Saved: \(array.count)")
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(array) {
            UserDefaults.standard.set(encoded, forKey: "array\(key)")
        }
        print("End Saved: \(array.count)")
    }
    
    func Load(array: inout [AppInfo], key: String){
        if let encoded = UserDefaults.standard.data(forKey: "array\(key)") {
            let decoder = JSONDecoder()
            if let load = try? decoder.decode([AppInfo].self, from: encoded) {
                array = load
            }
            print("Load: \(array.count)")
        }
    }
    
    func removeObj(array: inout [AppInfo], id:UUID) {
        print("delete \(id)")
        array.removeAll { $0.id == id }
    }
    
    func removeAllData(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
