/*
 * The below code is quite raw, no gui, mostly hardcoded etc.
 * but for a quick and simple assignment it is perfect I beleive
 * also, I haven't made javadocs on purpose, see the code, some pieces of code
 * are redundant but for the sake of clarity of construction are split into
 * separate methods
 * Standard MIT licence, fell free to share and commit
 * Standard JDK 1.7 req
 */
package man;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;

/**
 *
 * @author Jakub
 */
public class Mandala {
    public static int [] sequence= {3,5,2,1,0,7};
    public static int recursion=50;
    public static BufferedImage img =new BufferedImage (600, 600,BufferedImage.TYPE_INT_RGB);
    static Color [] color = {Color.black, Color.red, Color.green, Color.yellow, Color.white, Color.pink, Color.magenta, Color.blue, Color.orange, Color.green};


  public static void main(String[] args) throws IOException {
        int [][] grid = new int [300][300];
        //fill the grid with mandala sequencing
        axisx(grid,sequence);
        axisy(grid,sequence);
        summation(grid);

        //original grid is bottom right so that it takes 300 - 600 for x and 0 -300 for y
        int [][] gridtr=gridtr(grid, 300); //reversing grid
        int [][] gridbl=gridbl(grid, 300);
        int [][] gridtl=gridtl(grid, 300);
        
        int [][] biggrid = new int [600][600];
        
        //below is the setup of picture
        //the triangles have to be properly put together to form a
        //desired mandala set
         for (int i = 0; i < 300; i++) {
            for (int j = 0; j < 300 ; j++) {
                biggrid[i][j]=gridtl[i][j];
            }
        }
        for (int i = 300; i < 600; i++) {
            for (int j = 0; j < 300; j++) {
                biggrid[i][j]=gridbl[i-300][j];
            }
        }
        for (int i = 0; i < 300; i++) {
            for (int j =300; j < 600; j++) {
                biggrid[i][j]=gridtr[i][j-300];
            }
        }
        
          for (int i = 300; i < 600; i++) {
            for (int j =300; j < 600; j++) {
                biggrid[i][j]=grid[j-300][i-300];
            }
        }
        //color the picture
        for (int i = biggrid.length-1; i >=0; i--) {
            System.out.print("\n");
            for (int j = 0; j <biggrid.length; j++) {
               // System.out.print(" "+ grid[i][j]);
                Color t=color[biggrid[i][j]];
                img.setRGB(i,j,t.getRGB());
                //System.out.print(" "+t.getRGB());
            }
        }
       
        File f = new File("C:\\Users\\Jakub\\Desktop\\Mandala2primes.jpg");
        ImageIO.write(img, "JPEG", f);
        
    }
  
    public static void summation(int [][] grid){
           int l = grid.length-1;
       for (int i = 1; i < grid.length; i++,l--) {
           for (int j = 1 ; j < l; j++) {
               grid[i][j]=sum(grid[i-1][j],grid[i][j-1]);
           }
       }
    }
    
   public static int sum(int a,int b){
       if(a+b<=9){
           return a+b;
       }
       else if (a+b>9) {
           return ((a+b)-9);
       }  
       else return 0;
    }       
  
    //propagate the inverse and not inversed sequence over axis x and y
    public static void axisx(int[][] grid, int [] seq){
       int curr = recursion;
        for (int j = 0; j < curr; j++) {
            if(j%2==0) {
                for (int i = 0; i < 6; i++) {
                    grid [0][6*j + i]=seq[i];
                }
           }
            else {
                for (int i = 0; i < 6; i++) {
                grid [0][6*j+i]=inverse(seq)[i];    
                }
            }
        }
    }
    
    public static void axisy(int[][] grid, int [] seq){
       int curr = recursion;
        for (int j = 0; j < curr; j++) {
            if(j%2==0) {
                for (int i = 0; i < 6; i++) {
                    grid[6*j + i][0]=seq[i];
                }
           }
            else {
                for (int i = 0; i < 6; i++) {
                grid [6*j+i][0]=inverse(seq)[i];    
                }
            }
        }
    } 
    //additional primes function in case someone would like to see 
    //primes in the picture   
    public static void primes (int [][] grid){
         for (int i = 0; i < grid.length; i++) {
             for (int j = 0; j < grid.length; j++) {
                 int temp= grid[i][j];
                 if(temp==2 || temp==3 || temp==5 || temp==7){
                     grid[i][j]=0; //set to black
                 }
                 else grid[i][j]=4;
             }
         }
     }  
    

    
    //inverse the sequence 
    public static int[] inverse(int [] sequence){
        int [] invseq=new int [sequence.length];
        for (int i = sequence.length; i > 0; i--) {       
            invseq[sequence.length-i]=sequence[i-1];
        }
        return invseq;
    }
    //set of messy functions to produce proper triangles
    public static int [][] gridtr(int [][] grid, int size){
       int grid2 [][] = new int [size][size];
       for (int i = 0; i<grid.length; i++) {
           for (int j = 0; j <grid.length; j++) {
               grid2[i][j]=grid[grid.length-1-i][j];
           }
       }
       return grid2;
   }

    public static int [][] gridtl(int [][] grid, int size){
       int grid4 [][] = new int [size][size]; 
       for (int i = 0; i<grid.length; i++) {
           for (int j = 0; j <grid.length; j++) {
               grid4[i][j]=grid[grid.length-1-i][grid.length-1-j];
           }
       }
       return grid4;
   }
    
    public static int [][] gridbl(int [][] grid, int size){
       int grid3 [][] = new int [size][size];
        for (int i = 0; i<grid.length; i++) {
           for (int j = 0; j <grid.length; j++) {
               grid3[i][j]=grid[i][grid.length-1-j];
           }
       }
       return grid3;
   }

}
