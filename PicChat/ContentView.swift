//
//  ContentView.swift
//  PicChat
//
//  Created by 森下翔登 on 2024/02/14.
//

import SwiftUI

struct ContentView : View {
    @State var isShowChatView = false
    var body: some View {
        VStack {
            Text("PICTCHAT")
            Button{
                isShowChatView = true
            }
                   label: {
                Text("入室する")
                    .foregroundColor(.orange)
                    .padding()
                    .background(.fill)
                    .cornerRadius(10)
            }.sheet(isPresented: $isShowChatView){
                    ChatView()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews : some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
