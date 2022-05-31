import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

public class Class3 extends Thread{
    private File file;
    private String cuvant;
    public void setFile(File file)
    {
        this.file = file;
    }
    public void setCuvant(String cuvant)
    {
        this.cuvant = cuvant;
    }
    @Override
    public void run()
    {
        try {
            Scanner sc = new Scanner(this.file);
            int nr = 0;
            while(sc.hasNextLine())
            {
                String line = sc.nextLine();
                String[] ls = line.split("[! ?.,;]+");
                for(String s : ls)
                {
                    if(s.compareTo(cuvant) == 0)
                        nr += 1;
                }
            }
            System.out.println(nr);
        }
        catch(FileNotFoundException e) {
            System.out.println("Error!");
        }

    }
}
