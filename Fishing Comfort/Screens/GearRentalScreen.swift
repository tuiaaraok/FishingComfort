
import SwiftUI

struct GearRentalScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var loader = Loader()
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
                ZStack(alignment: .top){
                    mainbg()
                    VStack{
                        HStack (spacing: 78){   //Header
                            Button(action:{
                                presentationMode.wrappedValue.dismiss()
                            }){
                                Image("pajamas_go-back")
                            }
                            Text("Gear rental")
                                .font(.custom("JosefinSans-Regular", size: 26))
                                .foregroundStyle(Color("CColorText"))
                            Spacer()
                        }
                        .padding(.leading,30)  // End Header
                        
                        
                        NavigationLink {
                            GearAddUIView( selectedCategory: "")
                            
                        } label: {
                            ZStack {
                                Image("Rectangle 1028")
                                Text("+Add Gear")
                                    .font(.custom("JosefinSans-Regular", size: 18))
                                    .foregroundStyle(Color("CColorTextR"))
                            }
                        }
                        .padding(.top, 15)
                        
                        
                        
                        ScrollView{
                            ForEach(Array(loader.equipments.enumerated()), id: \.element) { index, item in
                                
                                GearRentalScreenView(item: item, index: index)
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
                    loader.Load(array: &loader.equipments, key: "equipments")
                }
            }
        }
    }
}

#Preview {
    GearRentalScreen()
}

struct GearRentalScreenView: View {
    @State var isEditorActiv: Bool = false
    @StateObject var loader = Loader()
    @State var item: AppInfo
    @State var index: Int
    @State var name: String = ""
    @State var price: String = ""
    @State var count: Int = 0
    var body: some View {
        ZStack{
            Image("Rectangle 1025")
                .onTapGesture {
                    isEditorActiv.toggle()
                }
                .overlay(
                    HStack(spacing:5) {
                        Image("Group 4")
                            .offset(y:-10)
                        
                        VStack(spacing: 10){
                            HStack {
                                Text(name)
                                    .font(.custom("JosefinSans-Regular", size: 18))
                                    .foregroundStyle(Color("CColorText"))
                                Spacer()
                            }
                            HStack {
                                Text("\(count) pcs ")
                                    .font(.custom("JosefinSans-Regular", size: 18))
                                    .foregroundStyle(Color("CColorText"))
                                
                                Spacer()
                            }
                            HStack {
                                Text("Cost: \(price)$/day")
                                    .font(.custom("JosefinSans-Regular", size: 18))
                                    .foregroundStyle(Color("CColorText"))
                                    .minimumScaleFactor(0.9)
                                
                                Button(action:{
                                    
                                }){
                                    ZStack {
                                        
                                        Image("Rectangle 1029")
                                            .offset(y:-8)
                                        Text("Rent")
                                            .font(.custom("JosefinSans-Regular", size: 22))
                                            .foregroundStyle(Color("CColorText"))
                                            .padding(.bottom, 15)
                                    }
                                }
                                Spacer()
                            }
                            .offset(y:-10)
                            Spacer()
                        }
                        .padding(.top, 20)
                    }
                    , alignment:.topLeading)
            NavigationLink(destination: GearAddUIView(buffer:item, selectedCategory: item.category), isActive: $isEditorActiv)
            {
                EmptyView()
            }
        }
        .onAppear{
            loader.Load(array: &loader.equipments, key: "equipments")
            name = item.name
            count = item.count
            price = item.price
        }
    }
}
