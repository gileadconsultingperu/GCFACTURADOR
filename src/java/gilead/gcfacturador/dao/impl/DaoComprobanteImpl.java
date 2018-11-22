package gilead.gcfacturador.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import gilead.gcfacturador.model.BeanComprobante;
import gilead.gcfacturador.sql.ConectaDb;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoComprobanteImpl {

    public List<BeanComprobante> getListar(String numeroComprobante, String tipoComprobante, String fecha_desde, String fecha_hasta) {
        ConectaDb db = new ConectaDb();
        Connection cn = db.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;

        List<BeanComprobante> comprobantes = null;
        BeanComprobante bc = null;

        if (cn != null) {
            try {
                String qry = "select idcomprobante, ubl, cli_tipodocumento, case when cli_tipodocumento='1' then 'DNI' when cli_tipodocumento='6' then 'RUC' end cli_abrevtipodocumento, "
                        + "cli_numerodocumento, cli_denominacion, cli_direccion, tipocomprobante, case when tipocomprobante='01' then 'FACTURA' when tipocomprobante='03' then 'BOLETA' "
                        + "when tipocomprobante='07' then 'NOTA CRÉDITO' when tipocomprobante='08' then 'NOTA DÉBITO' end abrevtipocomprobante, serie || '-' || correlativo nrocomprobante, "
                        + "fechaemision, moneda, total, case when resumenitemestado='1' then 'EMITIDO' when resumenitemestado='3' then 'ANULADO' end estado, linkpdf, linkxml, linkcdr "
                        + "from public.comprobante "
                        + "where 1 = 1";

                if (!numeroComprobante.equals("")) {
                    qry += " AND CONCAT(serie,'-', correlativo)  = '" + numeroComprobante.toUpperCase() + "'";
                }
                System.out.println("tipoComprobante: " + tipoComprobante);
                if (!tipoComprobante.equals("0")) {
                    qry += " AND tipocomprobante = '" + tipoComprobante + "'";
                }

                qry += " AND to_date(fechaemision,'yyyy-mm-dd') BETWEEN to_date('" + fecha_desde + "','dd/mm/yyyy') AND to_date('" + fecha_hasta + "','dd/mm/yyyy')";

                System.out.println("qry: " + qry);

                st = cn.prepareStatement(qry);

                rs = st.executeQuery();

                comprobantes = new ArrayList<>();

                while (rs.next()) {
                    bc = new BeanComprobante();
                    bc.setIdcomprobante(rs.getInt("idcomprobante"));
                    bc.setUbl(rs.getString("ubl"));
                    bc.setCli_tipodocumento(rs.getString("cli_tipodocumento"));
                    bc.setCli_abrevnumerodocumento(rs.getString("cli_abrevtipodocumento"));
                    bc.setCli_numerodocumento(rs.getString("cli_numerodocumento"));
                    bc.setCli_denominacion(rs.getString("cli_denominacion"));
                    bc.setCli_direccion(rs.getString("cli_direccion"));
                    bc.setTipocomprobante(rs.getString("tipocomprobante"));
                    bc.setAbrevtipocomprobante(rs.getString("abrevtipocomprobante"));
                    bc.setNrocomprobante(rs.getString("nrocomprobante"));
                    bc.setFechaemision(rs.getString("fechaemision"));
                    bc.setMoneda(rs.getString("moneda"));
                    bc.setTotal(rs.getString("total"));
                    bc.setEstado(rs.getString("estado"));
                    bc.setLinkpdf(rs.getString("linkpdf"));
                    bc.setLinkxml(rs.getString("linkxml"));
                    bc.setLinkcdr(rs.getString("linkcdr"));
                    comprobantes.add(bc);
                }

                cn.close();

            } catch (SQLException ex) {
                comprobantes = null;
                try {
                    cn.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(DaoComprobanteImpl.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
        }

        return comprobantes;
    }

    public BeanComprobante get(Integer idcomprobante) {
        ConectaDb db = new ConectaDb();
        Connection cn = db.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;

        BeanComprobante comprobante = null;

        if (cn != null) {
            try {
                String qry = "SELECT idcomprobante, ubl, cli_tipodocumento, cli_numerodocumento, cli_denominacion, cli_direccion, tipocomprobante, serie || '-' || correlativo nrocomprobante, fechaemision, moneda, total, estado, linkpdf, linkxml, linkcdr, cdr, resumenidentificador, resumenitemestado, bajaidentificador, resumencdr\n"
                        + "	FROM public.comprobante\n"
                        + "    WHERE idcomprobante = ?";

                st = cn.prepareStatement(qry);
                st.setInt(1, idcomprobante);
                rs = st.executeQuery();

                while (rs.next()) {
                    comprobante = new BeanComprobante();
                    comprobante.setIdcomprobante(rs.getInt("idcomprobante"));
                    comprobante.setUbl(rs.getString("ubl"));
                    comprobante.setCli_tipodocumento(rs.getString("cli_tipodocumento"));
                    comprobante.setCli_numerodocumento(rs.getString("cli_numerodocumento"));
                    comprobante.setCli_denominacion(rs.getString("cli_denominacion"));
                    comprobante.setCli_direccion(rs.getString("cli_direccion"));
                    comprobante.setTipocomprobante(rs.getString("tipocomprobante"));
                    comprobante.setNrocomprobante(rs.getString("nrocomprobante"));
                    comprobante.setFechaemision(rs.getString("fechaemision"));
                    comprobante.setMoneda(rs.getString("moneda"));
                    comprobante.setTotal(rs.getString("total"));
                    comprobante.setEstado(rs.getString("estado"));
                    comprobante.setLinkpdf(rs.getString("linkpdf"));
                    comprobante.setLinkxml(rs.getString("linkxml"));
                    comprobante.setLinkcdr(rs.getString("linkcdr"));
                }

                cn.close();

            } catch (SQLException ex) {
                System.out.println("SQLException: " + ex.toString());
                comprobante = null;
                try {
                    cn.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(DaoComprobanteImpl.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
        }
        return comprobante;
    }
}
