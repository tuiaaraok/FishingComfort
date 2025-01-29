import SwiftUI

struct AddingFishView: View {
    @State var name : String = ""
    @State var weight : String = ""
    @State var count : String = ""
    @State var forecast : String = ""
    @StateObject var loader  = Loader()
    @State var buffer: AppInfo? = nil

    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
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
                        Text("Adding fish to accounting")
                            .font(.custom("JosefinSans-Regular", size: 22))
                            .foregroundStyle(Color("CColorText"))
                        Spacer()
                    }
                    .padding(.leading,25)  // End Header
                    
                    
                    
                    VStack(spacing: 1) { //Name
                        HStack {
                            Text("Type of fish")
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
                    
                    VStack(spacing: 1) { //Quantity
                        HStack {
                            Text("Quantity")
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
                    }//End Quantity
                    
                    //End Category
                    
                    
                    
                    VStack(spacing: 1) { //price
                        HStack {
                            Text("Average weight")
                                .font(.custom("JosefinSans-Regular", size: 24))
                                .frame(alignment: .leading)
                                .foregroundStyle(Color("CColorText"))
                                .padding(.leading, 40)
                            Spacer()
                        }
                        ZStack {
                            Image("Rectangle 1027")
                            TextField("", text: $weight)
                                .font(.custom("JosefinSans-Regular", size: 20))
                                .foregroundStyle(Color("CColorText"))
                                .frame(width: 300, alignment: .leading)
                                .keyboardType(.decimalPad)
                        }
                    }//End price
                    
                    VStack(spacing: 1) { //price
                        HStack {
                            Text("Add info about the habitat")
                                .font(.custom("JosefinSans-Regular", size: 24))
                                .frame(alignment: .leading)
                                .foregroundStyle(Color("CColorText"))
                                .padding(.leading, 40)
                            Spacer()
                        }
                        ZStack {
                            Image("Rectangle 1027")
                            TextField("", text: $forecast)
                                .font(.custom("JosefinSans-Regular", size: 20))
                                .foregroundStyle(Color("CColorText"))
                                .frame(width: 300, alignment: .leading)
                                .keyboardType(.numberPad)
                        }
                    }//End price
                    
                    Spacer()
                    Button(action:{
                        
                        
                        if let index = loader.fishs.firstIndex(where: { $0.id == buffer?.id }) {
                            
                            loader.fishs[index].name = name
                            loader.fishs[index].forecast = forecast
                            
                            if let validWeight = Decimal(string: weight) {
                                loader.fishs[index].weight = validWeight
                            } else {
                                print("Invalid weight value")
                            }

                            if let validCount = Int(count) {
                                loader.fishs[index].count = validCount
                            } else {
                                print("Invalid count value")
                            }
                        }
                        else
                        {
                            var fish = AppInfo()
                            fish.id = UUID()
                            fish.name = name
                            fish.forecast = forecast

                            if let validWeight = Decimal(string: weight) {
                                fish.weight = validWeight
                            } else {
                                print("Invalid Weight value")
                            }
                            
                            if let validCount = Int(count) {
                                fish.count = validCount
                            } else {
                                print("Invalid count value")
                            }

                            loader.fishs.append(fish)
                        }
                        
                        loader.Save(array:loader.fishs, key: "fishs")
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
                loader.Load(array:&loader.fishs, key: "fishs")
                
                if(buffer != nil){
                    name = buffer!.name
                    forecast = buffer!.forecast
                    weight = String(describing: buffer!.weight)
                    count = String(buffer!.count)
                }
            }
        }
    }
}

#Preview {
    AddingFishView()
}
