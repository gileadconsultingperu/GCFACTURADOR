package gilead.gcfacturador.model;

import java.io.Serializable;

public class BeanSeguimientoComprobante implements Serializable {

    private Integer idcomprobante;
    private String estado;
    private String descripcionestado;
    private String cdr;
    private String cdrnota;
    private String cdrobservacion;

    public BeanSeguimientoComprobante() {
    }

    public String getDescripcionestado() {
        return descripcionestado;
    }

    public void setDescripcionestado(String descripcionestado) {
        this.descripcionestado = descripcionestado;
    }

    public Integer getIdcomprobante() {
        return idcomprobante;
    }

    public void setIdcomprobante(Integer idcomprobante) {
        this.idcomprobante = idcomprobante;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getCdr() {
        return cdr;
    }

    public void setCdr(String cdr) {
        this.cdr = cdr;
    }

    public String getCdrnota() {
        return cdrnota;
    }

    public void setCdrnota(String cdrnota) {
        this.cdrnota = cdrnota;
    }

    public String getCdrobservacion() {
        return cdrobservacion;
    }

    public void setCdrobservacion(String cdrobservacion) {
        this.cdrobservacion = cdrobservacion;
    }

}
