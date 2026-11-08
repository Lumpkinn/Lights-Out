//TO IMPLEMENT THE MAZE, YOURE GONNA NEED TO MAKE SOME PANELS IN A CLASS, CHECK IF THE CURSOR IS INSIDE, AND THEN PUSH THE CURSOR TO THE LAST VALID POS. 0,0 IS FAILSAFE

//Do I wanna extend Jpanel? and how might that effect the project??
public class Maze
{
     public Maze(Dimension WindowDimension)
     {
          //TODO: Draw the maze. It needs to be an image first, and then I can set up everything else. 
          //Make the maze
          JPanel[] MazeWalls = [];
          for (int i; i < 10; i++)
               MazeWalls.add(new Wall);
     
     }     
     //Class for the walls of the maze
     public JPanel Wall(point pos, height, length)
     {
          //TODO: Create a rectangle using these points, and initialize it as a jpanel. make sure to change the return type
          JPanel MazeWall = new JPanel();
          MazeWall.setSize(width, length);

          //This is for getting the exact area, and the position of the area
          //TODO: How am I gonna return all of these values?
          int[] HorizBound =[(pos.x), (pos.x + width)];
          int[] VertBound = [(pos.y), (pos.y + height)];
          
          //TODO: maybe store the last known mouse pos and set it to that?????
          if HorizBound[0] <= MouseInfo.getPointerInfo().getLocation().x <= HorizBound[1];
          {    
               //Move mouse cursor to the x pos
               Robot r = new Robot();
               r.mouseMove(pos.x);
          }
     
          if VertBound[0] <= MouseInfo.getPointerInfo().getLocation().y <= VertBound[1]
          {
               //Move mouse cursor to the y pos
               Robot r = new Robot();
               r.mouseMove(pos.x);
               
          }

          //Adding in some extra details for visibility
          MazeWall.setBorder(BorderFactory.createLineBorder(Color.black));
          MazeWall.setVisible();
     }
}
