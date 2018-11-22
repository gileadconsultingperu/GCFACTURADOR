package gilead.gcfacturador.model;

import java.io.Serializable;

public class BeanComprobante implements Serializable {

    private Integer idcomprobante;
    private String ubl;
    private String cli_tipodocumento;
    private String cli_numerodocumento;
    private String cli_abrevnumerodocumento;
    private String cli_denominacion;
    private String cli_direccion;
    private String tipocomprobante;
    private String abrevtipocomprobante;
    private String nrocomprobante;
    private String fechaemision;
    private String moneda;
    private String total;
    private String estado;
    private String linkpdf;
    private String linkxml;
    private String linkcdr;
//    private String cdr;
//    private String resumenidentificador;
//    private String resumenitemestado;
//    private String bajaidentificador;
//    private String resumencdr;
//    private String bajacdr;
//    private String notatipocomprobante;
//    private String notaserie;
//    private String notacorrelativo;

    public BeanComprobante() {
    }

    public Integer getIdcomprobante() {
        return idcomprobante;
    }

    public void setIdcomprobante(Integer idcomprobante) {
        this.idcomprobante = idcomprobante;
    }

    public String getUbl() {
        return ubl;
    }

    public void setUbl(String ubl) {
        this.ubl = ubl;
    }

    public String getCli_tipodocumento() {
        return cli_tipodocumento;
    }

    public void setCli_tipodocumento(String cli_tipodocumento) {
        this.cli_tipodocumento = cli_tipodocumento;
    }

    public String getCli_numerodocumento() {
        return cli_numerodocumento;
    }

    public void setCli_numerodocumento(String cli_numerodocumento) {
        this.cli_numerodocumento = cli_numerodocumento;
    }

    public String getCli_abrevnumerodocumento() {
        return cli_abrevnumerodocumento;
    }

    public void setCli_abrevnumerodocumento(String cli_abrevnumerodocumento) {
        this.cli_abrevnumerodocumento = cli_abrevnumerodocumento;
    }

    public String getCli_denominacion() {
        return cli_denominacion;
    }

    public void setCli_denominacion(String cli_denominacion) {
        this.cli_denominacion = cli_denominacion;
    }

    public String getCli_direccion() {
        return cli_direccion;
    }

    public void setCli_direccion(String cli_direccion) {
        this.cli_direccion = cli_direccion;
    }

    public String getTipocomprobante() {
        return tipocomprobante;
    }

    public void setTipocomprobante(String tipocomprobante) {
        this.tipocomprobante = tipocomprobante;
    }

    public String getAbrevtipocomprobante() {
        return abrevtipocomprobante;
    }

    public void setAbrevtipocomprobante(String abrevtipocomprobante) {
        this.abrevtipocomprobante = abrevtipocomprobante;
    }

    public String getNrocomprobante() {
        return nrocomprobante;
    }

    public void setNrocomprobante(String nrocomprobante) {
        this.nrocomprobante = nrocomprobante;
    }

    public String getFechaemision() {
        return fechaemision;
    }

    public void setFechaemision(String fechaemision) {
        this.fechaemision = fechaemision;
    }

    public String getMoneda() {
        return moneda;
    }

    public void setMoneda(String moneda) {
        this.moneda = moneda;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getLinkpdf() {
        return linkpdf;
    }

    public void setLinkpdf(String linkpdf) {
        this.linkpdf = linkpdf;
    }

    public String getLinkxml() {
        return linkxml;
    }

    public void setLinkxml(String linkxml) {
        this.linkxml = linkxml;
    }

    public String getLinkcdr() {
        return linkcdr;
    }

    public void setLinkcdr(String linkcdr) {
        this.linkcdr = linkcdr;
    }

}
