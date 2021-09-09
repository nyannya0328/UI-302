//
//  Home.swift
//  Home
//
//  Created by nyannyan0328 on 2021/09/09.
//

import SwiftUI

struct Home: View {
    @State var offset : CGFloat = 0
    var body: some View {
        ZStack(alignment:.top){
            
            ZStack{
                
                Image("pic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getScreenBounds().width, height: 300,alignment: .bottom)
                    .clipShape(
                    
                        CustomCorner(corner: [.bottomLeft], radi: getRadius())
                    
                    )
                
                    .opacity(1 + getProgress())
                CustomCorner(corner: [.bottomLeft], radi: getRadius())
                    .fill(.ultraThinMaterial)
                
                
                let progress = -getProgress() < 0.4 ? getProgress() : -0.4
                
                VStack(alignment : .leading,spacing:10){
                    
                    Image("profile")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .scaleEffect(1 + progress * 1.3,anchor: .bottomLeading)
                    
                    Text("My **BOSS**")
                        .font(.title2)
                        .foregroundColor(.white)
                        .strikethrough()
                        .scaleEffect(1 + progress,anchor: .bottomTrailing)
                        .offset(x: progress * -20, y: progress * 130)
                    
                    Text("SORRY")
                        .font(.title2.weight(.thin))
                        .scaleEffect(1 + progress,anchor: .trailing)
                        .offset(x: progress * -250, y: progress * 200)
                    
                    
                }
                .padding(15)
                .padding(.bottom,30)
                .offset(y: progress * -200)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                 
                  
                
                
            }
            .frame(height: 350)
            .offset(y: getOffset())
            .zIndex(1)
            
            
            ScrollRefreshabel(title: "Pull to Refelsh", tintColor: .primary) {
                
                VStack(spacing:15){
                    
                    
                    
                    ForEach(1...6,id:\.self){index in
                        
                        Image("p\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: getScreenBounds().width - 20, height: 250)
                            .cornerRadius(15)
                        
                        
                    }
                }
                .padding()
                .padding(.top,350)
                .padding(.top,-getSafeArea().top)
                .modifier(OffsetModifier(offset: $offset))
                
            } onReflesh: {
                
                await Task.sleep(2_000_000_000)
                
                
                
            }

            
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    func getOffset()->CGFloat{
        
        
        let checkOffset = -offset < (280 - getSafeArea().top) ? offset : -(280 - getSafeArea().top)
        
        return offset < 0 ? checkOffset : 0
        
    }
    func getProgress()->CGFloat{
        
        let topHight = (280 - getSafeArea().top)
        
        let progress = getOffset() / topHight
        
        return progress
        
        
    }
    
    func getRadius()->CGFloat{
        
        
        
        
        let radius = getProgress() * 45
        
        return 45 + radius
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}

extension View{
    
    func getScreenBounds()->CGRect{
        
        return UIScreen.main.bounds
    }
    
    func getSafeArea()->UIEdgeInsets{
        
        let null = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return null
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            
            return null
        }
        
        return safeArea
        
        
    }
    
    
}


