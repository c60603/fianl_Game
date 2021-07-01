//
//  LoginView.swift
//  fianl_Game
//
//  Created by 陳奇松 on 2021/6/18.
//

import SwiftUI
import FirebaseAuth
import AVFoundation

struct LoginView: View {
    @Binding var currentPage:pages
    @Binding var playerAccound: String
    @Binding var name: String
    @Binding var date:Date
    @Binding var showEidtorView:Bool
    @Binding var image:UIImage?
    @State private var playerPassword = ""
    @State private var showAlert = false
    @State private var alertMessage = "歡迎～請先註冊～"
    @State var showregisteView = false
    @State private var showPassword = false
    @State private var showpasswords = "eye.slash"
    @ObservedObject  var firebaseData : FirebaseData
    
    //音效處理：背景音樂播放的切換
    static var bgQueuePlayer = AVQueuePlayer()
    
    static var bgPlayerLooper: AVPlayerLooper!
    
    static func setupBgMusic() {
        guard let url = Bundle.main.url(forResource: "背景音樂", withExtension:"mp3")
        else {
            fatalError("Failed to find sound file.")
            
        }
        let item = AVPlayerItem(url: url)
        bgPlayerLooper = AVPlayerLooper(player: bgQueuePlayer, templateItem: item)
    }
    
    //這裡是按下登入後會跑得function ，記得直接登入做的function這裡也須要有。
    func login(playerAccoundLogin:String, playerPasswordLogin:String) {
        Auth.auth().signIn(withEmail: playerAccound, password: playerPassword) { result, error in
             guard error == nil else {
                if playerAccound.isEmpty || playerPassword.isEmpty {
                    alertMessage = "請輸入帳號/密碼"
                    showAlert = true
                }
                print(error?.localizedDescription)
                return
             }
            fetchPlayers(email: playerAccound){ result in
                switch result {
                    case .success(let player):
                        firebaseData.player = player
                        
                    case .failure(let error):
                        print(error)
                    break
                }
            }
            fetchPlayersOnce(email: playerAccound){ result in
                switch result {
                    case .success(let playerOnce):
                        firebaseData.playerOnce = playerOnce
                        name = playerOnce.playername
                        date = playerOnce.joinDate
                    case .failure(let error):
                        print(error)
                    break
                }
            }
            fetchPlayersPhoto(email: playerAccound){ result in
                switch result {
                    case .success(let playerPhoto):
                        downloadUserImage(str:"role", url: playerPhoto.photoURL){ result in
                            switch result {
                            case .success(let downloadImage):
                                image = downloadImage
                            case .failure(_):
                                break
                            }
                        }
                        
                    case .failure(let error):
                        print(error)
                    break
                }
            }
            showEidtorView = false
            currentPage = pages.PlayerWaitView
           
        }
    }
    var body: some View {
        VStack{
            Spacer()
            Text("超級大富翁")
                .foregroundColor(.black)
                .font(.body)
                .fontWeight(.heavy)
                .padding(.horizontal, 6.0)
                .background(Color.white)
                .overlay(Rectangle().stroke(Color.black, lineWidth: 3))
                .scaleEffect(2.5)
                .offset(x: 10, y: -15)
                .shadow(radius: 30)
                //.background(
                    //Image("monopoly") //圖片還沒加哦
                        //.resizable()
                        //.scaledToFit()
                        //.rotationEffect(Angle(degrees: -30))
                        //.frame(width: 80, height: 80, alignment: .center)
                        //.offset(x: -185, y: -70)
                //)
                //.background(
                   // Image("monopoly") //圖片還沒加哦
                     //   .resizable()
                       // .scaledToFit()
                        //.rotationEffect(Angle(degrees: 30))
                        //.frame(width: 90, height: 90, alignment: .center)
                        //.offset(x: 190, y: -70)
                //)
            
            HStack{
                Text("帳號：")
                    .font(.title)
                    .padding(.leading, 100.0)
                TextField("********@email.com", text: $playerAccound)
                    .font(.title)
                    .background(
                        Rectangle()
                            .stroke()
                    )
            }
            .padding(.top, 35)
            HStack{
                Text("密碼：")
                    .font(.title)
                    .padding(.leading, 100.0)
                if showPassword {
                    TextField("請輸入至少六位數密碼", text: $playerPassword)
                        .font(.title)
                        .background(
                            Rectangle()
                                .stroke()
                        )
                } else {
                    SecureField("請輸入至少六位數密碼", text: $playerPassword)
                        .font(.title)
                        .background(
                            Rectangle()
                                .stroke()
                        )
                }
                Image(systemName: showpasswords)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        showPassword.toggle()
                        if showPassword {
                            showpasswords = "eye"
                        }else{
                            showpasswords = "eye.slash"
                        }
                    }
            }
            
            
            HStack{
                Spacer()
                Button(action: {
                    login(playerAccoundLogin: playerAccound, playerPasswordLogin: playerPassword)
                }, label: {
                    Text("登入")
                        .font(.title)
                        .foregroundColor(.white)
                })
                .padding(.all, 10.0)
                .background(
                    Capsule()
                        .foregroundColor(.red)
                )
                Spacer()
                Button(action: {
                    showregisteView = true
                }, label: {
                    Text("註冊")
                        .font(.title)
                        .foregroundColor(.white)
                })
                .padding(.all, 10.0)
                .background(
                    Capsule()
                        .foregroundColor(.purple)
                )
                Spacer()
            }
            .offset(y: 30)
            Spacer()
            
        }
        .padding()
        .fullScreenCover(isPresented: $showregisteView, content: {
            RegisteView(currentpage: $currentPage, showEidtorView: $showEidtorView, playerName: $name, playerAccoundRegiste: $playerAccound, showRegisteView: $showregisteView)
        })
        .alert(isPresented: $showAlert, content: {() -> Alert in
            let answer = alertMessage
            return Alert(title: Text(answer))
        })
       
        .onAppear(){
            AVPlayer.setupBgMusic()
            AVPlayer.bgQueuePlayer.play()
            AVPlayer.bgQueuePlayer.volume = 0.3
            if let user = Auth.auth().currentUser {
                print("\(user.uid) login")
                playerAccound = user.email!
                fetchPlayers(email: playerAccound){ result in
                    switch result {
                        case .success(let player):
                            firebaseData.player = player
                            print("Datashow:",firebaseData.player)
                        case .failure(let error):
                            print(error)
                        break
                    }
                }
                fetchPlayersOnce(email: playerAccound){ result in
                    switch result {
                        case .success(let playerOnce):
                            name = playerOnce.playername
                            date = playerOnce.joinDate
                            firebaseData.playerOnce = playerOnce
                        case .failure(let error):
                            print(error)
                        break
                    }
                }
                fetchPlayersPhoto(email: playerAccound){ result in
                    switch result {
                        case .success(let playerPhoto):
                            downloadUserImage(str:"role", url: playerPhoto.photoURL){ result in
                                switch result {
                                case .success(let downloadImage):
                                    image = downloadImage
                                case .failure(_):
                                    break
                                }
                            }
                            
                        case .failure(let error):
                            print(error)
                        break
                    }
                }
                showEidtorView = false
                currentPage = pages.PlayerWaitView
            } else {
                print("not login")
            }
        }
        .background(
            Image("monopoly")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(currentPage: .constant(pages.LoginView), playerAccound: .constant(""), name: .constant(""), date: .constant(Date()), showEidtorView: .constant(false), image: .constant(UIImage(systemName: "photo")), firebaseData: FirebaseData())
            .previewLayout(.fixed(width: 651, height: 297))
    }
}

