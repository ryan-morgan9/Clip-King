//
//  ContentView.swift
//  Clip
//
//  Created by Ryan on 09/11/2022.
//
//  Ryan Morgan

import SwiftUI

struct ContentView: View {
    //keeps popover view closed until button is pressed
    @State private var presentPopover = false

    var body: some View {
        
        NavigationStack {
            //for each of the predefined categories...
            List(clipCategories) {category in
                //creates clickable categories to choose from
                NavigationLink(destination: Quiz(title:category.category, clipGroup: category.clipGroup)) {
                    //formatting the categories
                    HStack{
                        ZStack {
                            //Emoji for category
                            Text(category.emoji)
                                .font(.largeTitle)
                                .frame(width:60, height: 60)
                            //Define the red rounded-square border. Ale Patrón from medium has a tutorial on lists and navigation which taught me how to make borders https://medium.com/swlh/swiftui-tutorial-lists-and-navigation-16e1b4dbb98b
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.red, lineWidth: 3))
                        }
                        //place the name of the category next to the emoji
                        Text(category.category)
                    }
                }
                .navigationBarTitle("Categories")
                .navigationViewStyle(.stack)
            }
            //button which opens a popover view - explains how to play the quiz
            Button("How to play") {
                presentPopover = true //flip the var from false to true
            }
            //presentPopover being true triggers the popover view to open
            .popover(isPresented: $presentPopover) {
                //information symbol provided by iOS, it's red
                Image(systemName: "info.circle")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 70, height: 70)
                //Text which explains how the quiz works
                Text("Welcome to Clip King!")
                    .font(.headline)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(6)
                Text("This is a tournament-styled quiz app to discover your favourite clip for a category.")
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(6)
                Text("Select your desired category. Then, continually choose your favourite clip out of the two shown to you until only one clip remains!")
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(6)
                
                //define button which closes the view
                Button("Close") {
                    presentPopover = false //flip the var from true to false to close view
                }
                //styling for button
                .background(.red)
                .foregroundColor(.white)
                .cornerRadius(6)
                .buttonStyle(.bordered)
            }
            //styling for button
            .background(.red)
            .foregroundColor(.white)
            .cornerRadius(6)
            .buttonStyle(.bordered)
        }
        //change the style of list and hide back button
        .listStyle(PlainListStyle())
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
