package gilead.gcfacturador.dao.impl;

import gilead.gcfacturador.model.BeanEmpresa;
import gilead.gcfacturador.sql.ConectaDb;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoEmpresaImpl {
    
    public BeanEmpresa accionObtener(Integer id) {
        BeanEmpresa empresa = null;

        ConectaDb db = new ConectaDb();
        Connection cn = db.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;

        if (cn != null) {
            try {
                String qry = "SELECT *\n"
                        + "	FROM gcfacturador.empresa\n"
                        + "    WHERE id_empresa = ?";

                st = cn.prepareStatement(qry);
                st.setInt(1, id);

                rs = st.executeQuery();

                while (rs.next()) {
                    empresa = new BeanEmpresa();
                    empresa.setIdempresa(rs.getInt("id_empresa"));
                    empresa.setRuc(rs.getString("ruc"));
                    empresa.setRazonsocial(rs.getString("razon_social"));
                    empresa.setCodigopais(rs.getString("codigo_pais"));
                    empresa.setUbidistrito(rs.getString("codigo_ubidistrito"));
                    empresa.setDireccion(rs.getString("direccion"));
                    empresa.setTelefono(rs.getString("telefono"));
                    empresa.setCorreo(rs.getString("correo"));
                    empresa.setEstado(rs.getString("estado"));     
                    empresa.setFechaInsercion(rs.getTimestamp("fecha_insercion"));
                    empresa.setUsuarioInsercion(rs.getString("usuario_insercion"));
                    empresa.setTerminalInsercion(rs.getString("terminal_insercion"));
                    empresa.setIpInsercion(rs.getString("ip_insercion"));
                    empresa.setFechaModificacion(rs.getTimestamp("fecha_modificacion"));
                    empresa.setUsuarioModificacion(rs.getString("usuario_modificacion"));
                    empresa.setTerminalModificacion(rs.getString("terminal_modificacion"));
                    empresa.setIpModificacion(rs.getString("ip_modificacion"));
                }

                cn.close();

            } catch (SQLException e1) {
                System.out.println(e1.getMessage());
                empresa = null;
            }
        }

        return empresa;
    }
}
