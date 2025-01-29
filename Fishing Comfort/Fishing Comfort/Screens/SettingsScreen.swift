

import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .top){
                mainbg()
                VStack{
                    Button(action:{
                        openPravicy()
                    }){
                        ZStack {
                            Image("Rectangle 1024")
                            Text("Pravicy Policy")
                                .font(.custom("JosefinSans-Regular", size: 26))
                                .foregroundStyle(Color("CColorText"))
                        }
                    }
                    Button(action:{
                        sendEmail()
                    }){
                        ZStack {
                            Image("Rectangle 1024")
                            Text("Contact Us")
                                .font(.custom("JosefinSans-Regular", size: 26))
                                .foregroundStyle(Color("CColorText"))
                        }
                    }
                    Button(action:{
                        rateApp()
                    }){
                        ZStack {
                            Image("Rectangle 1024")
                            Text("Rate Us")
                                .font(.custom("JosefinSans-Regular", size: 26))
                                .foregroundStyle(Color("CColorText"))
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .onAppear{
            }
        }
        
    }
}



func sendEmail() {
    let email = "elifbakar95@icloud.com"
    let subject = "Hello, "
    let body = ""
    
    let emailURL = "mailto:\(email)?subject=\(subject)&body=\(body)"
    
    if let url = URL(string: emailURL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Cannot open mail app")
        }
    }
}

func rateApp() {
    let appID = "6739554629"
    if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appID)?action=write-review") {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

func openPravicy() {
    let urlString = "https://docs.google.com/document/d/1cE_anLFCF9Q294JVhbM7XywLVmmCXEsS8c88wcFw8LI/mobilebasic"
    guard let url = URL(string: urlString) else {
        print("error URL: \(urlString)")
        return
    }
    
    if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
        print("notOpen URL: \(url)")
    }
}



#Preview {
    SettingsScreen()
}
