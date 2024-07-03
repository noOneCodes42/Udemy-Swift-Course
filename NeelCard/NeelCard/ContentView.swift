//
//  ContentView.swift
//  NeelCard
//
//  Created by Neel Arora on 6/27/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            Color(red: 0.09, green: 0.63, blue: 0.52)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Image("TheGoat")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 3)
                    )
                    .frame(width: 150.0, height: 150.0)
                Text("Neel Arora")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .foregroundColor(.white)
                    .bold()
                Text("IOS Developer")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                Divider()
                ExtractedView(text: "+1 123 456 789", imageName: "phone.fill")
                ExtractedView(text: "neel@email.com", imageName: "envelope.fill")
                }
            }
    }
}
struct ExtractedView: View{
    let text: String
    let imageName: String
    var body: some View{
        RoundedRectangle(cornerRadius: 25)
            .frame( height:50)
            .foregroundColor(.white)
            .overlay(HStack{
                Image(systemName: imageName)
                    .foregroundColor(.green)
                Text(text).foregroundStyle(.black)

            })
            .padding(.all)
    }
}

#Preview {
    ContentView()
}
