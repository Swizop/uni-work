import java.io.*;
import java.util.*;
import java.util.stream.Collectors;

class Log {
    private String user;
    private String date;
    private long login_time;
    private long logout_time;

    public Log(String user, String date, long login_time, long logout_time) {
        this.user = user;
        this.date = date;
        this.login_time = login_time;
        this.logout_time = logout_time;
    }

    @Override
    public String toString() {
        return "Log{" +
                "user='" + user + '\'' +
                ", date='" + date + '\'' +
                ", login_time=" + login_time +
                ", logout_time=" + logout_time +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Log log = (Log) o;
        return login_time == log.login_time && logout_time == log.logout_time && Objects.equals(user, log.user) && Objects.equals(date, log.date);
    }

    @Override
    public int hashCode() {
        return Objects.hash(user, date, login_time, logout_time);
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public long getLogin_time() {
        return login_time;
    }

    public void setLogin_time(long login_time) {
        this.login_time = login_time;
    }

    public long getLogout_time() {
        return logout_time;
    }

    public void setLogout_time(long logout_time) {
        this.logout_time = logout_time;
    }
}

class Test {
    public static void main(String[] args) {
        List<Log> ls = new ArrayList<Log>();
        ls.add(new Log("swizop", "01.01.2017", 12, 16));
        ls.add(new Log("frank", "01.01.2017", 8, 14));
        ls.add(new Log("swizop", "04.01.2020", 9, 16));
        // ls.stream().filter(u -> u.getLogout_time() - u.getLogin_time() > 2).map(Log::getUser).distinct().forEach(System.out :: println);
        ls.stream().map(Log::getDate).distinct().forEach(System.out :: println);
        ls.stream().filter(l -> l.getDate() == "01.01.2017" && l.getLogin_time() <= 12).sorted(Comparator.comparing(Log::getUser)).map(Log::getUser).collect(Collectors.toList());
        ls.stream().collect(Collectors.groupingBy(Log::getUser, Collectors.toList(Log::getDate)));
    }
}
//try {
//        Connection conn = DriverManager.getConnection("jdbc..", "root", "");
//        Scanner sc = new Scanner(System.in);
//        int an_min = sc.nextInt();
//        int an_max = sc.nextInt();
//        String den_spec = sc.nextLine();
//
//        PreparedStatement ps = conn.prepareStatement("SELECT * FROM DiplomeLicenta WHERE an <= ? AND an >= ? AND specializare = ?");
//        ps.setInt(1, an_max);
//        ps.setInt(2, an_min);
//        ps.setString(3, den_spec);
//        ResultSet rs = ps.executeQuery();
//        List<Diploma> ls = new ArrayList<Diploma>();
//        while(rs.next()) {
//        Diploma d = new Diploma(ps.getString("serie"), ps.getString("absolvent"), ps.getInt("an"));
//        ls.add(d);
//        }
//
//        }
//        except(SQLException e) {
//        System.out.println("exceptie");
//        }
//class A{ public int x = 1; void afisare() { System.out.println(x); }
//}
//class B extends A{ public int x = 2; void afisare() { System.out.println(x); }
//}
//public class Test{ public static void main(String[] args) { A ob = new B(); System.out.println(++ob.x);
//}
//}

//class Diploma {
//    private String serie;
//    private String absolvent;
//    private int an;
//    private String facultate;
//    private String specializare;
//    private float Medie;
//
//    public String getSerie() {
//        return serie;
//    }
//
//    public void setSerie(String serie) {
//        this.serie = serie;
//    }
//
//    public String getAbsolvent() {
//        return absolvent;
//    }
//
//    public void setAbsolvent(String absolvent) {
//        this.absolvent = absolvent;
//    }
//
//    public int getAn() {
//        return an;
//    }
//
//    public void setAn(int an) {
//        this.an = an;
//    }
//
//    public String getFacultate() {
//        return facultate;
//    }
//
//    public void setFacultate(String facultate) {
//        this.facultate = facultate;
//    }
//
//    public String getSpecializare() {
//        return specializare;
//    }
//
//    public void setSpecializare(String specializare) {
//        this.specializare = specializare;
//    }
//
//    public float getMedie() {
//        return Medie;
//    }
//
//    public void setMedie(float medie) {
//        Medie = medie;
//    }
//
//    @Override
//    public String toString() {
//        return "Diploma{" +
//                "serie='" + serie + '\'' +
//                ", absolvent='" + absolvent + '\'' +
//                ", an=" + an +
//                ", facultate='" + facultate + '\'' +
//                ", specializare='" + specializare + '\'' +
//                ", Medie=" + Medie +
//                '}';
//    }
//
//    @Override
//    public boolean equals(Object o) {
//        if (this == o) return true;
//        if (o == null || getClass() != o.getClass()) return false;
//        Diploma diploma = (Diploma) o;
//        return an == diploma.an && Float.compare(diploma.Medie, Medie) == 0 && Objects.equals(serie, diploma.serie) && Objects.equals(absolvent, diploma.absolvent) && Objects.equals(facultate, diploma.facultate) && Objects.equals(specializare, diploma.specializare);
//    }
//
//    @Override
//    public int hashCode() {
//        return Objects.hash(serie, absolvent, an, facultate, specializare, Medie);
//    }
//
//    public Diploma(String serie, String absolvent, int an, String facultate, String specializare, float medie) {
//        this.serie = serie;
//        this.absolvent = absolvent;
//        this.an = an;
//        this.facultate = facultate;
//        this.specializare = specializare;
//        this.Medie = medie;
//    }
//}
//
//class Test {
//    public static void main(String[] args) {
//        ArrayList<Diploma> ls = new ArrayList<Diploma>();
//        ls.add(new Diploma("rk", "abs1", 2010, "FMI", "info", (float)3.5));
//        ls.add(new Diploma("ss", "abs2", 2005, "ASE", "mate", (float)10));
//        ls.add(new Diploma("raak", "abs3", 2019, "FMI", "info", (float)8.8));
//        // ls.stream().filter(d -> d.getAn() >= 2000 && d.getAn() <= 2010).sorted(Comparator.comparing(Diploma::getMedie).reversed()).forEach(System.out :: println);
//        //ls.stream().filter(d -> d.getFacultate() == "FMI").map(Diploma :: getSpecializare).distinct().forEach(System.out :: println);
////        List<String> ls2 = ls.stream().filter(d -> d.getMedie() == 10).map(Diploma :: getAbsolvent).collect(Collectors.toList());
////        for(String s : ls2)
////        {
////            System.out.println(s);
////        }
//        Long y = ls.stream().filter(d -> d.getSpecializare() == "info").collect(Collectors.counting());
//        System.out.println(y);
//    }
//}
//class Test {
//    public static void main(String[] args) {
//        Scanner sc = new Scanner(System.in);
//        int n = sc.nextInt();
//        HashSet<String> hs = new HashSet<String>();
//        for(int i = 1; i <= 1; i++) {
//            try {
//                File f = new File("input" + Integer.toString(i) + ".txt");
//                sc = new Scanner(f);
//                while(sc.hasNextLine()) {
//                    String[] line = sc.nextLine().split("[ !?,;.]+");
//                    for(String cuv : line) {
//                        if(cuv.length() == n)
//                            hs.add(cuv);
//                    }
//                }
//                Iterator<String> j = hs.iterator();
//                while(j.hasNext())
//                    System.out.println(j.next());
//            } catch(IOException e) {
//                System.out.println("exceptie");
//            }
//        }
//    }
//}

//class Test { static String sir = "A";
//    void A() { try { sir = sir + "B"; B(); } catch (Exception e) {
//        sir = sir + "C";
//    }
//    }
//    void B() throws Exception { try { sir = sir + "D"; C();
//    } catch (Exception e) { throw new Exception();  }
//    finally { sir = sir + "E";
//    }
//
//
//    }
//    void C() throws Exception { throw new Exception(); }
//    public static void main(String[] args) { Test ob = new Test(); ob.A(); System.out.println(sir);
//    }
//}