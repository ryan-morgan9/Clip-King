//
//  Final.swift
//  Clip
//
//  Created by Ryan on 03/01/2023.
//
//  Ryan Morgan

import SwiftUI
//ConfettiSwiftUI (author:simibac) package sourced from GitHub https://github.com/simibac/ConfettiSwiftUI
import ConfettiSwiftUI

struct Final: View {
    //stores the favourite clip that was found
    @State var favouriteClip = Clip(title: String(), channel: String(), videoID: String())
    //changing this triggers confetti animation
    @State var counter: Int = 0
    //go back to categories if true
    @State var returnCat = false
    var body: some View {
        NavigationStack{
            VStack{
                //presenting...
                Text("Finished!")
                    .font(.largeTitle)
                    .bold()
                
                Text("Your favourite clip is...")
                
                //discovered GeometryReader through John Sundell on the Swift by Sundell website and based the GeometryReader declaration and if statement from it - https://www.swiftbysundell.com/articles/switching-between-swiftui-hstack-vstack/
                GeometryReader { proxy in
                    //if device is portrait/verticle
                    if proxy.size.width < proxy.size.height  {
                        VStack{
                            //card formatted for portrait
                            FinalCardView(favouriteClip:$favouriteClip,
                                          counter:$counter,
                                          cardWidth:1.0,
                                          cardHeight:0.4,
                                          clipWidth:1.0,
                                          clipHeight:0.24)
                            //define button that goes back to the list of categories
                            Button(action:{
                                returnCat = true
                            }
                            ){
                                Text("Back to Categories")
                            }
                            //go to view when true
                            .navigationDestination(isPresented: $returnCat) { ContentView() }
                            .background(.red)
                            .foregroundColor(.white)
                            .cornerRadius(6)
                            .buttonStyle(.bordered)
                            .navigationBarBackButtonHidden()
                        }
                        
                    //if device is landscape/horizontal
                    } else {
                        VStack{
                            //card formatted for landscape
                            FinalCardView(favouriteClip:$favouriteClip,
                                          counter:$counter,
                                          cardWidth:0.9,
                                          cardHeight:0.57,
                                          clipWidth:0.9,
                                          clipHeight:0.34)
                            //define button that goes back to the list of categories
                            Button(action:{
                                returnCat = true
                            }
                            ){
                                Text("Back to Categories")
                            }
                            //go to view when true
                            .navigationDestination(isPresented: $returnCat) { ContentView() }
                            .background(.red)
                            .foregroundColor(.white)
                            .cornerRadius(6)
                            .buttonStyle(.bordered)
                            .navigationBarBackButtonHidden()
                        }
                    }
                }
            }
            .confettiCannon(counter: $counter, confettiSize: 50, repetitions: 3, repetitionInterval: 0.7)
            //configuration of confetti cannon
        }
    }
    
}




struct FinalCardView: View{
    //pointers of clip and counter vars from parent view
    @Binding var favouriteClip: Clip
    @Binding var counter: Int
    //defines dimenstions of clip and card
    var cardWidth: CGFloat
    var cardHeight: CGFloat
    var clipWidth: CGFloat
    var clipHeight: CGFloat
    
    var body: some View {
        ZStack{
            //background of clip card
            Rectangle()
                .fill(Color.gray.opacity(0.25))
                .frame(width: UIScreen.main.bounds.width * cardWidth, height: UIScreen.main.bounds.height * cardHeight)
                .shadow(radius: 10)
            VStack{
                //clip and channel name
                Text("\(favouriteClip.title)")
                    .font(.title2)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(favouriteClip.channel)")
                    .font(.system(size:14))
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.gray)
                //embedded clip
                EmbedView(videoID: favouriteClip.videoID)
                    .frame(width: UIScreen.main.bounds.width * clipWidth, height: UIScreen.main.bounds.height * clipHeight)
                //share button for sharing clip
                ShareLink(item: URL(string: "https://www.youtube.com/watch?v=\(favouriteClip.videoID)")!)
                    .foregroundColor(.red)
                    .onAppear{
                        //this triggers the confetti - triggers as the page is shown
                        counter += 1
                    }
            }
        }
    }
}

struct Final_Previews: PreviewProvider {
    static var previews: some View {
        Final()
    }
}
