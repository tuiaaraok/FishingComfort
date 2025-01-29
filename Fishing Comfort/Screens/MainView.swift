
import SwiftUI

struct MainView: View {
    @State var settingPersenter:Bool = false
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
                ZStack(alignment: .top){
                    mainbg()
                    VStack{
                        Spacer()
                        VStack{
                            NavigationLink{
                                BookingScreen()
                                    .navigationBarBackButtonHidden(true)
                            }label:{
                                ZStack {
                                    Image("Rectangle 1024")
                                    Text("Booking")
                                        .font(.custom("JosefinSans-Regular", size: 26))
                                        .foregroundStyle(Color("CColorText"))
                                }
                            }
                            
                            NavigationLink{
                                GearRentalScreen()
                                    .navigationBarBackButtonHidden(true)
                            }label:{
                                ZStack {
                                    Image("Rectangle 1024")
                                    Text("Equipment rental")
                                        .font(.custom("JosefinSans-Regular", size: 26))
                                        .foregroundStyle(Color("CColorText"))
                                }
                            }
                            
                            NavigationLink{
                                FishCountingScreen()
                                    .navigationBarBackButtonHidden(true)
                            }label:{
                                ZStack {
                                    Image("Rectangle 1024")
                                    Text("Fish Accounting")
                                        .font(.custom("JosefinSans-Regular", size: 26))
                                        .foregroundStyle(Color("CColorText"))
                                }
                            }
                            
                            
                            
                            Button(action:{
                                settingPersenter.toggle()
                            }){
                                ZStack {
                                    Image("Rectangle 1024")
                                    Text("Settings")
                                        .font(.custom("JosefinSans-Regular", size: 26))
                                        .foregroundStyle(Color("CColorText"))
                                }
                            }
                            .sheet(isPresented: $settingPersenter){
                                SettingsScreen()
                            }
                        }
                        .padding(.bottom, 70)
                        //Spacer()
                        Image("vector-set-illustrated-people 1")

                    }
                    .ignoresSafeArea()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
                .onAppear{
                }
            }
        }
    }
}

#Preview {
    MainView()
}
