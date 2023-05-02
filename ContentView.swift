import SwiftUI


struct ContentView: View {
    @StateObject var gameState = GameState()
    var body: some View {
        let borderSize = CGFloat(9)
        Spacer()
        Text("Hello, Me")
            .font(.title)
            .bold()
        
        
        
        VStack (spacing: borderSize) {
            ForEach(0...2, id: \.self) {
                row in 
                HStack (spacing: borderSize) {
                    ForEach(0...2, id: \.self){
                        column in
                        let pad = gameState.board[row][column]
                        pad.padColor(row, column)
                            .font(.system(size: 80))
                            .foregroundColor(Color.pink)
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)

//                            .background(pad.padColor(row, column))

                            .onTapGesture {
                                gameState.pressPad(row, column)
                            }
                        
                        

                        
                    }                
                    
                }

            }
            

        }
        .padding()
        .background(Color.black)

        Text(gameState.getTextMomento())
               .font(.system(size: 24))
        Image(gameState.getImageMomento())

            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding()
        

        
    }
}
