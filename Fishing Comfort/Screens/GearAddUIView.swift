import SwiftUI

struct GearAddUIView: View {
    @State var name : String = ""
    @State var price : String = ""
    @State var count : String = ""
    @StateObject var loader  = Loader()
    @State var buffer: AppInfo? = nil
    
    
    let categories = [
        "Fishing Rod",
        "Reel",
        "Fishing Line",
        "Hooks",
        "Baits",
        "Lures",
        "Spinning Rod",
        "Float",
        "Net",
        "Boat",
        "Fish Finder",
        "Rod Case",
        "Feeder",
        "Landing Net",
        "Foldable Chair",
        "Thermos",
        "Sinkers",
        "Tackle Box",
        "Fishing Kit",
        "Wobblers",
        "Soft Plastics",
        "Fishing Platform",
        "Fishing Suit",
        "Tent",
        "Life Jacket",
        "Cooler",
        "Fishing Pliers",
        "Casting Net",
        "Fish Stringer",
        "Bait Bucket",
        "Fishing Gloves",
        "Spinning Reel",
        "Fly Rod",
        "Fly Reel",
        "Ice Fishing Rod",
        "Ice Auger",
        "Fishing Scale",
        "Measuring Tape",
        "Fish Gripper",
        "Bait Trap",
        "Spear Fishing Gear",
        "Underwater Camera",
        "Fishing Vest",
        "Rod Holder",
        "Drift Sock",
        "Anchor",
        "Buoy",
        "Portable Fish Cleaning Table"
    ]
    @State var selectedCategory: String
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .top){
                mainbg()
                VStack{
                    
                    HStack (spacing: 70){   //Header
                        Button(action:{
                            presentationMode.wrappedValue.dismiss()
                        }){
                            Image("pajamas_go-back")
                        }
                        Text("Adding Gear")
                            .font(.custom("JosefinSans-Regular", size: 26))
                            .foregroundStyle(Color("CColorText"))
                        Spacer()
                    }
                    .padding(.leading,25)  // End Header
                    
                    VStack(spacing: 1) { //Name
                        HStack {
                            Text("Name of tackle")
                                .font(.custom("JosefinSans-Regular", size: 24))
                                .frame(alignment: .leading)
                                .foregroundStyle(Color("CColorText"))
                                .padding(.leading, 40)
                            Spacer()
                        }
                        ZStack {
                            Image("Rectangle 1027")
                            TextField("", text: $name)
                                .font(.custom("JosefinSans-Regular", size: 20))
                                .foregroundStyle(Color("CColorText"))
                                .frame(width: 300, alignment: .leading)
                                
                        }
                    }//End Name
                    .padding(.top, 20)
                    
                    
                    VStack(spacing: 1) { //Name
                        HStack {
                            Text("Category")
                                .font(.custom("JosefinSans-Regular", size: 24))
                                .frame(alignment: .leading)
                                .foregroundStyle(Color("CColorText"))
                                .padding(.leading, 40)
                            Spacer()
                        }
                        ZStack {
                            Image("Rectangle 1027")
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
                                        Text("Select a category")
                                            .font(.custom("JosefinSans-Regular", size: 22))
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
                            .padding(.leading, 50)
                        }
                    }//End Category
                    
                    
                    
                    VStack(spacing: 1) { //price
                        HStack {
                            Text("Price for rent")
                                .font(.custom("JosefinSans-Regular", size: 24))
                                .frame(alignment: .leading)
                                .foregroundStyle(Color("CColorText"))
                                .padding(.leading, 40)
                            Spacer()
                        }
                        ZStack {
                            Image("Rectangle 1027")
                            TextField("", text: $price)
                                .font(.custom("JosefinSans-Regular", size: 20))
                                .foregroundStyle(Color("CColorText"))
                                .frame(width: 300, alignment: .leading)
                                .keyboardType(.phonePad)
                        }
                    }//End price
                    
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
                        
                        
                        if let index = loader.equipments.firstIndex(where: { $0.id == buffer?.id }) {
                            
                            loader.equipments[index].name = name
                            loader.equipments[index].price = price
                            loader.equipments[index].category = selectedCategory
                            if let validCount = Int(count) {
                                loader.equipments[index].count = validCount
                            } else {
                                print("Invalid count value")
                            }
                        }
                        else
                        {
                            var gear = AppInfo()
                            gear.id = UUID()
                            gear.name = name
                            gear.price = price
                            gear.category = selectedCategory
                            
                            if let validCount = Int(count) {
                                gear.count = validCount
                            } else {
                                print("Invalid count value")
                            }

                            loader.equipments.append(gear)
                        }
                        
                        loader.Save(array:loader.equipments, key: "equipments")
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
                loader.Load(array:&loader.equipments, key: "equipments")
                
                if(buffer != nil){
                    name = buffer!.name
                    price = buffer!.price
                    selectedCategory = buffer!.category
                    count = String(buffer!.count)
                }
            }
        }
    }
}

#Preview {
    GearAddUIView( selectedCategory: "")
}
