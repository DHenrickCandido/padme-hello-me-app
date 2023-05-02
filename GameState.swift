import SwiftUI
import AVFoundation

var audioPlayer: [[AVAudioPlayer?]] = [[nil,
                                        nil,
                                        nil],
                                       [nil,
                                        nil,
                                        nil],
                                       [nil,
                                        nil,
                                        nil]]

class GameState: ObservableObject
{
    @Published var board = [[Pad]]()
    @Published var songs = [["drum_track1","piano_track1","piano_melodia_track1"],
                            ["drum_track2","piano_track2","piano_melodia_track2"],["drum_track3","piano_track3","piano_melodia_track3"]]
    @Published var lastPressedRow = 200
    @Published var lastPressedCol = 200
    @Published var tocando = false
    @Published var ImagemMomento = "Diego"
    @Published var TextMomento = "Olá sou o Diego Candido, brinque com os pads!"
    @Published var firstPressedRow = 200
    @Published var firstPressedCol = 200

    
    init()
    {
        resetBoard()
    }
    
    func getImageMomento() -> String
    {
        return ImagemMomento
    }
    
    func getTextMomento() -> String
    {
        return TextMomento
    }
    
    func pressPad(_ row: Int,_ column: Int)
    {
        if let audioFileURL = Bundle.main.url(forResource: songs[row][column], withExtension: "mp3") {
            do {
                audioPlayer[row][column] = try AVAudioPlayer(contentsOf: audioFileURL)
                audioPlayer[row][column]?.numberOfLoops = -1
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(.playback, mode: .moviePlayback, options: [])

            } catch {
                // Lidar com o erro de inicialização do AVAudioPlayer
                print("Não foi possível reproduzir a música.")
            }
        } else {
            // Lidar com o erro de arquivo de áudio não encontrado
            print("O arquivo de áudio não foi encontrado.")
        }
        

        
        if(board[row][column].tile != Tile.Empty)
        {
            board[row][column].tile = Tile.Empty
            audioPlayer[row][column]?.stop()
            ImagemMomento = "Diego"
            TextMomento = "Olá sou o Diego Candido, brinque com os pads!"
             return   
        }

        if(isTocando() == false)
        {
            let startTime = 0.0 // segundo que deseja iniciar a música
            audioPlayer[row][column]?.currentTime = startTime
            firstPressedCol = column
            firstPressedRow = row
        }
        else if(isLastPad(row, column) == true)
        {
            audioPlayer[row][column]?.currentTime = audioPlayer[firstPressedRow][firstPressedCol]!.currentTime
        }
        else if(isTocando() == true)
        {
            audioPlayer[row][column]?.currentTime = audioPlayer[lastPressedRow][lastPressedCol]!.currentTime
        }
        board[row][column].tile = Tile.Pressed

        audioPlayer[row][column]?.prepareToPlay()
        audioPlayer[row][column]?.play()
        
        lastPressedCol = column
        lastPressedRow = row
        
        
        if(encontrarMusicas() == 1)
        {
            TextMomento = "Sou de Campinas, SP. Nascido e criado! Vim para Curitiba estudar!"
            ImagemMomento = "Campinas"
            
        }
        
        if(encontrarMusicas() == 2)
        {
            TextMomento = "Sou apaixonado por tecnologia, as vezes exagero um pouco."
            ImagemMomento = "Tech"
            
        }

        if(encontrarMusicas() == 3)
        {
            TextMomento = "Faço Ciencia da Computação na PUCPR!"
            ImagemMomento = "PUCPR"
            
        }
        
        if(encontrarMusicas() == 4)
        {
            TextMomento = "Meu filme favorito de todos os tempos é Your Name, mudou a forma que encaro a vida!"
            ImagemMomento = "yourname"
            
        }
        
        if(encontrarMusicas() == 5)
        {
            TextMomento = "Apesar de ser um completo noob, sou apaixonado por musica e espero arranjar tempo para isso em breve..."
            ImagemMomento = "guitarra"
            
        }
        
        if(encontrarMusicas() == 6)
        {
            TextMomento = "Escuto de tudo mas adoro kpop, One in a million annyeonghaseyo..."
            ImagemMomento = "twice"
            
        }
        
        if(encontrarMusicas() == 7)
        {
            TextMomento = "Sou engenheiro de dados na empresa Ci&T."
            ImagemMomento = "ci&t"
            
        }
        
        if(encontrarMusicas() == 8)
        {
            TextMomento = "Meu jogo favorito é Zelda Breath of the Wild."
            ImagemMomento = "zelda"
            
        }
        
        if(encontrarMusicas() == 9)
        {
            TextMomento = "Uma princesa e minha namorada limda perfeita <3"
            ImagemMomento = "princesa"
            
        }
        
        if(encontrarMusicas() == 10)
        {
            TextMomento = "He's the GOAT. The GOAT. Me perdoem mas sou fã."
            ImagemMomento = "goat"
            
        }
        
        if(encontrarMusicas() == 11)
        {
            TextMomento = "As vezes sou um boatardiano."
            ImagemMomento = "traicao"
            
        }
        
        if(encontrarMusicas() == 12)
        {
            TextMomento = "Adoro JDM e drift."
            ImagemMomento = "drift"
            
        }
        
        if(encontrarMusicas() == 13)
        {
            TextMomento = "Fiz um semestre de Eng Comp na PUC Campinas, la é lindo."
            ImagemMomento = "pucc"
            
        }
        
        if(encontrarMusicas() == 14)
        {
            TextMomento = "Eu vim sozinho para Curitiba!"
            ImagemMomento = "morar"
            
        }
        
        if(encontrarMusicas() == 15)
        {
            TextMomento = "Eu nunca joguei genshin eu juro!"
            ImagemMomento = "genshin"
            
        }




    }
    
    func isLastPad(_ row: Int, _ column: Int) -> Bool
    {
        if (row == lastPressedRow && column == lastPressedCol)
        {
            return true
        }
        return false
    }
    func isTocando() -> Bool
    {
        for row in 0...2
        {
            for column in 0...2
            {
                if (board[row][column].tile == Tile.Pressed) 
                {
                    
                    tocando = true
                    return true
                }
            }
        }
        firstPressedCol = 200
        lastPressedCol = 200
        firstPressedRow = 200
        lastPressedRow = 200
        tocando = false
        return false
    }
    func resetBoard()
    {
        var newBoard = [[Pad]]()
        
        for _ in 0...2
        {
            var row = [Pad]()
            for _ in 0...2
            {
                row.append(Pad(tile: Tile.Empty))    
            }
            newBoard.append(row)
        }
        board = newBoard
    }
    func encontrarMusicas() -> Int
    {
        if(board[0][0].tile == Tile.Pressed && board[0][1].tile == Tile.Pressed && board[0][2].tile == Tile.Pressed)
        {
            return 1
        }
        
        if(board[1][0].tile == Tile.Pressed && board[1][1].tile == Tile.Pressed && board[1][2].tile == Tile.Pressed)
        {
            return 2
        }
        
        if(board[2][0].tile == Tile.Pressed && board[2][1].tile == Tile.Pressed && board[2][2].tile == Tile.Pressed)
        {
            return 3
        }
        
        if(board[0][0].tile == Tile.Pressed && board[0][1].tile == Tile.Pressed && board[1][2].tile == Tile.Pressed)
        {
            return 4
        }
        
        if(board[0][0].tile == Tile.Pressed && board[0][1].tile == Tile.Pressed && board[2][2].tile == Tile.Pressed)
        {
            return 5
        }
        
        if(board[0][0].tile == Tile.Pressed && board[1][1].tile == Tile.Pressed && board[0][2].tile == Tile.Pressed)
        {
            return 6
        }

        if(board[0][0].tile == Tile.Pressed && board[2][1].tile == Tile.Pressed && board[0][2].tile == Tile.Pressed)
        {
            return 7
        }
        
        if(board[1][0].tile == Tile.Pressed && board[0][1].tile == Tile.Pressed && board[0][2].tile == Tile.Pressed)
        {
            return 8
        }
        
        if(board[2][0].tile == Tile.Pressed && board[0][1].tile == Tile.Pressed && board[0][2].tile == Tile.Pressed)
        {
            return 9
        }

        if(board[0][0].tile == Tile.Pressed && board[1][1].tile == Tile.Pressed && board[2][2].tile == Tile.Pressed)
        {
            return 10
        }
        
        if(board[2][0].tile == Tile.Pressed && board[1][1].tile == Tile.Pressed && board[0][2].tile == Tile.Pressed)
        {
            return 11
        }
        
        if(board[0][0].tile == Tile.Pressed && board[1][1].tile == Tile.Pressed && board[1][2].tile == Tile.Pressed)
        {
            return 12
        }
        
        if(board[1][0].tile == Tile.Pressed && board[1][1].tile == Tile.Pressed && board[2][2].tile == Tile.Pressed)
        {
            return 13
        }
        
        if(board[0][0].tile == Tile.Pressed && board[2][1].tile == Tile.Pressed && board[2][2].tile == Tile.Pressed)
        {
            return 14
        }
        
        if(board[2][0].tile == Tile.Pressed && board[2][1].tile == Tile.Pressed && board[0][2].tile == Tile.Pressed)
        {
            return 15
        }
        
        return 0
    }
}
