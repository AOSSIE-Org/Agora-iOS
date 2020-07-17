//
//  CreateElection.swift
//  agora-ios
//
//  Created by Siddharth sen on 3/20/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI
import RealmSwift

struct CreateElection: View {
     @Binding var showCreateElectionView:Bool
    var body: some View {
        ZStack {
           
            VStack{
                Mid_Elections(showCreateElectionView: self.$showCreateElectionView).navigationBarTitle("New Election",displayMode: .inline)
            }
        }.navigationBarHidden(true)
    }
}


struct Mid_Elections: View{
    
    @State var ballot = ""
    @State var name:String = ""
    @State var description:String = ""
    @State var voterListVisibility:Bool = false
    @State var startingDate = Date()
    @State var endingDate = Date()
    @State var isInvite:Bool = false
    @State var ballotVisibility:String = "Ballots are visible to everyone with access to the election"
    @State var isRealTime:Bool = false
    
    @State var candidates:[String] = []
    @State var noVacancies:Int = 0
    @State var electionType:String = ""
    @State var isStart:Bool = false
    @State var isEnd:Bool = false
    @State var showBallotOptions:Bool = false
    @State var showAlgoCard:Bool = false
    @State var candidate:String = ""
    @State var activityShow:Bool = false
    @State var eventUpdateOverlayShow:Bool = false
    
    //Algorithm
    @State var selectedAlgo:String = "Select Algorithm"
    // Navigation
    @Binding var showCreateElectionView:Bool
    var body: some View {
        // For Date formatting
           let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        
        return ZStack {
            ZStack {
                VStack {
                    ZStack {
                        HStack(spacing:10) {
                                
                                Button(action: { self.showCreateElectionView.toggle() }
                                ){
                                    Image(systemName: "chevron.left").font(.title)
                                }.foregroundColor(.white)
                               Spacer()
                                    
                               
                                Button(action: {
                                    self.activityShow.toggle()
                                    // Upload to server
                                    let ballot = Ballot(voteBallot: "0", hash: "0")
                                    let election = Election(name: self.name, description: self.description, electionType: self.electionType, candidates: self.candidates, ballotVisibility: self.ballotVisibility, voterListVisibility: self.voterListVisibility, isInvite: self.isInvite, startingDate: self.startingDate.asString(), endingDate: self.endingDate.asString(), isRealTime: self.isRealTime, votingAlgo: self.selectedAlgo, noVacancies: self.noVacancies, ballot: [ballot])


                                    print(election.startingDate)
                                    DatabaseElectionManager.apiService.createNewElection(for: election, userXAuth: UserDefaults.standard.string(forKey: "userXAUTH")!) {

                                        //Update Indicator state
                                        self.activityShow = false
                                            
                                        // Show Success overlay and dismiss
                                        withAnimation(.easeInOut){
                                            self.eventUpdateOverlayShow.toggle()
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(900)) {
                                            self.eventUpdateOverlayShow = false
                                            
                                            // Navigate back to dashboard view
                                            self.showCreateElectionView.toggle()
                                        }
                                        
                                        // Sent
                                        print("Sent to Server successfully!")
                                    }
//
                                }, label: { Text("Save").font(.callout).foregroundColor(.white)})
                                
                        }.background(LinearGradient(gradient: Gradient(colors: [Color("Color2_2"), Color("Color2")]), startPoint: .bottom, endPoint: .top).frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height / 7 , alignment: .center).edgesIgnoringSafeArea(.top))
                        Text("Add Elections")
                                               .foregroundColor(.white)
                                               .fontWeight(.regular)
                                               .font(.title)
                    }
                    .padding()

                    ScrollView(.vertical, showsIndicators: false) {
                        
                        
                        VStack {
                            HStack {
                                Image(systemName: "list.dash").padding()
                                TextField("Title", text: $name)
                            }
                            Divider().frame(minWidth: 0, maxWidth: 320, alignment: .center)
                            HStack {
                                Image(systemName: "pin").padding()
                                Text(selectedAlgo).opacity(0.9)
                                Spacer()
                            }.onTapGesture {
                                // Show Algo card
                                self.showAlgoCard = true}
                            
                        }.background(Color(.white)).frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width * 0.9, alignment: .center).cornerRadius(10)
                        
                        
                        VStack {
                            HStack {
                                Image(systemName: "calendar").padding()
                                Button(action: {
                                    withAnimation(.spring()){
                                        self.showBallotOptions.toggle()
                                    }
                                }){
                                    HStack{
                                        Text("Ballot Visibility").foregroundColor(.primary)
                                        Spacer()
                                        Image(systemName: "chevron.down").padding()
                                            .rotationEffect(.init(degrees: self.showBallotOptions ? 180 : 0))
                                    }
                                
                                }
                            }
                            if showBallotOptions{
                                
                                ForEach(ballotOptions, id: \.self) { option in
                                    HStack {
                                        Button(action: {withAnimation(.spring()){self.ballotVisibility = option; self.showBallotOptions = false}}){
                                            HStack{
                                                Spacer()
                                                Text(option).fontWeight(.semibold).foregroundColor(.blue).padding(.vertical,10)
                                                Spacer()
                                                
                                                
                                            }
                                        }
                                        
                                    }
                                }
                                
                            }
                            if !showBallotOptions{
                                HStack {
                                Image(systemName: "rectangle.stack.person.crop").padding()
                                
                                Button(action: {self.voterListVisibility.toggle()}){
                                    HStack{
                                        Text("Voter List Visibility").foregroundColor(.primary)
                                        Spacer()
                                        Image(systemName: voterListVisibility ? "checkmark.square.fill": "square").resizable().foregroundColor(Color("Color2")).frame(width: 16, height: 16, alignment: .trailing).padding()
                                        
                                    }
                                }
                                
                            }
                            VStack{
                                Divider().frame(minWidth: 0, maxWidth: 320, alignment: .center)
                                VStack {
                                    
                                    if(self.isStart){
                                        toggleButton(givenStateObject: $isStart, outputString: "Done")
                                    }else if(self.isStart == false){
                                        HStack{Image(systemName: "clock").padding()
                                        toggleButton(givenStateObject: $isStart, outputString: "Start")
                                        Text(formatter1.string(from: startingDate)).padding(.horizontal,10)}
                                    }
                                     
                                    
                                    
                                    VStack{
                                        if(self.isStart){
                                            DatePicker("start", selection: $startingDate, in: Date()...).labelsHidden()
                                        }
                                    }
                                    
                                    
                                }
                                
                                //For End Date
                                Divider().frame(minWidth: 0, maxWidth: 320, alignment: .center)
                                VStack {
                                    
                                    if(self.isEnd){
                                        toggleButton(givenStateObject: $isEnd, outputString: "Done")
                                    }else if(self.isEnd == false){
                                        HStack{Image(systemName: "clock").padding().rotationEffect(Angle(degrees: 180))
                                        toggleButton(givenStateObject: $isEnd, outputString: "End")
                                            Text(formatter1.string(from: endingDate)).padding(.horizontal,10)}
                                    }
                                        
                                     
                                    
                                    VStack{
                                        
                                        if(self.isEnd){
                                            DatePicker("End", selection: $endingDate, in: Date()...).labelsHidden()
                                        }
                                        
                                    }
                                    
                                }
                            }
                            
                            
                           
                            Divider().frame(minWidth: 0, maxWidth: 320, alignment: .center)
                            HStack {
                                Image(systemName: "globe").padding()
                                // isAllDay checkbox
                                Button(action: {self.isRealTime.toggle()}){
                                    HStack{
                                        Text("Real Time").foregroundColor(.primary)
                                        Spacer()
                                        Image(systemName: isRealTime ? "checkmark.square.fill": "square").resizable().foregroundColor(Color("Color2")).frame(width: 16, height: 16, alignment: .trailing).padding()
                                        
                                    }
                                }
                                
                            }}
                            Divider().frame(minWidth: 0, maxWidth: 320, alignment: .center)
                            HStack {
                                Image(systemName: "bolt").padding()
                               
                                Button(action: {self.isInvite.toggle()}){
                                    HStack{
                                        Text("Invite").foregroundColor(.primary)
                                        Spacer()
                                        Image(systemName: isInvite ? "checkmark.square.fill": "square").resizable().foregroundColor(Color("Color2")).frame(width: 16, height: 16, alignment: .trailing).padding()
                                        
                                    }
                                }
                                
                            }
                            Divider().frame(minWidth: 0, maxWidth: 320, alignment: .center)
                            HStack {
                                
                                Image(systemName: "wrench").padding()
                                TextField("Election Type", text: $electionType).opacity(0.9)
                            }
                            
                            
                        }.background(Color(.white)).frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width * 0.9, alignment: .center).cornerRadius(10)
          
                        VStack {
                            HStack {
                                Image(systemName: "list.dash").padding()
                                TextField("Description", text: $description)
                            }
                            Divider()
                            HStack {
                                Image(systemName: "person.2").padding()
                                TextField("Candidates", text: $candidate).opacity(0.9)
                            }
                            
                            // Show list of candidates
                            
                                ForEach(candidates, id: \.self){ candi in
                                    HStack{
                                        Text(candi).foregroundColor(.primary)
                                        Spacer()
                                        Image(systemName: "trash").onTapGesture {
                                            self.candidates.removeAll(where: { $0 == candi } )
                                        }
                                    }.padding(.horizontal,15)
                                }
                            
                            
                            Button(action: {self.candidates.append(self.candidate);self.candidate = "";}){
                                Text("Add Candidate").foregroundColor(.black).frame(width: UIScreen.main.bounds.width * 0.5,height: UIScreen.main.bounds.height * 0.054)
                            }.foregroundColor(.white)
                                .background(Color.yellow)
                                .cornerRadius(20)
                            
                           
                            
                        }.background(Color(.white)).frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width * 0.9, alignment: .center).cornerRadius(10)
                        
                    }
                }.background(Color(.secondarySystemBackground)).edgesIgnoringSafeArea(.bottom)
            }
            
            if self.showAlgoCard{
                AlgoCardView(showCard: $showAlgoCard, selectedAlgo: $selectedAlgo)
            }
            
            if self.activityShow == true{
                ActivityIndicator()
            }
            
            if self.eventUpdateOverlayShow == true{
              
                Color.black.opacity(0.18).edgesIgnoringSafeArea(.all)

                EventUpdateOverlay()
            }
        }

    }
    
}


struct toggleButton:View {
    @Binding var givenStateObject:Bool
    var outputString:String
    
    var body: some View{
        Button(action: {
            self.givenStateObject.toggle()
        }) {
            Spacer()
            Text(outputString).foregroundColor(.blue)
            Spacer()
        }
    }
}

struct AlgoCardView : View{
    @Binding var showCard:Bool
    @State var color = Color.black.opacity(0.7)
    @Binding var selectedAlgo:String
    
    var body: some View{
        GeometryReader{_ in
            VStack{
                HStack{
                    Text("Select Algorithm")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                    Spacer()
                }.padding(.horizontal,20)
                Picker("",selection: self.$selectedAlgo) {
                    ForEach(votingAlgorithmsList,id: \.self) { value in
                        Text(value)
                        .foregroundColor(self.color)
                        .padding(.top,5)
                        .padding(.horizontal,20)
                   }
                }.labelsHidden()
                
                Button(action:{self.showCard = false}){
                    Text("Ok")
                        .foregroundColor(.black)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                }.background(Color.yellow)
                    .cornerRadius(8)
                    .padding(.top,25)
            }
            .padding(.vertical,25)
            .frame(width: UIScreen.main.bounds.width - 50)
            .background(Color.white)
            .cornerRadius(10)
        }
        .background(Color.black.opacity(0.4))
    }
}



struct CreateElection_Previews: PreviewProvider {
    static var previews: some View {
        CreateElection(showCreateElectionView: .constant(false))
    }
}

var votingAlgorithmsList = ["Oklahoma" ,"RangeVoting" ,"RankedPairs" ,"Satisfaction Approval Voting","Sequential Proportional Approval Voting","SmithSet","Approval","Baldwin" ,"Exhaustive ballot with dropoff","Uncovered Set","Copeland" ,"Minimax Condorcet","RandomBallot","Borda" ,"Kemeny-Young" ,"Nanson" ,"InstantRunoff2Round" ,"Contingent Method"]
