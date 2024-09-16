package docslib;

import java.io.Serializable;

public class Document implements Serializable {

    private static final long serialVersionUID = 1L;
    public String name;
    public double uspeh;
    public double dohod;
    public String fakultet;

    public Document(String name, double uspeh, double dohod, String fakultet) {
        this.name = name;
        this.dohod = dohod;
        this.uspeh = uspeh;
        this.fakultet = fakultet;
    }
}
