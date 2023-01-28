//
//  Home.swift
//  TaskBully
//
//  Created by Bob  Jones on 2023-01-28.
//

import SwiftUI

struct Home: View {
    // Mark: Animation pros
    @State var currentItem: ColorValue?
    @State var expandCard: Bool = false
    @State var moveCardDown: Bool = false
    @State var animateContent: Bool = false
    
    // Matched Geo NameSpace
    @Namespace var animation
    
    
    var body: some View {
        GeometryReader{ proxy in
            let size = proxy.size
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 8){
                    ForEach(colors){color in
                        CardView(item: color,rectSize: size)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 15)
            }
            .overlay {
                if let currentItem,expandCard{
                    DetailView(item: currentItem, rectSize: size)
                        .transition(.asymmetric(insertion: .identity, removal: .offset(y:10)))
                }
            }
        }
        .frame(width:370, height: 690)
        .preferredColorScheme(.light)
    }
    
    
    @ViewBuilder
    func DetailView(item: ColorValue, rectSize: CGSize) -> some View{
        ColorView(item: item, rectSize: rectSize)
            .ignoresSafeArea()
            .overlay(alignment: .top) {
                ColorDetails(item: item, rectSize: rectSize)
            }
            .overlay(content: {
                DetailViewContent(item: item)
            })
    }
    
    @ViewBuilder
    func DetailViewContent(item: ColorValue) -> some View{
        VStack(spacing: 0){
            Rectangle()
                .fill(.white)
                .frame(height: 1)
                .scaleEffect(x: animateContent ? 1 : 0.0001, anchor: .leading)
                .padding(.top,80)
            VStack(spacing: 30){
                CustomProgressView(value: 0.5, label: "Red")
                CustomProgressView(value: 0.5, label: "Blue")
                CustomProgressView(value: 0.5, label: "Green")
            }
            .padding(15)
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .environment(\.colorScheme, .dark)
            }
            .opacity(animateContent ? 1 : 0)
            .offset(y: animateContent ? 0 : 100)
            //slight delay
            .animation(.easeInOut(duration: 0.4).delay(animateContent ? 0.2 : 0), value: animateContent)
            .padding(.top,30)
            .padding(.horizontal,20)
            .frame(maxHeight: .infinity,alignment: .top)
            
            HStack(spacing: 15){
                Text("Start")
                    .fontWeight(.semibold)
                    .padding(.vertical,20)
                    .padding(.horizontal,30)
                    .background {
                        Capsule()
                            .fill(.white)
                    }
                    .onTapGesture {
                        print("make this button do something")
                    }
                
                Text("Go Back")
                    .fontWeight(.semibold)
                    .padding(.vertical,20)
                    .padding(.horizontal,30)
                    .background {
                        Capsule()
                            .fill(.white)
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)){
                            animateContent = false
                        }
                        // slight delay for finishing the naimate content
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                            withAnimation(.easeInOut(duration: 0.4)){
                                expandCard = false
                                moveCardDown = false
                            }
                        }
                    }
            }
            .padding(.bottom,30)
            .opacity(animateContent ? 1 : 0)
            .offset(y: animateContent ? 0 : 100)
            //slight delay
            .animation(.easeInOut(duration: 0.4).delay(animateContent ? 0.25 : 0), value: animateContent)
            
        }
        .padding(.horizontal,15)
        .frame(maxHeight: .infinity,alignment: .top)
        .onAppear {
            withAnimation(.easeInOut.delay(0.2)){
                animateContent = true
            }
        }
    }
    
    
    @ViewBuilder
    func CardView(item: ColorValue, rectSize: CGSize) -> some View{
        let tappedCard = item.id == currentItem?.id && moveCardDown
        
        if !(item.id == currentItem?.id && expandCard){
            ColorView(item: item, rectSize: rectSize)
                .overlay(content: {
                    ColorDetails(item: item, rectSize: rectSize/*CGSize(width: 1, height: 1)*/)
                })
                .frame(height: 100)
                .contentShape(Rectangle())
                .offset(y: tappedCard ? 30 : 0)
                .zIndex(tappedCard ? 100 : 0)
                .onTapGesture {
                    currentItem = item
                    withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.4)){
                            moveCardDown = true
                    }
                    
                    //after delay start animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.22){
                        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 1, blendDuration: 1)){
                            expandCard = true
                        }
                    }
                }
        }else{
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 100)
        }
        
    }
    
    @ViewBuilder
    func ColorView(item: ColorValue, rectSize: CGSize) -> some View{
        Rectangle()
            .overlay {
                Rectangle()
                    .fill(item.color.gradient)
            }
            .overlay {
                Rectangle()
                    .fill(item.color.opacity(0.5).gradient)
                    .rotationEffect(.init(degrees: 180))
            }
            .matchedGeometryEffect(id: item.id.uuidString, in: animation)
    }
    
    // Color Details
    @ViewBuilder
    func ColorDetails(item: ColorValue, rectSize: CGSize)-> some View{
        HStack{
            Text("#\(item.colorCode)")
                .font(.title.bold())
                .foregroundColor(.white)
            
            Spacer()
            
            VStack(alignment: .leading,spacing: 4) {
                Text(item.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Text("Hexadecimal")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }
            .padding(20)
        }
        .padding([.leading,.vertical],15)
        .matchedGeometryEffect(id: item.id.uuidString + "DETAILS", in: animation)
    }
    
    
    @ViewBuilder
    func CustomProgressView(value: CGFloat,label: String) -> some View{
        HStack(spacing: 15){
            Text(label)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            GeometryReader{
                let size = $0.size
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(.black.opacity(0.75))
                    
                    Rectangle()
                        .fill(.white)
                        .frame(width: animateContent ? size.width * value : 0)
                }
            }
            .frame(height: 8)
            
            Text("\(Int(value * 255.0))")
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
    }
    
    
}
