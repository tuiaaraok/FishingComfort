
import SwiftUI

struct mainbg: View {
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                Image(uiImage: createImage(size: CGSize(width: 100, height: 100), color: UIColor(Color(hex: "#9acbff"))))
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .frame(height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                  
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

func createImage(size: CGSize, color: UIColor) -> UIImage {
    UIGraphicsBeginImageContext(size)
    color.setFill()
    UIRectFill(CGRect(origin: .zero, size: size))
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image ?? UIImage()
}



extension Color {
    init(hex: String) {
        let r, g, b: Double
        
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        switch hexSanitized.count {
        case 6:
            r = Double((rgb >> 16) & 0xFF) / 255
            g = Double((rgb >> 8) & 0xFF) / 255
            b = Double(rgb & 0xFF) / 255
            
        default:
            r = 0
            g = 0
            b = 0
        }
        
        self.init(red: r, green: g, blue: b)
    }
}



#Preview {
    mainbg()
}
