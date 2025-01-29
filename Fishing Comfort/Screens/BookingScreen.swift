
import SwiftUI

struct BookingScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var loader = Loader()
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
                ZStack(alignment: .top){
                    mainbg()
                    VStack{
                        HStack (spacing: 100){   //Header
                            Button(action:{
                                presentationMode.wrappedValue.dismiss()
                            }){
                                Image("pajamas_go-back")
                            }
                            Text("Booking")
                                .font(.custom("JosefinSans-Regular", size: 26))
                                .foregroundStyle(Color("CColorText"))
                            Spacer()
                        }
                        .padding(.leading,30)  // End Header
                        
                        
                        NavigationLink {
                            BookingAddUIView( selectedCategory: "")
                            
                        } label: {
                            ZStack {
                                Image("Rectangle 1028")
                                Text("+Book a Gazebo")
                                    .font(.custom("JosefinSans-Regular", size: 18))
                                    .foregroundStyle(Color("CColorTextR"))
                            }
                        }
                        .padding(.top, 15)
                        
                        
                        
                        ScrollView{
                            ForEach(Array(loader.booking.enumerated()), id: \.element) { index, item in
                                
                                BookingScreenView(item: item, index: index)
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
                    loader.Load(array: &loader.booking, key: "booking")
                }
            }
        }
    }
}

#Preview {
    BookingScreen()
}

struct BookingScreenView: View {
    @State var isEditorActiv: Bool = false
    @StateObject var loader = Loader()
    @State var item: AppInfo
    @State var index: Int
    @State var name: String = ""
    @State var price: String = ""
    @State var count: Int = 0
    @State private var data: Foundation.Date = Foundation.Date()
    var body: some View {
        ZStack{
            Image("Rectangle 1025")
                .onTapGesture {
                    isEditorActiv.toggle()
                }
                .overlay(
                    HStack(spacing:5) {
                        Image("summer_beach_house 2")
                            .offset(y:-10)
                            .padding(.leading, 10)
                        
                        VStack(spacing: 10){
                            HStack {
                                Text(name)
                                    .font(.custom("JosefinSans-Regular", size: 18))
                                    .foregroundStyle(Color("CColorText"))
                                Spacer()
                            }
                            HStack {
                                Text("Data:")
                                    .font(.custom("JosefinSans-Regular", size: 18))
                                    .foregroundStyle(Color("CColorText"))
                                Text(data, format: Date.FormatStyle(date: .numeric, time: .none))
                                    
                                
                                Spacer()
                            }
                            HStack {
                                Text("Time:")
                                    .font(.custom("JosefinSans-Regular", size: 18))
                                    .foregroundStyle(Color("CColorText"))
                                Text(data, format: Date.FormatStyle(date: .none, time: .shortened))

                                Spacer()
                            }
                            .offset(y:-10)
                            Spacer()
                        }
                        .padding(.top, 20)
                    }
                    , alignment:.topLeading)
            NavigationLink(destination: BookingAddUIView(buffer:item, selectedCategory: item.category), isActive: $isEditorActiv)
            {
                EmptyView()
            }
        }
        .onAppear{
            loader.Load(array: &loader.equipments, key: "booking")
            name = item.name
            count = item.count
            price = item.price
            data = item.dataTime
        }
    }
}
