//
//  Quiz.swift
//  Clip
//
//  Created by Ryan on 09/11/2022.
//
//  Ryan Morgan

import SwiftUI
import WebKit

struct Quiz: View {
    //title which is passed through from contentview
    var title = String()
    //array of clips from a category. clipsFunny gets overwritten by whatever category gets passed from the contentview (it's a placeholder for when purely looking through the preview in xcode)
    @State var clipGroup = clipsFunny
    //get array of random numbers to randomise the order in which clips are shown
    @State var vids = randomVideos()
    //pre-define the number of clips shown as 2 - would never start off seeing 0 clips
    @State var clipCount = 2
    //array for storing clips the user chooses
    @State var chosenClips = [Int]()
    //keeps track of the rounds
    @State var roundCount = 1
    //defines the total number of clips for validation
    @State var totalClips = 8
    //lastClip1 and lastClip2 are for when the user selects the final clip and sends them to the final page. There are two because each card handles it separetely.
    @State var lastClip1 = false
    @State var lastClip2 = false
    //define maximum rounds for validation
    var maxRound = 3
    var body: some View {
        NavigationStack {
            //can see the tracking of the number of rounds and clips shown
            Text("Clips \(clipCount)/\(totalClips)     Round \(roundCount)/3")
        //discovered GeometryReader through John Sundell on the Swift by Sundell website and based the GeometryReader declaration and if statement from it - https://www.swiftbysundell.com/articles/switching-between-swiftui-hstack-vstack/
            GeometryReader { proxy in
                //if device is portrait/verticle
                if (proxy.size.width < proxy.size.height) {
                    //stack cards vertically
                    VStack{
                        //top clip card - pass pointers for variables through
                        CardView(clipGroup: $clipGroup,
                                 vids: $vids,
                                 clipCount: $clipCount,
                                 chosenClips: $chosenClips,
                                 roundCount: $roundCount,
                                 totalClips: $totalClips,
                                 lastClip1: $lastClip1,
                                 lastClip2: $lastClip2,
                                 number: 0,
                                 cardWidth:1.0,
                                 cardHeight:0.36,
                                 clipWidth:1.0,
                                 clipHeight:0.24)
                        //bottom clip card - pass pointers for variables through
                        CardView(clipGroup: $clipGroup,
                                 vids: $vids,
                                 clipCount: $clipCount,
                                 chosenClips: $chosenClips,
                                 roundCount: $roundCount,
                                 totalClips: $totalClips,
                                 lastClip1: $lastClip1,
                                 lastClip2: $lastClip2,
                                 number: 1,
                                 cardWidth:1.0,
                                 cardHeight:0.36,
                                 clipWidth:1.0,
                                 clipHeight:0.24)
                    }
                //otherwise if device is landscape/horizontal...
                } else {
                    //stack cards horizontally
                    HStack{
                        //left clip card - pass pointers for variables through
                        CardView(clipGroup: $clipGroup,
                                 vids: $vids,
                                 clipCount: $clipCount,
                                 chosenClips: $chosenClips,
                                 roundCount: $roundCount,
                                 totalClips: $totalClips,
                                 lastClip1: $lastClip1,
                                 lastClip2: $lastClip2,
                                 number: 0,
                                 cardWidth:0.45,
                                 cardHeight:0.65,
                                 clipWidth:0.45,
                                 clipHeight:0.36)
                        //right clip card - pass pointers for variables through
                        CardView(clipGroup: $clipGroup,
                                 vids: $vids,
                                 clipCount: $clipCount,
                                 chosenClips: $chosenClips,
                                 roundCount: $roundCount,
                                 totalClips: $totalClips,
                                 lastClip1: $lastClip1,
                                 lastClip2: $lastClip2,
                                 number: 1,
                                 cardWidth:0.45,
                                 cardHeight:0.65,
                                 clipWidth:0.45,
                                 clipHeight:0.36)
                        
                    }
                }
            }
            //when lastClip1 is true, go to final view and pass the clip as parameter
            .navigationDestination(isPresented: $lastClip1) { Final(favouriteClip: clipGroup[vids[0]]) }
            //when lastClip2 is true, go to final view and pass a different clip as parameter
            .navigationDestination(isPresented: $lastClip2) { Final(favouriteClip: clipGroup[vids[1]]) }
            
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(StackNavigationViewStyle())
        //fixes errors in ipad display and configures title bar
        
        
    }
    
}


struct Quiz_Previews: PreviewProvider {
    static var previews: some View {
        Quiz()
    }
}

struct CardView: View{
    //array of clips from a category - clipsFunny gets overwritten by whatever category gets passed from the contentview (it's a placeholder for when purely looking through the preview)
    @Binding var clipGroup: [Clip]
    //random numbers to randomise the order in which clips are shown
    @Binding var vids: [Int]
    //number of clips shown
    @Binding var clipCount: Int
    //array for storing clips the user chooses
    @Binding var chosenClips: [Int]
    //keeps track of the rounds
    @Binding var roundCount: Int
    //defines the total number of clips for validation
    @Binding var totalClips: Int
    //lastClip1 & lastClip2 are for when the user selects the final clip and sends them to the final page. There are two because each card handles it separetely.
    @Binding var lastClip1: Bool
    @Binding var lastClip2: Bool
    //define maximum rounds for validation
    var maxRound = 3
    //differentiates the different instances of the clip cards
    var number: Int
    //defines the size of the clip/card
    var cardWidth: CGFloat
    var cardHeight: CGFloat
    var clipWidth: CGFloat
    var clipHeight: CGFloat
    
    var body: some View {
        ZStack{
            //background of card
            Rectangle()
                .fill(Color.gray.opacity(0.25))
                .frame(width: UIScreen.main.bounds.width * cardWidth, height: UIScreen.main.bounds.height * cardHeight)
                .shadow(radius: 10)
            //clip title and channel name on card
            VStack{
                Text("\(clipGroup[vids[number]].title)")
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                Text("\(clipGroup[vids[number]].channel)")
                    .font(.system(size:14))
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.gray)
                
                //clip on card
                EmbedView(videoID: clipGroup[vids[number]].videoID)
                    .frame(width: UIScreen.main.bounds.width * clipWidth, height: UIScreen.main.bounds.height * clipHeight)
                
                //selection button - updates data on the progress of the quiz
                Button(action: {
                    if (vids.count > 2){
                        //add clip to array of chosen clips
                        chosenClips.append(vids[number])
                        //remove both indexes of clips that have been viewed
                        vids.remove(at: 0)
                        vids.remove(at: 0)
                        //if only two indexes are left...
                    } else if (vids.count == 2) {
                        //if final round...
                        if (roundCount == 3){
                            //if top or bottom clip...
                            if (number == 0){
                                //top clip is winning clip
                                lastClip1 = true
                            } else {
                                //bottom clip is winning clip
                                lastClip2 = true
                            }
                          //if not final round...
                        } else {
                            //add clip to array of chosen clips
                            chosenClips.append(vids[number])
                            //restore data for next round
                            vids = chosenClips
                            chosenClips = [Int]()
                            //go to next round
                            roundCount += 1
                            clipCount = 0
                            totalClips /= 2
                        }
                        
                    }
                    //another two clips have been seen
                    clipCount += 2
                }){
                    Text("Select Clip")
                }
                .background(.red)
                .foregroundColor(.white)
                .cornerRadius(6)
                .buttonStyle(.bordered)
            }
        }
    }
}

//iKh4ever Studio on YouTube provides a tutorial on how to embed YouTube videos https://www.youtube.com/watch?v=kkBB8afMliY (Helped me build this)
struct EmbedView: UIViewRepresentable{
    //id of clip that's passed into here
    let videoID: String
    
    //make a webview
    func makeUIView(context: Context) -> WKWebView{
        WKWebView()
    }
    
    //format URL and get clip to embed
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)?controls=1&modestbranding=1&version=3&fs=0&cc_load_policy=0&iv_load_policy=3&autohide=0&enablejsapi=1&widgetid=2") else {return}
        uiView.scrollView.isScrollEnabled = false
                uiView.load(URLRequest(url: youtubeURL))
    }
}
