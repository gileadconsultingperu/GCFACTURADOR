/** 
    Compañia            : Gilead Consulting S.A.C.
    Sistema             : GC-Business
    Módulo              : Seguridad
    Nombre              : DaoUsuarioImpl.java
    Versión             : 1.0
    Fecha Creación      : 21-08-2018
    Autor Creación      : Pablo Jimenez Aguado
    Uso                 : Clase que accede a los datos de la tabla usuario
*/
package gilead.gcfacturador.dao.impl;

import gilead.gcfacturador.dao.DaoAccion;
import gilead.gcfacturador.model.BeanUsuario;
import gilead.gcfacturador.sql.ConectaDb;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class DaoUsuarioImpl implements DaoAccion{

    @Override
    public String accionCrear(Object obj) {
        String msg = null;

        ConectaDb db = new ConectaDb();
        Connection cn = db.getConnection();
        Statement st = null;

        BeanUsuario usuario = (BeanUsuario) obj;

        if (cn != null) {
            try {
                String qry = "INSERT INTO gcfacturador.usuario (apellidos,nombres,estado,usuario,password,fecha_insercion,usuario_insercion,terminal_insercion,ip_insercion) "
                        + "VALUES ('" + usuario.getApellidos() + "','" + usuario.getNombres() + "','" + usuario.getEstado()
                        + "','" + usuario.getUsuario() + "',MD5('" + usuario.getPassword() + usuario.getUsuario() + "'), '"+usuario.getFechaInsercion()
                        + "', '" + usuario.getUsuarioInsercion()+"', '"+usuario.getTerminalInsercion()+"', '"+usuario.getIpInsercion()+"')";
                
                st = cn.createStatement();

                int n = st.executeUpdate(qry);
                
                if (n <= 0) {
                    msg = "0 filas afectadas";
                }

                cn.close();

            } catch (SQLException e1) {
                System.out.println(e1.getMessage());
                msg = e1.getMessage();
            } finally {
                try {
                    cn.close();
                } catch (SQLException e2) {
                    System.out.println(e2.getMessage());
                    msg = e2.getMessage();
                }
            }
        }

        return msg;
    }

    @Override
    public BeanUsuario accionObtener(Integer id) {
        BeanUsuario usuario = null;

        ConectaDb db = new ConectaDb();
        Connection cn = db.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;

        if (cn != null) {
            try {
                String qry = "SELECT *\n"
                        + "	FROM gcfacturador.usuario\n"
                        + "    WHERE id_usuario = ?";

                st = cn.prepareStatement(qry);
                st.setInt(1, id);

                rs = st.executeQuery();

                while (rs.next()) {
                    usuario = new BeanUsuario();
                    usuario.setIdusuario(rs.getInt(1));
                    usuario.setUsuario(rs.getString(2));
                    usuario.setPassword(rs.getString(3));
                    usuario.setNombres(rs.getString(4));
                    usuario.setApellidos(rs.getString(5));
                    usuario.setEstado(rs.getString(6));     
                    usuario.setFechaInsercion(rs.getTimestamp(7));
                    usuario.setUsuarioInsercion(rs.getString(8));
                    usuario.setTerminalInsercion(rs.getString(9));
                    usuario.setIpInsercion(rs.getString(10));
                    usuario.setFechaModificacion(rs.getTimestamp(11));
                    usuario.setUsuarioModificacion(rs.getString(12));
                    usuario.setTerminalModificacion(rs.getString(13));
                    usuario.setIpModificacion(rs.getString(14));
                }

                cn.close();

            } catch (SQLException e1) {
                System.out.println(e1.getMessage());
                usuario = null;
            }
        }

        return usuario;
    }
    
    @Override
    public String accionActualizar(Object obj) {
        String msg = null;

        ConectaDb db = new ConectaDb();
        Connection cn = db.getConnection();
        Statement st = null;

        BeanUsuario usuario = (BeanUsuario) obj;

        if (cn != null) {
            try {
                String qry = "UPDATE gcfacturador.usuario SET apellidos = '" + usuario.getApellidos().toUpperCase()
                        + "', nombres = '" + usuario.getNombres().toUpperCase()
                        + "', estado = '" + usuario.getEstado().toUpperCase()
                        + "', fecha_modificacion = '" + usuario.getFechaModificacion()
                        + "', usuario_modificacion = '" + usuario.getUsuarioModificacion()
                        + "', terminal_modificacion = '" + usuario.getTerminalModificacion()
                        + "', ip_modificacion = '" + usuario.getIpModificacion() + "' "
                        + "WHERE id_usuario = " + usuario.getIdusuario();

                st = cn.createStatement();

                int n = st.executeUpdate(qry);

                if (n <= 0) {
                    msg = "0 filas afectadas";
                }

                cn.close();

            } catch (SQLException e1) {
                System.out.println(e1.getMessage());
                msg = e1.getMessage();
            } finally {
                try {
                    cn.close();
                } catch (SQLException e2) {
                    System.out.println(e2.getMessage());
                    msg = e2.getMessage();
                }
            }
        }

        return msg;
    }

    @Override
    public String accionEliminar(Integer id) {
        String msg = null;

        ConectaDb db = new ConectaDb();
        Connection cn = db.getConnection();
        Statement st = null;

        if (cn != null) {
            try {
                String qry = "UPDATE gcfacturador.usuario SET estado = 'I' WHERE id_usuario = " + id;

                st = cn.createStatement();

                int n = st.executeUpdate(qry);

                if (n <= 0) {
                    msg = "0 filas afectadas";
                }

                cn.close();

            } catch (SQLException e1) {
                System.out.println(e1.getMessage());
                msg = e1.getMessage();
            } finally {
                try {
                    cn.close();
                } catch (SQLException e2) {
                    System.out.println(e2.getMessage());
                    msg = e2.getMessage();
                }
            }
        }

        return msg;
    }

    @Override
    public List<BeanUsuario> accionListar() {
        BeanUsuario usuario = null;

        ConectaDb db = new ConectaDb();
        Connection cn = db.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;

        List<BeanUsuario> listUsuario = null;

        if (cn != null) {
            try {
                String qry = "SELECT *\n"
                        + "	FROM gcfacturador.usuario ORDER BY id_usuario";

                st = cn.prepareStatement(qry);

                rs = st.executeQuery();

                listUsuario = new LinkedList<BeanUsuario>();

                while (rs.next()) {
                    usuario = new BeanUsuario();
                    usuario.setIdusuario(rs.getInt(1));
                    usuario.setUsuario(rs.getString(2));
                    usuario.setPassword(rs.getString(3));
                    usuario.setNombres(rs.getString(4));
                    usuario.setApellidos(rs.getString(5));       
                    usuario.setEstado(rs.getString(6));
                    usuario.setFechaInsercion(rs.getTimestamp(7));
                    usuario.setUsuarioInsercion(rs.getString(8));
                    usuario.setTerminalInsercion(rs.getString(9));
                    usuario.setIpInsercion(rs.getString(10));
                    usuario.setFechaModificacion(rs.getTimestamp(11));
                    usuario.setUsuarioModificacion(rs.getString(12));
                    usuario.setTerminalModificacion(rs.getString(13));
                    usuario.setIpModificacion(rs.getString(14));

                    listUsuario.add(usuario);
                }

                cn.close();

            } catch (SQLException e1) {
                System.out.println(e1.getMessage());
                usuario = null;
            }
        }

        return listUsuario;
    }    
    
    @Override
    public String accionActivar(Integer id) {
        String msg = null;

        ConectaDb db = new ConectaDb();
        Connection cn = db.getConnection();
        Statement st = null;

        if (cn != null) {
            try {
                String qry = "UPDATE gcfacturador.usuario SET estado = 'A' WHERE id_usuario = " + id;

                st = cn.createStatement();

                int n = st.executeUpdate(qry);

                if (n <= 0) {
                    msg = "0 filas afectadas";
                }

                cn.close();

            } catch (SQLException e1) {
                System.out.println(e1.getMessage());
                msg = e1.getMessage();
            } finally {
                try {
                    cn.close();
                } catch (SQLException e2) {
                    System.out.println(e2.getMessage());
                    msg = e2.getMessage();
                }
            }
        }

        return msg;
    }
    
    public Integer autentica(String usuario, String password) {
        ConectaDb db = new ConectaDb();
        Connection cn = db.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;

        Integer idusuario = null;

        if (cn != null) {
            try {
                String qry = "SELECT id_usuario\n"
                        + "	FROM gcfacturador.usuario\n"
                        + "    WHERE usuario = ? AND password = MD5(?)";

                st = cn.prepareStatement(qry);
                st.setString(1, usuario);
                st.setString(2, password + usuario);

                rs = st.executeQuery();

                while (rs.next()) {
                    idusuario = rs.getInt(1);
                }

                cn.close();

            } catch (SQLException e1) {
                System.out.println(e1.getMessage());
                idusuario = null;
            }
        }

        return idusuario;
    }
    
    public String actualizarPassword(BeanUsuario usuario) {
        String msg = null;

        ConectaDb db = new ConectaDb();
        Connection cn = db.getConnection();
        Statement st = null;

        if (cn != null) {
            try {
                String qry = "UPDATE gcfacturador.usuario SET password = MD5('" + usuario.getPassword() + "' || usuario)"
                        + ", fecha_modificacion = '" + usuario.getFechaModificacion()
                        + "', usuario_modificacion = '" + usuario.getUsuarioModificacion()
                        + "', terminal_modificacion = '" + usuario.getTerminalModificacion()
                        + "', ip_modificacion = '" + usuario.getIpModificacion() + "' "
                        + "WHERE id_usuario = " + usuario.getIdusuario();

                st = cn.createStatement();

                int n = st.executeUpdate(qry);

                if (n <= 0) {
                    msg = "0 filas afectadas";
                }

                cn.close();

            } catch (SQLException e1) {
                System.out.println(e1.getMessage());
                msg = e1.getMessage();
            } finally {
                try {
                    cn.close();
                } catch (SQLException e2) {
                    System.out.println(e2.getMessage());
                    msg = e2.getMessage();
                }
            }
        }

        return msg;
    }
}
