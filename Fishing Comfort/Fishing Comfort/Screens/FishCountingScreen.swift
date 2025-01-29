
import SwiftUI

struct FishCountingScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var loader = Loader()
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
                ZStack(alignment: .top){
                    mainbg()
                    VStack{
                        HStack (spacing: 20){   //Header
                            Button(action:{
                                presentationMode.wrappedValue.dismiss()
                            }){
                                Image("pajamas_go-back")
                            }
                            Text("Fish counting in the lake")
                                .font(.custom("JosefinSans-Regular", size: 24))
                                .foregroundStyle(Color("CColorText"))
                            Spacer()
                        }
                        .padding(.leading,30)  // End Header
                        
                        
                        NavigationLink {
                            AddingFishView()
                            
                        } label: {
                            ZStack {
                                Image("Rectangle 1028")
                                Text("+Add Fish")
                                    .font(.custom("JosefinSans-Regular", size: 18))
                                    .foregroundStyle(Color("CColorTextR"))
                            }
                        }
                        .padding(.top, 15)
                        
                        
                        
                        ScrollView{
                            ForEach(Array(loader.fishs.enumerated()), id: \.element) { index, item in
                                
                                FishCountingView(item: item, index: index)
                            }
                        }
                        .padding(.top, 15)
                        .frame(width: 330)
                        
                        Spacer()
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 50)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
                .onAppear{
                    loader.Load(array: &loader.fishs, key: "fishs")
                }
            }
        }
    }
}

#Preview {
    FishCountingScreen()
}

struct FishCountingView: View {
    @State var isEditorActiv: Bool = false
    @StateObject var loader = Loader()
    @State var item: AppInfo
    @State var index: Int
    @State var name: String = ""
    @State var weight: Decimal = 0
    @State var count: Int = 0
    @State var forecast: String = ""
    var body: some View {
        ZStack{
            Image("Rectangle 1025")
                .onTapGesture {
                    isEditorActiv.toggle()
                }
                .overlay(
                    HStack(spacing:5) {
                        Image("Group 3")
  
                        VStack(spacing: 0){
                            HStack {
                                Text(name)
                                    .font(.custom("JosefinSans-Regular", size: 18))
                                    .foregroundStyle(Color("CColorText"))
                                Spacer()
                            }
                            HStack {
                                Text("Total:\(count) pcs. ")
                                    .font(.custom("JosefinSans-Regular", size: 18))
                                    .foregroundStyle(Color("CColorText"))
                                
                                Spacer()
                            }
                            HStack {
                                Text("Average weight: \(weight) kg")
                                    .font(.custom("JosefinSans-Regular", size: 18))
                                    .foregroundStyle(Color("CColorText"))
                                    .minimumScaleFactor(0.9)

                                Spacer()
                            }
                            HStack {
                                Text("Forecast: \(forecast)")
                                    .font(.custom("JosefinSans-Regular", size: 18))
                                    .foregroundStyle(Color("CColorText"))
                                    .minimumScaleFactor(0.9)

                                Spacer()
                            }
                           
                            Spacer()
                        }
                        .padding(.top, 20)
                    }
                    , alignment:.topLeading)
            NavigationLink(destination: AddingFishView(buffer:item), isActive: $isEditorActiv)
            {
                EmptyView()
            }
        }
        .onAppear{
            loader.Load(array: &loader.fishs, key: "fishs")
            name = item.name
            weight = item.weight
            count = item.count
            forecast = item.forecast
        }
    }
}
