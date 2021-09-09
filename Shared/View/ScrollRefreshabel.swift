//
//  ScrollRefreshabel.swift
//  ScrollRefreshabel
//
//  Created by nyannyan0328 on 2021/09/09.
//

import SwiftUI

struct ScrollRefreshabel<Content : View>: View {
    
    var content : Content
    var onReflesh : () async ->()
    
    init(title : String,tintColor : Color,@ViewBuilder content : @escaping()->Content,onReflesh : @escaping() async -> ()) {
        
        self.content = content()
        self.onReflesh = onReflesh
        
        let refreshController = UIRefreshControl.appearance()
        
        refreshController.bounds = CGRect(x: refreshController.bounds.origin.x, y: -(350 - getSafeArea().top) + refreshController.bounds.origin.y, width: refreshController.bounds.width, height: refreshController.bounds.height)
        
        UIRefreshControl.appearance().attributedTitle = NSAttributedString(string: title)
        
        UIRefreshControl.appearance().tintColor  = UIColor(tintColor)
        
        
    }
    
    
    
    
    var body: some View {
        List{
            
            content
                .listItemTint(.clear)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            
            
        }
        .listStyle(.plain)
        .refreshable {
            await onReflesh()
        }
    }
}

struct ScrollRefreshabel_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
