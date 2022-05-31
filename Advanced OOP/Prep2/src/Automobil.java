public class Automobil {
    private String marca;
    private String model;
    private int capacitate;
    private int pret;

    public String getMarca() {
        return this.marca;
    }
    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public int getCapacitate() {
        return capacitate;
    }

    public void setCapacitate(int capacitate) {
        this.capacitate = capacitate;
    }

    public int getPret() {
        return pret;
    }

    public void setPret(int pret) {
        this.pret = pret;
    }

    @Override
    public String toString() {
        return "masina " + this.marca + " model " + this.model + " " + this.capacitate + " " + this.pret;
    }

    @Override
    public boolean equals(Object b) {
        Automobil a = (Automobil) b;
        if(this.model == a.model && this.marca == a.marca && this.capacitate == a.capacitate)
            return true;
        return false;
    }

    @Override
    public int hashCode() {
        return super.hashCode();
    }

    public Automobil(String marca, String model, int capacitate, int pret) {
        this.marca = marca;
        this.model = model;
        this.capacitate = capacitate;
        this.pret = pret;
    }
}
