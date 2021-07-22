//
//  ContentView.swift
//  iOSAcadApp
//
//  Created by Michael Piccerillo on 7/21/21.
//

import SwiftUI




class ViewModel: ObservableObject {

    
    @Published var image: Image?
    
    func fetchNewImage(){
        //all this is doing is fetching the image and
        
        guard let url = URL(string: "https://random.imagecdn.app/500/500") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else { return }
                self.image = Image(uiImage: uiImage)
            }
        }
        task.resume() //this is actually going to kick off the task and fetch the contents of the url
    }
}

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    
    var body: some View {
        NavigationView{
            VStack{
                
                Spacer()
                
                
                if let image = viewModel.image  {
                    ZStack{ 
                        image
                            .resizable()
                            .foregroundColor(.orange)
                            .frame(width: 275, height: 275)
                            .padding()
                           
                    }
                    .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.width / 1.2)
                    .background(Color.red)
                    .cornerRadius(18)
                    
                    
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(.orange)
                        .frame(width: 200, height: 200)
                        .padding()
                        
                }
                
                Spacer()
                
                
                Button(action: {
                    //fetch the image
                    viewModel.fetchNewImage()
                }, label: {
                    Text("New Image!")
                        .bold()
                        .frame(width: 250, height: 55)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding()
                })
            }
            .navigationTitle("Photo Mania")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
