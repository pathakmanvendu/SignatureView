//
//  ContentView.swift
//  SignatureView
//
//  Created by Manvendu Pathak on 18/07/23.
//

import SwiftUI
import PencilKit


struct ContentView: View {
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    @State var color: Color = .black
    
    
    
    
    var body: some View {
        VStack {
            Button {
               saveImage()
            } label: {
                Image(systemName: "square.and.arrow.down.fill")
                    .font(.title)
            }

            
            
            DrawingView(canvas:$canvas, isDraw: $isDraw, color: $color)
            
            
            Divider()
            
            HStack{
                
                Button {
                    color = .black
                } label: {
                    Circle()
                        .fill(.black)
                        .frame(width: 50, height:50)
                        
                }.padding()
                
                Button {
                    color = .blue
                } label: {
                    Circle()
                        .fill(.blue)
                        .frame(width: 50, height:50)
                        
                }
                .padding()
                Button {
                    color = .red
                } label: {
                    Circle()
                        .fill(.red)
                        .frame(width: 50, height: 50)
                }
                .padding()

                
                Button {
                    isDraw.toggle()
                } label: {
                    VStack{
                        Image(systemName: "pencil.slash")
                            .font(.title)
                        Text("Eraser")
                    }
                   
                }
                

            }
            
           
            }
        }
    
    func saveImage(){
        let image = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1)
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
       
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct DrawingView: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    @Binding var isDraw: Bool
    @Binding var color: Color
    let eraser = PKEraserTool(.bitmap)
    
    var  ink: PKInkingTool {
        PKInkingTool(.pen, color: UIColor(color))
    }
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.tool = isDraw ? ink : eraser
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.tool = isDraw ? ink : eraser
    }
}
