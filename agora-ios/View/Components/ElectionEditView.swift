//
//  ElectionEditView.swift
//  agora-ios
//
//  Created by Siddharth sen on 3/23/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI
import RealmSwift

struct ElectionEditView: View {
    var body: some View {
        VStack{
            Button(action: {
                
                let config = Realm.Configuration(schemaVersion : 4)
                do{
                    let realm = try Realm(configuration: config)
                    let result = realm.objects(DatabaseElection.self)
                    
                    for i in result{
                        
                        try realm.write({
                            i.title = "New Title!"
                            realm.add(i)
                        })
                    }
                    
                    
                }catch{
                    print(error.localizedDescription)
                }
                
                
            }, label: { Text("Edit").font(.title).foregroundColor(.black)})
            
            
            
            Button(action: {
                
                let config = Realm.Configuration(schemaVersion : 4)
                do{
                    let realm = try Realm(configuration: config)
                    let result = realm.objects(DatabaseElection.self)
                    
                    for i in result{
                        
                        try! realm.write {
                            realm.delete(i)}
                    
                }
                    
                }catch{
                    print(error.localizedDescription)
                }
                
                
            }, label: { Text("Delete All").font(.title).foregroundColor(.black)})
            
            Button(action: {
                          
                          let config = Realm.Configuration(schemaVersion : 4)
                          do{
                              let realm = try Realm(configuration: config)
                            let result = realm.objects(DatabaseElection.self).filter("election.@count > 0")
                              print(result)
                            var election_count:Int = 0
                            
                            for _ in result {
                                election_count += 1
                                print(election_count)
                            }
                            
                              
                              
                          }catch{
                              print(error.localizedDescription)
                          }
                          
                          
                      }, label: { Text("Print All").font(.title).foregroundColor(.black)})
            
        }
    }
}

struct ElectionEditView_Previews: PreviewProvider {
    static var previews: some View {
        ElectionEditView()
    }
}
