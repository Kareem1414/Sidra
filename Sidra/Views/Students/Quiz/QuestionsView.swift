//
//  QuestionsView.swift
//  QuizApp
//
//  Created by AHMED ASSIRY on 05/07/1444 AH.
//

import SwiftUI

struct QuestionsView: View {
    
    var info: [Info]
    /// - Making it a State, so that we can do View Modifications
    @State var questions : [Question]
    var onFinish : () -> ()
    
    // - View Properties
    @Environment(\.dismiss) private var dismiss
    
    @State private var progress : CGFloat = 0
    @State private var currentIndex : Int = 0
    @State private var score : CGFloat = 0
    @State private var showScoreCard : Bool = false
    
    var body: some View {
        VStack(spacing: 15) {
            
            ForEach(info, id: \.title) { subInfo in
                HStack {
                    Text(subInfo.title)
                        .font(.title)
                        .fontWeight(.semibold)
                        .hAlign(.leading)
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                }
            }
            
            GeometryReader {
                let size = $0.size
                HStack {
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(.black.opacity(0.2))
                        
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(.green)
                            .frame(width: progress * (size.width - 55), alignment: .leading)
                    }
                    .clipShape(Capsule())
                    
                    Text("\(currentIndex + 1) / \(questions.count)")
                        .font(.callout)
//                        .foregroundColor(.gray)
                }
                
            }
            .frame(height: 20)
            .padding(.top, 5)
            
            /// - Questions
            GeometryReader {_ in
                
                ForEach(questions.indices, id: \.self) { index in
                    if currentIndex == index {
                        QuestionView(questions[currentIndex])
//                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                            .transition(.asymmetric(insertion: .slide, removal: .scale).combined(with: .opacity))
                    }
                }
            }
            /// - Removing Padding
            .padding(.horizontal, -15)
            .padding(.vertical, 15)
            
            /// - Changing Button to Finish when the last question arrived
            ///
            CustomButton(title: currentIndex == (questions.count - 1) ? "Submit" : "Next Question", submit: currentIndex == (questions.count - 1)) {
                
                if currentIndex == (questions.count - 1) {
                    showScoreCard.toggle()
                } else {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        currentIndex += 1
                        progress = CGFloat(currentIndex) / CGFloat(questions.count - 1)
                    }
                }
                
            }
        }
        .padding (15)
        .hAlign(.center).vAlign(.top)
        .background {
            Color("BG")
                .ignoresSafeArea ()
        }
        /// This View is going to be Dark Since our background is Dark
        .environment (\.colorScheme, .dark)
        .fullScreenCover(isPresented: $showScoreCard) {
            // - Displaying in 100%
            ScoreCardView(score: score / CGFloat(questions.count) * 100) {
                /// - Closing View
                dismiss()
                onFinish()
            }
        }
    }
    
    /// - Question View
    @ViewBuilder
    func QuestionView(_ question: Question) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            
            Text(question.question)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            
            VStack(spacing: 12) {
                ForEach(question.options, id: \.self) { option in
                    /// - Displaying Correct and Wrong Answers After user has Tapped any one of the Options
                    ZStack {
                        OptionView(option, .gray)
                            .opacity(question.answer == option && question.tappedAnswer != "" ? 0 : 1)
                        OptionView(option, .green)
                            .opacity(question.answer == option && question.tappedAnswer != "" ? 1 : 0)
                        OptionView(option, .red)
                            .opacity(question.tappedAnswer == option && question.tappedAnswer != question.answer ? 1 : 0)
                        
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        /// -Disabling Tap if already Answer was Selected
                        guard questions[currentIndex].tappedAnswer == "" else { return }
                        withAnimation (.easeInOut){
                            questions[currentIndex].tappedAnswer = option
                            
                            /// - When ever the correct Answer was selected, updating the score
                            if question.answer == option {
                                score += 1.0
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 10)
        }
        .padding(15)
        .hAlign(.center)
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.white)
        }
        .padding(.horizontal, 15)
        
    }
    
    /// - Option View
    @ViewBuilder
    func OptionView(_ option: String, _ tint: Color) -> some View {
        Text(option)
            .foregroundColor(tint)
            .padding(.horizontal, 15)
            .padding(.vertical, 20)
            .hAlign(.leading)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(tint.opacity(0.15))
                    .background {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(tint.opacity(tint == .gray ? 0.15 : 1), lineWidth: 2)
                    }
            }
    }
}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: Score Card View
struct ScoreCardView : View {
    
    var score : CGFloat
    /// - Moving to Home When This View was Dismiss
    var onDismiss : () -> ()
    // - View Properties
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack {
            VStack(spacing: 15) {
                Text("Result of Your Exercise")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    Text("Congratulations! you\n have score")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                    /// - Removing Floating Points
                    Text(String(format: "%.0f", score) + "%")
                        .font(.title.bold())
                        .padding(.bottom)
                    
//                    Image("Medal")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(height: 250)
                    
                    LottieView(animationName: "16",
                               loopMode: .repeat(2),
                               contentMode: .scaleAspectFit)
                    .frame(width: UIScreen.screenWidth / 1.2, height: UIScreen.screenWidth / 1.5)
                    
                }
                .foregroundColor(.black)
                .padding(.horizontal, 15)
                .padding(.vertical, 20)
                .hAlign(.center)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white)
                }
            }
            .vAlign(.center)
            
            CustomButton(title: "Back to Home") {
                onDismiss()
                dismiss()
            }
        }
        .padding(15)
        .background {
            Color("BG")
                .ignoresSafeArea()
        }
    }
}
