package com.unshot.model;

public class Bebida {

    private int    idBebida;
    private String nombre;
    private String categoria;
    private String descripcion;
    private double precio;

    public int    getIdBebida()    { return idBebida;    }
    public String getNombre()      { return nombre;      }
    public String getCategoria()   { return categoria;   }
    public String getDescripcion() { return descripcion; }
    public double getPrecio()      { return precio;      }

    public void setIdBebida(int v)       { this.idBebida    = v; }
    public void setNombre(String v)      { this.nombre      = v; }
    public void setCategoria(String v)   { this.categoria   = v; }
    public void setDescripcion(String v) { this.descripcion = v; }
    public void setPrecio(double v)      { this.precio      = v; }
}
