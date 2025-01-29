import SwiftUI
import FirebaseRemoteConfig

struct ContentView: View {
   
    @State var reqLink = ""
    @ObservedObject var checker = Checking()
    @AppStorage("link") var link: String = ""
    @AppStorage("showAgree") var showAgree: Bool = false
    @AppStorage("firsShowing") var firsShowing: Bool = true
    @State var showWebView: Bool = true
    @State var nextView: Bool = false
    @State private var hasCheckedLink = false
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                if(showWebView){
                    WebView(link: reqLink)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                }
                
                if (nextView) {
                    MainView()
                    .transition(.identity)
                    .zIndex(1)
                }
            }
        }
        .onAppear{
            
                if(link.isEmpty){
                    start()
                }else{
                    showAgree = false
                    print("load is data \(link)")
                    reqLink = link
                }
        }
        .overlay(VStack
                 {
            if(showAgree){
                Button(action:{
                    withAnimation(nil)
                    {
                    nextView = true
                    showAgree = false
                    }
                })
                {
                    ZStack {
                        Rectangle()
                            .frame(width: 100, height: 50)
                            .cornerRadius(10)
                        Text("Agree")
                            .foregroundStyle(Color.white)
                    }
                    .padding(.bottom, 20)
                }
                .foregroundStyle(Color.black)
            }
            
        },
                 alignment: .bottom)
    }
    
    private func start() {
        if(firsShowing){
            firsShowing = false
        }else{
            nextView = true
            return
        }
        
        Task {
            if let url = await fetchFromRemote() {
                reqLink = url.absoluteString
                if checker.containsSpecialCharacters(in: reqLink, characters: "showAgreebutton") {
                    showAgree = true

                } else {
                    showAgree = false
                    link = reqLink
                }
            } else {
                print("Failed to fetch URL.")
            }
        }
    }

    
    func fetchFromRemote() async -> URL? {
        let rc = RemoteConfig.remoteConfig()
        
        do {
            let status = try await rc.fetchAndActivate()
            if status == .successFetchedFromRemote || status == .successUsingPreFetchedData {
                let urlString = rc["remLink"].stringValue ?? ""
                guard let url = URL(string: urlString) else { return nil }
                return url
            }
        } catch {
           
            print("!!!")
        }
        return nil
    }
}

#Preview {
    ContentView()
}
