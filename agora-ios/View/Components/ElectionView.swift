//
//  ElectionView.swift
//  agora-ios
//
//  Created by Siddharth sen on 3/19/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI



struct ElectionView: View {
    var body: some View {
        VStack(spacing:0) {
            //Top_ElectionView()
            CalendarContentView()
        }
    }
}

struct Top_ElectionView: View {
    @State var currentMonth = "March"
    var months:[String] = ["Jan\n  1","Feb\n  2","Mar\n  3","Apr\n  4","May\n  5","Jun\n  6","Jul\n  7","Aug\n 8","Sep\n 9","Oct\n 10","Nov\n 11","Dec\n 12"]
    
    
    var body : some View{
        
      return  VStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("Color1"), Color("Color2")]), startPoint: .topLeading, endPoint: .bottomTrailing).frame(width: UIScreen.main.bounds.width , height: 176, alignment: .center)
                Image("Mountains")
                
                HStack {
                    Text(currentMonth).foregroundColor(.white)
                                   .fontWeight(.bold)
                                   .font(.largeTitle)
                        .offset(y:-20)
                        .padding(.leading,25)
                        
                    Spacer()
                }
                ScrollView(.horizontal, showsIndicators: false){
                    
                    HStack {
                        ForEach(months,id: \.self){ month in
                            monthCard(cardTitle: month)
                        }
                    }
                }.offset(y:40)
          
            }
            
        }
        
    }
}

struct monthCard:View {
    let cardTitle:String
    var body: some View{
        
        VStack() {
            
            HStack(alignment: .top) {
                Text(cardTitle)
                    .foregroundColor(.white)
                    .fontWeight(.light)
                    .font(.headline)
                    .opacity(0.8)
            }
        }
        .padding(.top, -15)
        .frame(width:50, height:65)
        .background(Color("_Purple2"))
        .cornerRadius(8)
        .opacity(0.90)
        .shadow(radius: 8)
        .animation(.spring())
    }
    
}





struct ElectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
           ElectionView()
              .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
              .previewDisplayName("iPhone 8")

          ElectionView()
              .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
              .previewDisplayName("iPhone 11")
        }
    }
}
