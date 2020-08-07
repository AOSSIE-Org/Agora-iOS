//
//  ElectionResultView.swift
//  agora-ios
//
//  Created by Siddharth sen on 7/21/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI

struct ElectionDetailsView: View {
    @State var showResultsView:Bool
    var electionName:String = "Melbourne March Election"
    var electionAlgo:String = ""
    
    var body: some View {
        
        return VStack(alignment: .leading) {
            ZStack {
                HStack(spacing:10) {
                    
                    Button(action: { self.showResultsView.toggle() }
                    ){
                        Image(systemName: "chevron.left").font(.title)
                    }.foregroundColor(.white)
                    Spacer()
                }.background(LinearGradient(gradient: Gradient(colors: [Color("Color2_2"), Color("Color2")]), startPoint: .bottom, endPoint: .top).frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height / 6 , alignment: .center).edgesIgnoringSafeArea(.top))
                Text(electionName)
                    .foregroundColor(.white)
                    .fontWeight(.regular)
                    .font(.title)
            }.padding()
            
            HStack {
                Spacer()
                Button(action: {}){
                    Text("Show Election Results").frame(width: UIScreen.main.bounds.width / 1.4 ,height: 50).foregroundColor(.white)
                    
                }.foregroundColor(.black)
                    .background(LinearGradient(gradient: Gradient(colors: [Color("Color2_2"), Color("Color2")]), startPoint: .bottom, endPoint: .top))
                    .cornerRadius(20)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                Spacer()
            }
            
            Divider()
            
            VStack {
                Text("Election Name: " + electionName)
                Text("Algorithm: " + electionAlgo)
            }.padding()
            
            Spacer()
            
        }
    }
}

struct ElectionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ElectionDetailsView(showResultsView: true)
    }
}
