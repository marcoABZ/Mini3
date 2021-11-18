//
//  DesempenhoView.swift
//  Mini3
//
//  Created by Marco Zulian on 17/11/21.
//

import SwiftUI

struct DesempenhoView: View {
    
    @EnvironmentObject var dashboardManager: DashboardManager
    @EnvironmentObject var profileManager: ProfileManager
    
    //Apagar animacao e variavel abaixo
    @State var pct: Double = 0.0
    
    var body: some View {
        Text("Desempenho")
            .font(.system(size: 32, design: .rounded).bold())
        ScrollView(.horizontal) {
            ZStack(alignment: .topLeading) {
                GeometryReader { geometry in
                    ZStack {
                        Path { path in
                            path.addArc(center: CGPoint(x: geometry.size.width/2, y: geometry.size.width/2),
                                radius: geometry.size.width/2,
                                startAngle: Angle(degrees: 0),
                                endAngle: Angle(degrees: 360),
                                clockwise: true)
                        }
                        .stroke(Color.gray.opacity(0.3), lineWidth: 30)
                        if dashboardManager.pickerSelection == .games {
                            InnerRing(pct: self.pct).stroke(Color.green, style: StrokeStyle(lineWidth: 35, lineCap: .round, lineJoin: .round))
                
                            Text("67%")
                                .font(.system(size: 30).bold())
                        } else {
                            InnerRing(pct: self.pct).stroke(profileManager.getProfileColor(), style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                            Text("67%")
                                .font(.system(size: 26).bold())
                        }
                    }

                }
                .frame(width: 110, height: 110)
                .padding(.leading,40)
                .aspectRatio(1, contentMode: .fit)
                .padding(20)
            
                Image("perfPlaceholder")
                    .padding()
            }
            .onAppear() {
                withAnimation(.easeInOut(duration: 3)) {
                    self.pct = 0.67
                }
            }
           
        }
    }
}
