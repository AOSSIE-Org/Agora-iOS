//
//  UserTextField.swift
//  agora-ios
//
//  Created by Siddharth sen on 6/2/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI

struct UserTextField: View {
    var fieldName:String
    var secure:Bool = false
    
    @Binding var userField:String
    
    var body: some View {
        VStack(alignment:.leading){
            Text(fieldName)
                .fontWeight(.bold)
                .padding(.top,20)
            if secure == false{
                TextField("",text: self.$userField)
            }else{
                SecureField("",text: self.$userField)
            }
            Rectangle().fill(self.userField == "" ? Color.black.opacity(0.08):Color.yellow)
                .frame(height:3)
        }
          
    }
}

struct UserTextField_Previews: PreviewProvider {
    static var previews: some View {
        UserTextField(fieldName: "Email", userField: .constant("Test"))
    }
}
