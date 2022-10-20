//
//  LandingPage.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/2/22.
//

import SwiftUI

extension View {
    func animatableGradient(fromGradient: Gradient, toGradient: Gradient, progress: CGFloat) -> some View {
        self.modifier(AnimatableGradientModifier(fromGradient: fromGradient, toGradient: toGradient, progress: progress))
    }
}


struct AnimatableGradientModifier: AnimatableModifier {
    let fromGradient: Gradient
    let toGradient: Gradient
    var progress: CGFloat = 0.0 //keeps track of gradient change

    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    func body(content: Content) -> some View {
        var gradientColors = [Color]()

        for i in 0..<fromGradient.stops.count {
            let fromColor = UIColor(fromGradient.stops[i].color)
            let toColor = UIColor(toGradient.stops[i].color)

            gradientColors.append(colorMixer(fromColor: fromColor, toColor: toColor, progress: progress))
        }

        return LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    func colorMixer(fromColor: UIColor, toColor: UIColor, progress: CGFloat) -> Color {
        guard let fromColor = fromColor.cgColor.components else { return Color(fromColor) }
        guard let toColor = toColor.cgColor.components else { return Color(toColor) }

        let red = fromColor[0] + (toColor[0] - fromColor[0]) * progress
        let green = fromColor[1] + (toColor[1] - fromColor[1]) * progress
        let blue = fromColor[2] + (toColor[2] - fromColor[2]) * progress

        return Color(red: Double(red), green: Double(green), blue: Double(blue))
    }
}



struct LandingPage: View {
    @AppStorage("signedIn") var signedIn = false
    @Environment (\.dismiss) var dismiss
   
    @StateObject var signUpController = SignUpController()
    @StateObject var vm = DashboardLogic()
    
    @State private var progress: CGFloat = 0
    //colors for background on landing page
   let gradient1 = Gradient(colors: [.yellow, .orange])
   let gradient2 = Gradient(colors: [.yellow, .pink])
    
    @State private var animateGradient = false
    @State private var test = false
    
    @ViewBuilder
    var body: some View {
        if(signedIn){
            UserDashboardView(vm: vm, signUpController: signUpController)
        }
        else{
            NavigationView{
                ZStack{
                    Rectangle()
                        .animatableGradient(fromGradient: gradient1, toGradient: gradient2, progress: progress)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                        .onAppear {
                            DispatchQueue.main.async {
                                withAnimation(.linear(duration: 5.0).repeatForever(autoreverses: true)) {
                                    self.progress = 1.0
                               }
                            }
                           
                        }
                    VStack{
                            Image("bodybuilding-1") // << main image
                                .resizable()
                                .scaledToFit()
                                .frame(width:150, height:150)
                                //.renderingMode(.template)
                                .foregroundColor(.black)
                                .padding(.top, 200)
                        
                            Text("Welcome to Meal Journal")
                                .font(.custom("PlayfairDisplay-Regular", size: 25))
                                .padding()
                        
                        .offset(y:-25) // << adjusts title
                        
                        VStack{
                            NavigationLink(destination:createUserAccount() .navigationBarHidden(true),
                           label:{
                                Text("Get Started").fontWeight(.bold)
                                    .frame(minWidth: 0, maxWidth: 200)
                                    .padding(10)
                                    .foregroundColor(.white)
                                //draw rectange around buttons
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(
                                                LinearGradient(
                                                    colors: [.orange, .yellow],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )))
                                            })
                            
                            NavigationLink(destination: userLogin(signUpController: signUpController).navigationBarHidden(true), label: {
                                Text("Login").fontWeight(.semibold)
                                    .frame(minWidth:0, maxWidth: 200)
                                    .padding(10)
                                    .foregroundColor(.black)
                                    .overlay( RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.gray, lineWidth: 3)
                                        )
                            })
                                .padding() //separating buttons
                            
                            
                        }
                       
                    }
                    .padding(.top, -50)
                }
            }
            
        }
    }
}


   
struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}
