//
//  OffsetModifier.swift
//  OffsetModifier
//
//  Created by nyannyan0328 on 2021/09/09.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    @Binding var offset : CGFloat
    @State var startOffset : CGFloat = 0
    func body(content: Content) -> some View {
        content
            .overlay(
            
                GeometryReader{proxy in
                    
                    
                    Color.clear
                        .preference(key: offsetKey.self, value: proxy.frame(in: .global).minY)
                }
            
            )
            .onPreferenceChange(offsetKey.self) { offset in
                
                
                if startOffset == 0{
                    
                    startOffset = offset
                    
                }
                
                self.offset = offset - startOffset
                
              
            }
    }
}

struct OffsetModifier_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct offsetKey : PreferenceKey{
    
    static var defaultValue:CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        
        value = nextValue()
    }
    
}
