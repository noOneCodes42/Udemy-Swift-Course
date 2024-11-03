//
//  AboutMeView.swift
//  TheIndiaProject
//
//  Created by Neel Arora on 7/6/24.
//

import SwiftUI

struct AboutMeView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color(red: 0.09, green: 0.63, blue: 0.52)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Text("About Me")
                        .font(Font.custom("Pacifico-Regular", size: 20))
                        .bold()
                        .foregroundColor(Color.white)
                        .padding(.bottom)
                    Text("Hello, my name is Neel Arora and I am an IOS developer.")
                        .foregroundColor(Color.white)
                    Divider()
                    Text("What Have I done? ")
                        .font(.custom("Pacifico-Regular", size: 20))
                        .bold()
                        .foregroundColor(Color.white)
                        .padding(.top)
                        .padding(.bottom)
                    Text("I have coded multiple apps, including a BMI calculator, A Weather app that gets you live location and tells you the weather there, I created a dice app where it can be rolled and maybe used in casinos, I have also created a hacker news app that gets the highest viewed topics and shows it on IOS, MacOS, and IpadOS, Lastly I have created a chatting service that can register people with real authentication.")
                        .padding(.all)
                        .foregroundColor(Color.white)
                    HStack{
                        let url1 = "https://github.com/noOneCodes42/checking/tree/main/Dicee-swift"
                        
                        let url2 = "https://github.com/noOneCodes42/checking/tree/main/BMI-Calculator-iOS13"
                        NavigationLink(destination: LinkAccess(url: url1)) {
                            Image("DiceeImg")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.white, lineWidth: 3)
                                )
                                .frame(width: 100.0, height: 100.0)

                        }
                        NavigationLink(destination: LinkAccess(url: url2)) {
                            Image("BMICalc")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.white, lineWidth: 3)
                                )
                                .frame(width: 100.0, height: 100.0)
                        }
                        
                    }
                }
            }
        }
    }
}
struct AboutMeView_Previews: PreviewProvider {
    static var previews: some View {
        AboutMeView()
    }
}
