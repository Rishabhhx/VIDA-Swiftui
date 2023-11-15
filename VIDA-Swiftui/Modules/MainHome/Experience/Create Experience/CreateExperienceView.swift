//
//  CreateExperienceView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 16/09/22.
//

import SwiftUI

struct CreateExperienceView: View {
    @Environment(\.dismiss) private var dismiss

    @State var isShowPicker : Bool = false
    @State var coverImage: Image?
    @State var coverImageUploaded: Bool = false
    @State var experience = ""
    @State var location = "Add Location"
    @State var discardExperience : Bool = false
    @State var experienceReq : Bool = false
    @State var locationReq : Bool = false
    @State var coverImageReq : Bool = false
        
    var body: some View {
        NavigationView {
            ZStack {
                    CreateExperienceCoverImage(coverImage: $coverImage, coverImageUpload: $coverImageUploaded)
                VStack(alignment: .center) {
                    if experienceReq {
                        ToastMessage(req: $experienceReq, text: "Enter Expeience")
                    } else if locationReq {
                        ToastMessage(req: $locationReq, text: "Enter Location")
                    } else if coverImageReq {
                        ToastMessage(req: $coverImageReq, text: "Add Cover Image")
                    }
                    Spacer()
                }
                .padding(80)
                    if !coverImageUploaded {
                        AddExperienceCover(isShowPicker: $isShowPicker)
                    }
                    VStack {
                        CreateExperienceHeader(coverImageUploaded: $coverImageUploaded, coverImage: $coverImage, discardExperience: $discardExperience, isShowPicker: $isShowPicker)
                        Spacer()
                        CreateExperienceDetails(location: $location, experience: $experience, coverImage: $coverImage, experienceReq: $experienceReq, locationReq: $locationReq, coverImageReq: $coverImageReq)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 208/255, green: 231/255, blue: 220/255))
                .gesture(
                           DragGesture().onEnded { value in
                               if value.location.y - value.startLocation.y > 150 {
                                   /// Use presentationMode.wrappedValue.dismiss() for iOS 14 and below
                                   dismiss()
                               }
                           }
                       )
                .overlay(alignment: .center) {
                    if discardExperience {
                        PopupYesNoView(yesButtonPressed: {self.dismiss()}, noButtonPressed: {discardExperience.toggle()})
                    }
                }
                .fullScreenCover(isPresented: $isShowPicker) {
                    ImagePicker(image: self.$coverImage)
            }
        }
        .hideKeyboardWhenTappedAround()
    }
}

struct CreateExperienceView_Previews: PreviewProvider {
    static var previews: some View {
        CreateExperienceView()
    }
}

struct CreateExperienceHeader: View {
    @Binding var coverImageUploaded: Bool
    @Binding var coverImage : Image?
    @Binding var discardExperience : Bool
    @Binding var isShowPicker : Bool
    
    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(.white)
                Button(action: {
                        discardExperience.toggle()
                }) {
                    Image("kblackCross")
                        .renderingMode(.original)
                }
            }
            .frame(width: 35, height: 35)
            Spacer()
            if coverImageUploaded {
                Image("keditor-mediaeditcircle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .onTapGesture {
                        isShowPicker.toggle()
                    }
                Image("keditor-delete")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .onTapGesture {
                        coverImageUploaded = false
                        coverImage = nil
                    }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 28)
    }
}

struct CreateExperienceCoverImage: View {
    @Binding var coverImage : Image?
    @Binding var coverImageUpload : Bool
    var body: some View {
        ZStack {
            coverImage?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
                .ignoresSafeArea()
                .onAppear() {
                    if coverImage == nil {
                        coverImageUpload = false
                    } else {
                        coverImageUpload = true
                    }
                }
            if coverImageUpload {
                Image("blackOverlay")
                    .resizable()
                    .opacity(0.25)
                    .ignoresSafeArea()
            }
        }
    }
}

struct CreateExperienceDetails: View {
    @State var moveToSearchLocation : Bool = false
    @Binding var location : String
    @Binding var experience : String
    @State var experience2 : String = "Add your experience title here.."
    @Binding var coverImage : Image?
    @State var move : Bool = false
    @Binding var experienceReq : Bool
    @Binding var locationReq : Bool
    @Binding var coverImageReq : Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack(alignment: .leading) {
            TextField((""), text: $experience, axis: .vertical)
                .placeholder(when: experience.isEmpty, placeholder: {
                    Text(experience2)
                })
                .font(.custom("Gill Sans", size: 35))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .lineLimit(1...5)
            NavigationLink(destination: SearchLocationView(location: $location), isActive: $moveToSearchLocation) {
                Button(action: {}) {
                    AddLocation(location: $location)
                        .foregroundColor(.white)
                        .onTapGesture {
                            moveToSearchLocation.toggle()
                        }
                }
            }
            HStack {
                Spacer()
                NavigationLink(destination: AddExperienceView(experience: $experience, location: $location, coverImage: $coverImage, dismissCreateExperience: {
                    self.presentationMode.wrappedValue.dismiss()
                }), isActive: $move) {
                    Button(action: {
                        if experience.isEmpty {
                            experienceReq = true
                        } else if location == "Add Location" {
                            locationReq = true
                        } else if coverImage == nil {
                            coverImageReq = true
                        }  else {
                            move.toggle()
                        }
                    }) {
                        Text("Next")
                            .fontWeight(.medium)
                            .font(.custom("Gill Sans", size: 18))
                            .frame(height: 35)
                            .padding(.horizontal,15)
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .cornerRadius(30)
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
    }
}

struct AddExperienceCover: View {
    @Binding var isShowPicker : Bool
    var body: some View {
        Button(action: {self.isShowPicker.toggle()}) {
            VStack {
                Image("kimageplaceholderLargeTint")
                    .resizable()
                    .frame(width: 30, height: 30)
                Text("Add Cover Image")
                    .font(.custom("Gill Sans", size: 15))
                    .fontWeight(.medium)
            }
            .foregroundColor(.white)
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @Binding var image: Image?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var presentationMode: PresentationMode
        @Binding var image: Image?
        
        init(presentationMode: Binding<PresentationMode>, image: Binding<Image?>) {
            _presentationMode = presentationMode
            _image = image
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            image = Image(uiImage: uiImage)
            presentationMode.dismiss()
            
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $image)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}

struct AddLocation: View {
    @Binding var location : String
    var body: some View {
        HStack {
            Image("klocationpin-alternate")
                .resizable()
                .frame(width: 24, height: 20)
            Text(location)
                .fontWeight(.semibold)
                .font(.custom("Gill Sans", size: 18))
        }
//        .foregroundColor(Color.black)
    }
}
