//
//  Home.swift
//  TaskBully
//
//  Created by Bob  Jones on 2023-01-28.
//

import SwiftUI

struct Home: View {
    // Mark: Animation pros
    @State var currentItem: TBTask?
    @State var expandCard: Bool = false
    @State var moveCardDown: Bool = false
    @State var animateContent: Bool = false
    @State var showModal: Bool = false
    @State var showAddButton: Bool = true
    @Binding var allowAlerts: Bool
    @EnvironmentObject var user: User
    
    // Matched Geo NameSpace
    @Namespace var animation
    
    
    var body: some View {
        ZStack {
            //BACKGROUND
            Color(hex: 0x171717)
            
            VStack {
                GeometryReader{ proxy in
                    let size = proxy.size
                    
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing: 8){
                            if showModal == false {
                                ForEach(tasks){task in
                                    CardView(item: task, rectSize: size)
                                }
                            }
                            
                            if showModal == true {
                                ForEach(tasks){task in
                                    CardView(item: task, rectSize: size)
                                }
                            }
                            
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 15)
                    }
                    .overlay {
                        if let currentItem, expandCard{
                            DetailView(item: currentItem, rectSize: size)
                                .transition(.asymmetric(insertion: .identity, removal: .offset(y:10)))
                        }
                    }
                }
                .frame(width:370, height: 690)
                .preferredColorScheme(.light)
                
                if showAddButton {
                    Button(action: {
                        showModal = true
                    }) {
                        Text("Add Task")
                            .font(.title3.bold())
                        Image(systemName: "calendar.badge.plus")
                    }
                    .tint(.green)
                    .padding(.top, 10)
                    .buttonStyle(.borderedProminent)
                }
                
            }
            .sheet(isPresented: $showModal, content: {AddTaskView(showModal: self.$showModal)})
        }
        .ignoresSafeArea()
    }
    
    
    @ViewBuilder
    func DetailView(item: TBTask, rectSize: CGSize) -> some View {
        ColorView(item: item, rectSize: rectSize)
        //.ignoresSafeArea()
            .overlay(alignment: .top) {
                ColorDetails(item: item, rectSize: rectSize)
            }
            .overlay(content: {
                DetailViewContent(item: item)
            })
    }
    
    @ViewBuilder
    func DetailViewContent(item: TBTask) -> some View{
        VStack(){
            //BACK BUTTON
            HStack(spacing: 15){
                Button(action: {
                    showAddButton = true
                    withAnimation(.easeInOut(duration: 0.2)){
                        animateContent = false
                    }
                    // slight delay for finishing the animate content
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                        withAnimation(.easeInOut(duration: 0.4)){
                            expandCard = false
                            moveCardDown = false
                        }
                    }
                }) {
                    Image(systemName: "arrow.left.circle")
                    Text("Back")
                }
                .buttonStyle(.bordered)
                .tint(.white)
                
                Spacer()
            }
            .padding([.bottom, .top], 30)
            .opacity(animateContent ? 1 : 0)
            .offset(y: animateContent ? 0 : 10)
            //slight delay
            .animation(.easeInOut(duration: 0.4).delay(animateContent ? 0.25 : 0), value: animateContent)
            
            //TASK DATA
            Rectangle()
                .fill(.white)
                .frame(height: 1)
                .scaleEffect(x: animateContent ? 1 : 0.0001, anchor: .leading)
                .padding(.top,20)
            
            Text(item.taskDescription)
                .padding(20)
                .foregroundColor(.white)
                .padding(.bottom,30)
                .opacity(animateContent ? 1 : 0)
                .offset(y: animateContent ? 8 : 50)
            //slight delay
                .animation(.easeInOut(duration: 0.4).delay(animateContent ? 0.25 : 0), value: animateContent)
            VStack(spacing: 30){
                AngerLevelBar(value: angerToCG(level: user.preferredAnger), label: "Intensity:")
            }
            .padding(15)
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .environment(\.colorScheme, .dark)
            }
            .opacity(animateContent ? 1 : 0)
            .offset(y: animateContent ? 8 : 50)
            //slight delay
            .animation(.easeInOut(duration: 0.4).delay(animateContent ? 0.2 : 0), value: animateContent)
            .padding(.top,30)
            .padding(.horizontal,20)
            .frame(maxHeight: .infinity,alignment: .top)
            
            //TASK TIMER
            TaskTimerView(allowAlerts: $allowAlerts)
                .padding(.bottom,30)
                .opacity(animateContent ? 1 : 0)
                .offset(y: animateContent ? 8 : 50)
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
    func CardView(item: TBTask, rectSize: CGSize) -> some View{
        let tappedCard = item.id == currentItem?.id && moveCardDown
        
        if !(item.id == currentItem?.id && expandCard){
            ColorView(item: item, rectSize: rectSize)
                .overlay(content: {
                    ColorDetails(item: item, rectSize: rectSize/*CGSize(width: 1, height: 1)*/)
                })
                .frame(height: 100)
                .contentShape(Rectangle())
                .offset(y: tappedCard ? 40 : 0)
                .zIndex(tappedCard ? 100 : 0)
                .onTapGesture {
                    showAddButton = false
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
    func ColorView(item: TBTask, rectSize: CGSize) -> some View{
        Rectangle()
            .overlay {
                Rectangle()
                    .fill(item.taskColor.gradient)
            }
            .overlay {
                Rectangle()
                    .fill(item.taskColor.opacity(0.5).gradient)
                    .rotationEffect(.init(degrees: 180))
            }
            .matchedGeometryEffect(id: item.id.uuidString, in: animation)
    }
    
    // Color Details
    @ViewBuilder
    func ColorDetails(item: TBTask, rectSize: CGSize)-> some View{
        HStack{
            Text("\(item.taskTitle)")
                .font(.title2.bold())
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "sun.max.fill")
                .imageScale(.large)
                .foregroundColor(.white)
        }
        .padding(25)
        .padding(.vertical, 50)
        .matchedGeometryEffect(id: item.id.uuidString + "DETAILS", in: animation)
    }
    
    
    @ViewBuilder
    func AngerLevelBar(value: CGFloat, label: String) -> some View {
        HStack(spacing: 15){
            Text(label)
                .font(.caption)
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
            
            Text("\(angerToString(level: user.preferredAnger))")
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
    
    func angerToCG(level: AngerLevels) -> CGFloat {
        var value: CGFloat
        switch level {
        case .ENCOURAGING:
            value = 0.0
        case .PASSIVEAGGRESSIVE:
            value = 0.5
        case .ABUSIVE:
            value = 1.0
        }
        return value
    }
    
    func angerToString(level: AngerLevels) -> String {
        switch level {
        case .ABUSIVE:
            return "Bully"
        case .PASSIVEAGGRESSIVE:
            return "Passive Aggressive"
        case .ENCOURAGING:
            return "Encouraging"
        }
    }
}
