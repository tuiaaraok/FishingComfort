import SwiftUI

struct BookingAddUIView: View {
    @State var name : String = ""
    @State var gazebo : String = ""
    @State var phone : String = ""
    @State var count : String = ""
    @State var selectData: Foundation.Date = Foundation.Date()
    @StateObject var loader  = Loader()
    @State var buffer: AppInfo? = nil
    
    
    let categories: [String] = (1...200).map { String($0) }

    @State var selectedCategory: String
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .top){
                mainbg()
                VStack{
                    
                    HStack (spacing: 35){   //Header
                        Button(action:{
                            presentationMode.wrappedValue.dismiss()
                        }){
                            Image("pajamas_go-back")
                        }
                        Text("Add a new booking")
                            .font(.custom("JosefinSans-Regular", size: 26))
                            .foregroundStyle(Color("CColorText"))
                        Spacer()
                    }
                    .padding(.leading,25)  // End Header
                    
                    
                    VStack(spacing: 1) { //Name
                        HStack {
                            Text("Name")
                                .font(.custom("JosefinSans-Regular", size: 24))
                                .frame(alignment: .leading)
                                .foregroundStyle(Color("CColorText"))
                                .padding(.leading, 40)
                            Text("Gazebo")
                                .font(.custom("JosefinSans-Regular", size: 24))
                                .frame(alignment: .leading)
                                .foregroundStyle(Color("CColorText"))
                                .padding(.leading, 97)
                            Spacer()
                        }
                        HStack (spacing : 19){
                            ZStack {
                                Image("Rectangle 1031")
                                TextField("", text: $name)
                                    .font(.custom("JosefinSans-Regular", size: 20))
                                    .foregroundStyle(Color("CColorText"))
                                    .frame(width: 150, alignment: .leading)
                                
                            }
                            ZStack {
                                Image("Rectangle 1031")
                                HStack {
                                    Menu{
                                        ForEach(categories , id: \.self) { category in
                                            Button(action: {
                                                selectedCategory = category //
                                                print(category)
                                            }) {
                                                Text(category)
                                            }
                                        }
                                        
                                    } label: {
                                        if(selectedCategory.isEmpty){
                                            Text("Gazebo number")
                                                .font(.custom("JosefinSans-Regular", size: 18))
                                                .foregroundColor(Color.black)
                                                .opacity(0.5)
                                        }else{
                                            Text(selectedCategory)
                                                .font(.custom("JosefinSans-Regular", size: 22))
                                                .foregroundColor(Color.black)
                                            
                                        }
                                            
                                        
                                        Spacer()
                                    }
                                }
                                .frame(width: 140, alignment: .center)
                                .padding(.leading, 10)
                                
                            }
                        }
                    }//End Name
                    
                    
                    
                    VStack(spacing: 1) { //Name
                        HStack {
                            Text("Data")
                                .font(.custom("JosefinSans-Regular", size: 24))
                                .frame(alignment: .leading)
                                .foregroundStyle(Color("CColorText"))
                                .padding(.leading, 40)
                            Text("Time")
                                .font(.custom("JosefinSans-Regular", size: 24))
                                .frame(alignment: .leading)
                                .foregroundStyle(Color("CColorText"))
                                .padding(.leading, 108)
                            Spacer()
                        }
                        HStack (spacing : 19){
                            ZStack {
                                Image("Rectangle 1031")
                                DatePicker("", selection: $selectData, displayedComponents: .date)
                                    .frame(width: 100)
                                    .padding(.trailing, 10)
                                
                                
                            }
                            ZStack {
                                Image("Rectangle 1031")
                                DatePicker("", selection: $selectData, displayedComponents: .hourAndMinute)
                                    .frame(width: 100)
                                    .padding(.trailing,27)
                                
                            }
                        }
                    }//End Name
                    
                    VStack(spacing: 1) { //Name
                        HStack {
                            Text("Phone")
                                .font(.custom("JosefinSans-Regular", size: 24))
                                .frame(alignment: .leading)
                                .foregroundStyle(Color("CColorText"))
                                .padding(.leading, 40)
                            Spacer()
                        }
                        ZStack {
                            Image("Rectangle 1027")
                            TextField("", text: $phone)
                                .font(.custom("JosefinSans-Regular", size: 20))
                                .foregroundStyle(Color("CColorText"))
                                .frame(width: 300, alignment: .leading)
                                .keyboardType(.numberPad)
                        }
                    }//End Name
                    .padding(.top, 20)
                    
                    
                    //VStack(spacing: 1) //End Category
                    
                    
                    
                    
                    VStack(spacing: 1) { //price
                        HStack {
                            Text("Quantity in stock")
                                .font(.custom("JosefinSans-Regular", size: 24))
                                .frame(alignment: .leading)
                                .foregroundStyle(Color("CColorText"))
                                .padding(.leading, 40)
                            Spacer()
                        }
                        ZStack {
                            Image("Rectangle 1027")
                            TextField("", text: $count)
                                .font(.custom("JosefinSans-Regular", size: 20))
                                .foregroundStyle(Color("CColorText"))
                                .frame(width: 300, alignment: .leading)
                                .keyboardType(.numberPad)
                        }
                    }//End price
                    
                    Spacer()
                    Button(action:{
                        
                        
                        if let index = loader.booking.firstIndex(where: { $0.id == buffer?.id }) {
                            
                            loader.booking[index].name = name
                            loader.booking[index].phone = phone
                            loader.booking[index].category = selectedCategory
                            if let validCount = Int(count) {
                                loader.booking[index].count = validCount
                            } else {
                                print("Invalid count value")
                            }
                        }
                        else
                        {
                            var gear = AppInfo()
                            gear.id = UUID()
                            gear.name = name
                            gear.phone = phone
                            gear.category = selectedCategory
                            
                            if let validCount = Int(count) {
                                gear.count = validCount
                            } else {
                                print("Invalid count value")
                            }

                            loader.booking.append(gear)
                        }
                        
                        loader.Save(array:loader.booking, key: "booking")
                        self.presentationMode.wrappedValue.dismiss()
                        
                        
                    }){
                        ZStack{
                            Image("Rectangle 1030")
                            Text("Save")
                                .font(.custom("JosefinSans-Regular", size: 25))
                                .foregroundStyle(Color("CColorTextR"))
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .navigationBarBackButtonHidden(true)
            .onAppear{
                loader.Load(array:&loader.booking, key: "booking")
                
                if(buffer != nil){
                    name = buffer!.name
                    phone = buffer!.phone
                    selectedCategory = buffer!.category
                    count = String(buffer!.count)
                }
            }
        }
    }
}

#Preview {
    BookingAddUIView( selectedCategory: "")
}
