//
//  test.swift
//  Clip
//
//  Created by Ryan on 09/11/2022.
//

import SwiftUI

struct test: View {
    @State var num = 1
    var body: some View {
        VStack{
            Text("\(num)")
            Button(action: {
                num+=1
            }){
                Text("Test")
            }
        }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
