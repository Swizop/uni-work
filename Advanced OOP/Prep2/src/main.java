import java.util.*;
import java.io.*;

import java.util.*;
import java.io.*;



//import java.util.*;
//import java.io.*;
//import java.util.stream.Collectors;
//
//import static java.util.stream.Collectors.groupingBy;
//
//public class main {
//    public static void main(String[] args) {
//        Scanner sc = new Scanner(System.in);
//        String cuv = sc.nextLine();
//        Class3 thread = new Class3();
//        thread.setCuvant(cuv);
//        for(int i = 1; i < 3; i++) {
//            File f = new File("input" + Integer.toString(i) + ".txt");
//            thread.setFile(f);
//            thread.start();
//            try {
//                thread.join();
//            }
//            catch(InterruptedException e)
//            {
//                System.out.println("abddasdac");
//            }
//        }
//    }
////    public static void main(String[] args) {
////        ArrayList<Automobil> ls = new ArrayList<Automobil>();
////        ls.add(new Automobil("Renault", "Symbol", 4, 3500));
////        ls.add(new Automobil("Lada", "Lada", 10, 6800));
////        ls.add(new Automobil("Lada", "C4", 4, 7500));
////        // afișați automobilele care costă cel puțin 5000€, în ordinea descrescătoare a prețurilor;
////
////        ls.stream().filter(a -> a.getPret() > 5000).sorted((u, v) -> v.getPret() - u.getPret()).forEach(System.out :: println);
////        ls.stream().map(a -> a.getMarca()).distinct().forEach(System.out :: println);
////
////        // creați o listă formată din automobilele care au capacitatea cilindrică cuprinsă între 2000 și 3000 cm3;
////        ls.stream().filter(a -> a.getCapacitate() > 3 && a.getCapacitate() < 5).collect(Collectors.toList());
////        // afișați pentru fiecare marcă modelele existente.
////        //Map<String, List<String>> map = ls.stream().collect(groupingBy(Automobil::getMarca, collect(Collectors.toList(Automobil::getModel))));
////    }
//}
//
//
//// SPLIT + ARGS
////    public static void main(String[] args) {
////        /* Enter your code here. Read input from STDIN. Print output to STDOUT. Your class should be named Solution. */
////        Scanner sc = new Scanner(System.in);
////        String str = sc.nextLine();
////        String[] ls = str.split("[\t !,?._'@]+");
////        int nr = 0;
////        for(String s : ls)
////            if(s.length() > 0)
////                nr ++;
////
////        System.out.println(nr);
////        for(String s : ls)
////            if(s.length() > 0)
////                System.out.println(s);
////    }
