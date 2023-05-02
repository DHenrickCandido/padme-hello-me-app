import SwiftUI

struct Pad
{
    var tile: Tile
    
    func displayTile() -> String
    {
        switch(tile)
        {
        case Tile.Pressed:
            return ""
        default:
            return ""
        }
    }
    
    func padColor(_ row: Int,_ column: Int) -> Color
    {
        if  (column == 0 && tile == Tile.Pressed)
        {
            return Color(red: 52/255, green: 113/255, blue: 166/255) 
        }
        else if (column == 0)
        {
            return Color.cyan
        }
        
        
        
        if  (column == 1 && tile == Tile.Pressed)
        {
            return Color(red: 143/255, green: 21/255, blue: 62/255) 
        }
        else if (column == 1)
        {
            return Color.pink
        }
        
        
        
        if  (column == 2 && tile == Tile.Pressed)
        {
            return Color(red: 36/255, green: 143/255, blue: 43/255) 
        }
        else if (column == 2)
        {
            return Color.green
        }
        

        return Color.pink
//        
//        switch(tile)
//        {
//        case Tile.Pressed:
//            return Color.blue
//        default:
//            return Color.white
//        }
    }
    
    
}

enum Tile
{
    case Pressed
    case Empty
}
