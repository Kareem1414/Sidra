//
//  ContactUsView.swift
//  Sidra
//
//  Created by AHMED ASSIRY on 17/04/1444 AH.
//

import SwiftUI
import MessageUI

struct ContactUsView: View {
    
    
    @State private var sendEmail = false
    let constantsMail = ConstantsMail.shared
    
    var body: some View {
        
        VStack(spacing: 45) {
            
            Button {
                
                
                // 1
                let urlWhats = "https://wa.me/966598621015"
                // 2
                if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
                  // 3
                  if let whatsappURL = NSURL(string: urlString) {
                    // 4
                    if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                      // 5
                      UIApplication.shared.open(whatsappURL as URL, options: [:], completionHandler: nil)
                    } else {
                      // 6
                      print("Cannot Open Whatsapp")
                    }
                  }
                }
                
                
            }label: {
                Text("WhatsApp")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.green)
                    .cornerRadius(8)
                    .padding()
            }
            
            Button {
                
                
                // 1
                let urlWhats = "https://t.me/+966598621015"
                // 2
                if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
                  // 3
                  if let whatsappURL = NSURL(string: urlString) {
                    // 4
                    if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                      // 5
                      UIApplication.shared.open(whatsappURL as URL, options: [:], completionHandler: nil)
                    } else {
                      // 6
                      print("Cannot Open Telegram")
                    }
                  }
                }
                
                
            }label: {
                Text("Telegram")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.linearGradient(colors: [.blue, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(8)
                    .padding()
                    
            }
            

                if MFMailComposeViewController.canSendMail(){
                    Button {
                        sendEmail.toggle()
                    } label: {
                        Text("Email")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(8)
                            .padding()
                    }
                } else {
                    Text(constantsMail.noSupportText)
                        .multilineTextAlignment(.center)
                }

            
        }
        .sheet(isPresented: $sendEmail) {
            MailView(content: constantsMail.contentPreText, to: constantsMail.email,subject: constantsMail.subject)
        }
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}

struct MailView : UIViewControllerRepresentable {
    
    var content: String
    var to: String
    var subject: String
    
    typealias UIViewControllerType = MFMailComposeViewController
    
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        if MFMailComposeViewController.canSendMail(){
            let view = MFMailComposeViewController()
            view.mailComposeDelegate = context.coordinator
            view.setToRecipients([to])
            view.setSubject(subject)
            view.setMessageBody(content, isHTML: false)
            return view
        } else {
            return MFMailComposeViewController()
        }
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator : NSObject, MFMailComposeViewControllerDelegate{
        
        var parent : MailView
        
        init(_ parent: MailView){
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
        
        
    }
    
}

struct ConstantsMail{
    
    var email = "Assiry.a@outlook.com"
    
    let noSupportText = "You need to set a mail account in Mail app in order to leave a feedback"
    let contentPreText = "I would like to give you my honest feedback. \n \n \n \(UIDevice.current.name) \n \(UIDevice.current.model) \n \(UIDevice.current.systemName) \n \(UIDevice.current.systemVersion) \n \(UIDevice.current.localizedModel) \n \(UIDevice.current.orientation.isFlat)  \n \(UIDevice.current.orientation.isPortrait) \n \(UIDevice.current.orientation.isLandscape)"
    let sendButtonText = "Give Feedback"
    let subject = "Feedback"
    
    static let shared = ConstantsMail()
    
    init(){
        if let file = Bundle.main.path(forResource: "Email", ofType: "txt"){
            do {
                self.email = try String(contentsOfFile: file)
            } catch let error {
                print(error)
            }
        }
    }
}
