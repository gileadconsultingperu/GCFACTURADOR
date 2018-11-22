package gilead.gcfacturador.dao.impl;

import gilead.gcfacturador.model.BeanSeguimientoComprobante;
import gilead.gcfacturador.sql.ConectaDb;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoSeguimientoComprobanteImpl {

    public List<BeanSeguimientoComprobante> getListar(Integer idcomprobante) {
        ConectaDb db = new ConectaDb();
        Connection cn = db.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;

        List<BeanSeguimientoComprobante> seguimientoComprobantes = null;
        BeanSeguimientoComprobante bsc = null;

        if (cn != null) {
            try {
                String qry = "SELECT idcomprobante, case when estado='X' then 'Generar XML' when estado='P' then 'Crear PDF' when estado='S' then 'Enviar SUNAT' end descripcionestado, estado, cdr, cdrnota, cdrobservacion "
                        + "FROM public.seguimientocomprobante "
                        + "WHERE idcomprobante = ? "
                        + "ORDER BY idseguimientocomprobante";

                st = cn.prepareStatement(qry);

                st.setInt(1, idcomprobante);

                rs = st.executeQuery();

                seguimientoComprobantes = new ArrayList<>();

                while (rs.next()) {
                    bsc = new BeanSeguimientoComprobante();
                    bsc.setIdcomprobante(rs.getInt("idcomprobante"));
                    bsc.setEstado(rs.getString("estado"));
                    bsc.setDescripcionestado(rs.getString("descripcionestado"));
                    bsc.setCdr(rs.getString("cdr"));
                    bsc.setCdrnota(rs.getString("cdrnota"));
                    bsc.setCdrobservacion(rs.getString("cdrobservacion"));

                    seguimientoComprobantes.add(bsc);
                }

                cn.close();

            } catch (SQLException ex) {
                seguimientoComprobantes = null;
                try {
                    cn.close();
                } catch (SQLException ex1) {
                    Logger.getLogger(DaoSeguimientoComprobanteImpl.class.getName()).log(Level.SEVERE, null, ex1);
                }
            }
        }

        return seguimientoComprobantes;
    }

}
