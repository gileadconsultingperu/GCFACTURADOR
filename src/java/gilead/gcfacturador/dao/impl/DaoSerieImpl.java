package gilead.gcfacturador.dao.impl;

import gilead.gcfacturador.sql.ConectaDb;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoSerieImpl {
    
    public String obtenerNumeroDocumento(String tipocomprobante, String tipocomprobanteref) {
        String numerodocumento = null;

        ConectaDb db = new ConectaDb();
        Connection cn = db.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;

        if (cn != null) {
            try {
                String qry = "SELECT serie,correlativo_serie\n"
                        + "	FROM gcfacturador.serie\n"
                        + "    WHERE tipo_comprobante = ? AND tipo_comprobante_ref = ? AND estado='A'";

                st = cn.prepareStatement(qry);
                st.setString(1, tipocomprobante);
                st.setString(2, tipocomprobanteref);
                rs = st.executeQuery();

                if (rs.next()) {
                    numerodocumento = rs.getString("serie")+"-"+String.format("%08d", rs.getInt("correlativo_serie"));
                }

                cn.close();

            } catch (SQLException e1) {
                System.out.println(e1.getMessage());
                numerodocumento = null;
            }
        }

        return numerodocumento;
    }
    
}
