//
//  ContentView.swift
//  PicChat
//
//  Created by 森下翔登 on 2024/02/14.
//

import SwiftUI

struct ContentView: View {
    @State var userName = ""

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "figure.fall")
                    .imageScale(.large)
                    .font(.system(size: 30)) // 画像サイズを調整
                Text("PICOCHAT")
                    .font(.largeTitle) // タイトルのフォントサイズを調整
                NavigationLink(destination: NameInputView(userName: $userName)) {
                    Text("入室する")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

struct NameInputView: View {
    @Binding var userName: String
    @State private var localName = "" // ユーザーネームの入力フィールドにバインドするState

    var body: some View {
        NavigationView { // NavigationViewで画面遷移のコンテナを定義
            VStack {
                Image(systemName: "globe")
                    .foregroundColor(.orange)
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Spacer()
                Text("Enter your username:")
                TextField("Username", text: $localName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200)
                    .padding()
                NavigationLink(destination: ChatView(userName: localName)) { // ボタンをNavigationLinkに変更
                    Text("START")
                        .padding()
                        .background(.orange)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .disabled(localName.isEmpty) // ユーザーネームが入力されていない場合はボタンを無効にする
                .disabled(localName.count > 15)
                .buttonStyle(PlainButtonStyle()) // NavigationLinkのデフォルトのボタンスタイルを無効にする
                Spacer() // ボタンの下にスペーサーを挿入
            }
            .padding()
        }
    }
}

// 他のプレビューなどは省略


struct ContentView_Previews: PreviewProvider {
    static var previews : some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
