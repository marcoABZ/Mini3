import SwiftUI

struct PuzzlePiece: View {
    @EnvironmentObject var student: Profile
    @ObservedObject var puzzleManager: PuzzleManager
    @ObservedObject var piece: PuzzlePiece_<UIImage>
    var preview: Bool = false
    
    var body: some View {
            ZStack {
                if puzzleManager.settings.ordenacao {
                    Image(uiImage: piece.content)
                        .overlay (alignment: .bottom) {
                            Rectangle()
                                .foregroundColor(student.color)
                                .frame(height: 50)
                            Text(String(piece.index + 1))
                                .foregroundColor(.white)
                                .font(.system(size: 36, weight: .bold, design: .default))
                        }
                } else {
                    Image(uiImage: piece.content)
                }
            }
            .offset(piece.displacement)
            .zIndex(piece.displacement == .zero ? 0 : 1)
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .onChanged {
                        if !piece.isCorrect {
                            piece.drag(forDistance: CGSize(width: $0.translation.width, height: $0.translation.height))                      }
                    }
                    .onEnded { _ in
                        piece.drop()
                        puzzleManager.updateGameStatus()
                        print(puzzleManager.isOver)
                    }
            )
            .shadow(color: student.color, radius: piece.isCorrect ? 10 : 0)
            .overlay(
                GeometryReader { geo in
                    Color.clear
                        .onAppear {
                            if !preview {
                                piece.setStartPosition(at: geo.frame(in: .global))
                            }
                        }
                }
            )
    }
}
