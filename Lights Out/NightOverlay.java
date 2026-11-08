import java.awt.*;
import java.awt.event.*;
import javax.swing.*;


public class NightOverlay extends JPanel


{
     public NightOverlay()
     {
          //MouseListener, so the screen can be updated every time the mouse moves. 
               addMouseMotionListener(new MouseMotionAdapter() {
                    @Override
                    public void mouseMoved(MouseEvent e)
                    {
                         repaint();
                    }
               });     
     }
     @Override
     protected void paintComponent(Graphics g)
     {
          //Radius of area around the mouse that will be made visible.
          int radius = 250;
     
          //Makes the circle around the mouse, and makes it transparent as well.
          super.paintComponent(g);
          int xpos = MouseInfo.getPointerInfo().getLocation().x - this.getLocationOnScreen().x;
          int ypos = MouseInfo.getPointerInfo().getLocation().y - this.getLocationOnScreen().y;
          g.setColor(new Color(1f,0f,0f,0f));
          ((Graphics2D) g).setComposite(AlphaComposite.Clear);
          g.fillOval(xpos - radius/2, ypos - radius / 2, radius, radius);
     }

     //Main class, this handles making the window, and makes it full screen.
     public static void main(String[] args)
     {    
          //Handles running randall
          boolean randall_is_here = false;
          String os = System.getProperty("os.name");
          
          if (os.contains("Windows") == true)
          {
               randall_is_here = true;
               File pos = new File("Position.txt");
               ProcessBuilder randall = new ProcessBuilder("RandallBuilds/Randall.exe");
          }
          else if (os.contains("Mac")==true)
          {}
          else 
          {
               randall_is_here = true;
               File pos = new File("Position.txt");
               ProcessBuilder randall = new ProcessBuilder("RandallBuilds/Randall.exe");
          }
          //gets the window size, allowing it to be made fullscreen no matter the monitor.
          Dimension WindowSize = Toolkit.getDefaultToolkit().getScreenSize(); 
          JFrame Window = new JFrame();
          Window.setUndecorated(true);
          Window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
          //Makes the window mostly transparent, and makes it the full size of the window
          Window.setBackground(new Color(0f,0f,0f,0.75f));
          Window.setSize(WindowSize.width, WindowSize.height);
          Window.setAlwaysOnTop(true);
          Window.add(new NightOverlay());
          Window.setVisible(true);


     }

}
