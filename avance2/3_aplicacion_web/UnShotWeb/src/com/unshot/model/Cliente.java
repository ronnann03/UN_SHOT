package com.unshot.model;

public class Cliente {

    private int    idCliente;
    private String nombre;
    private String apellido;
    private String telefono;
    private String email;
    private String fechaRegistro;

    public int    getIdCliente()     { return idCliente;     }
    public String getNombre()        { return nombre;        }
    public String getApellido()      { return apellido;      }
    public String getTelefono()      { return telefono;      }
    public String getEmail()         { return email;         }
    public String getFechaRegistro() { return fechaRegistro; }

    public void setIdCliente(int v)        { this.idCliente     = v; }
    public void setNombre(String v)        { this.nombre        = v; }
    public void setApellido(String v)      { this.apellido      = v; }
    public void setTelefono(String v)      { this.telefono      = v; }
    public void setEmail(String v)         { this.email         = v; }
    public void setFechaRegistro(String v) { this.fechaRegistro = v; }
}
