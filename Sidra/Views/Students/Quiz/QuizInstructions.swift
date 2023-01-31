//
//  Home.swift
//  QuizApp
//
//  Created by AHMED ASSIRY on 05/07/1444 AH.
//

import SwiftUI

struct QuizInstructions: View {
    
//    @State private var quizInfo : Info?
//    @State private var questions : [Question] = []
    
    @State private var startQuiz : Bool = false
    
    @AppStorage("colorkey") var storedColor: Color = .black
    
    // - View Properties
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
            
            ForEach(QuizQ, id: \.title) { QInfo in
                VStack(spacing: 10) {
                    
                    HStack {
                        Text("Quiz for \(QInfo.title)")
                            .font(.title)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .minimumScaleFactor(0.2)
                            .hAlign(.leading)
                        
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 10))
                                .fontWeight(.semibold)
                                .padding(6)
                                .foregroundColor(.primary)
                                .background(.gray.opacity(0.5))
                                .clipShape(Circle())
                        }
                    }

                    
                    /// - Custom Label
                    CustomLabel("list.bullet.rectangle.portrait", "\(Questions.count)", "Multiple Choice Questions")
                        .padding(.top, 20)
                    
                    CustomLabel("person", "\(QInfo.peopleAttended)", "Attended the quiz")
                        .padding(.top, 5)
                    
                    CustomLabel("arrow.clockwise", "\(QInfo.retake)", "Attempts to pass the quiz")
                        .padding(.top, 5)
                    
                    Divider()
                        .overlay(storedColor)
                        .padding(.horizontal, -15)
                        .padding(.top, 15)
                        
                    
                   
                        RulesView(QInfo.rules)
                    
                    CustomButton(title: "Start Quiz", onClick: {
                        startQuiz.toggle()
                    })
                    .vAlign(.bottom)
                    
                }
                .padding(15)
                .vAlign(.top)
                .fullScreenCover(isPresented: $startQuiz) {
                    QuestionsView(info: QuizQ, questions: Questions) {
                        /// - User has Successfully finished the Quiz
                        /// - Thus Update the UI
                        
//                        Info.peopleAttended += 1
                    }
                }
            }
        
    }
    
    // - Rules View
    @ViewBuilder
    func RulesView(_ rules: [String]) -> some View {
        
        VStack(alignment: .leading, spacing: 15) {
            Text("Before you start")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 12)
            
            ForEach(rules, id: \.self) { rule in
                HStack(alignment: .top, spacing: 10) {
                    Circle()
                        .fill(.primary)
                        .frame(width: 8, height: 8)
                        .offset(y: 6)
                    
                    Text(rule)
                        .font(.callout)
                        .lineLimit(3)
                    
                }
                
            }
        }
    }
    
    // - Custom Label
    @ViewBuilder
    func CustomLabel(_ image: String,_ title: String,_ subTitle: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: image)
                .font(.title3)
                .frame(width: 45, height: 45)
                .background {
                    Circle()
                        .fill(storedColor.opacity(0.1))
                        .padding(-1)
                        .background {
                            Circle()
                                .stroke(storedColor, lineWidth: 1)
                        }
                }
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.bold)
                    .foregroundColor(storedColor)
                Text(subTitle)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
            }
            .hAlign(.leading)
        }
    }
}

struct QuizInstructions_Previews: PreviewProvider {
    static var previews: some View {
        QuizInstructions()
    }
}

/// Making it Reusable
struct CustomButton : View {
    var title : String
    var submit : Bool = false
    var onClick : ()->()
    
    var body: some View {
        Button {
            onClick()
            UISelectionFeedbackGenerator().selectionChanged()
        } label: {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                
                .hAlign(.center)
                .padding()
                .foregroundColor(.white)
                .background {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill( submit ? .green : Color("Pink"))
                        .ignoresSafeArea()
                }
                .shadow(radius: 3)
        }
    }
}


// MARK: View Extensions
// Useful for moving Views btw HStack and Vstack
extension View {
    func hAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}


// MARK: Quiz Info Codable Model
struct Info: Codable {
    var title : String
    var peopleAttended : Int
    var retake : Int
    var rules : [String]
    
    enum CodingKeys : CodingKey {
        case title
        case peopleAttended
        case retake
        case rules
    }
}

// MARK: Quiz Question Codable Model
struct Question : Identifiable, Codable {
    var id: UUID = .init()
    var question : String
    var options : [String]
    var answer : String
    
    // - For UI State Updates
    var tappedAnswer : String = ""
    
    enum CodingKeys : CodingKey {
        case question
        case options
        case answer
    }
}


let QuizQ : [Info] = [
    .init(title: "Cloud Computing", peopleAttended: 18, retake: 2, rules: ["Make sure your connection is strong because you must finish this test in one session.", "For a gerect response, one point is given. No points were deducted.", "You are permitted to retake the quiz.", "Tapping answers will make it a final choice, so make sure you don't tap the wrong one."])
]


let Questions : [Question] = [
    .init(question: "Which of the following are the features of cloud computing?", options: ["Security", "Availability", "Large Network Access", "All of the mentioned"], answer: "All of the mentioned"),
    
    .init(question: "Which architectural layer is used as a backend in cloud computing?", options: ["cloud", "soft", "client", "all of the mentioned"], answer: "cloud"),
    
    .init(question: "Which of the following is the application of cloud computing?", options: ["All of the above", "Google G Suite", "Paypal", "Adobe"], answer: "All of the above"),
    
    .init(question: "Which of the following model attempts to categorize a cloud network based on four dimensional factors?", options: ["Cloud Cube", " Cloud Square", "Cloud Service", "All of the mentioned"], answer: "Cloud Cube"),
    
    .init(question: "Applications and services that run on a distributed network using virtualized resources is known as ___________", options: ["Parallel computing", "Soft computing", "Distributed computing", "Cloud computing"], answer: "Cloud computing"),
    
    .init(question: "Who is the father of cloud computing?", options: ["Charles Bachman", "Edgar Frank Codd", "J.C.R. Licklider", "Sharon B. Codd"], answer: "J.C.R. Licklider"),
    
        .init(question: "Into which expenditures does Cloud computing shifts capital expenditures?", options: ["local", "operating", "service", "none of the mentioned"], answer: "operating"),
    
        .init(question: "Which of the following model consists of the service that you can access on a cloud computing platform?", options: ["Deployment", "Service", "Application", "None of the mentioned"], answer: "Service"),
    
        .init(question: "Which of the following is the most important area of concern in cloud computing?", options: ["Scalability", "Storage", "Security", "All of the mentioned"], answer: "Security"),
    
        .init(question: "Which of the following is the most refined and restrictive cloud service model?", options: ["PaaS", "IaaS", "SaaS", "CaaS"], answer: "PaaS"),
    
        .init(question: "In which of the following service models the hardware is virtualized in the cloud?", options: ["NaaS", "PaaS", "CaaS", "IaaS"], answer: "IaaS"),
    
        .init(question: "What is the relation of the capacity attribute to performance?", options: ["same", "different", "similar", "none of the mentioned"], answer: "different"),
    
        .init(question: "What does L in LAMP stands for?", options: ["Lamp", "Linux", "Lone", "None of the mentioned"], answer: "Linux"),
    
        .init(question: "Which of the following is one of the major categories of Amazon Machine Instances that you can create on the Amazon Web Service?", options: ["WAMP", "XAMPP", "LAMP", "None of the mentioned"], answer: "LAMP"),
    
        .init(question: "Which of the following is used as a substitute for PHP as a scripting language in LAMP?", options: ["Scala", "Perl", "Ruby", "None of the mentioned"], answer: "Perl"),
    
        .init(question: "Which of the following RDBMS is used by LAMP?", options: ["SQL Server", "DB2", "MySQL", "All of the mentioned"], answer: "MySQL"),
    
        .init(question: "Which of the following is the hardest factor to determine?", options: ["Network performance", "Network capacity", "Network delay", "All of the mentioned"], answer: "Network capacity"),
    
        .init(question: "Which of the following is an example of the cloud?", options: ["Amazon Web Services (AWS)", "Dropbox", "Cisco WebEx", "All of the above"], answer: "All of the above"),
    
        .init(question: "Which of the following is an example of a PaaS cloud service?", options: ["Heroku", "AWS Elastic Beanstalk", "Windows Azure", "All of the above"], answer: "All of the above"),
    
        .init(question: "Cloud computing is a concept that involves pooling physical resources and offering them as which sort of resource?", options: ["cloud", "real", "virtual", "none of the mentioned"], answer: "virtual"),
    
        .init(question: "Into which expenditures does Cloud computing shifts capital expenditures?", options: ["local", "operating", "service", "none of the mentioned"], answer: "operating")
]
