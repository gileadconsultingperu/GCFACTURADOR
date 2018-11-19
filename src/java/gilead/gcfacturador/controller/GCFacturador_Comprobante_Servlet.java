package gilead.gcfacturador.controller;

import gilead.gcfacturador.sql.ConectaDb;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class GCFacturador_Comprobante_Servlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, JSONException {
        response.setContentType("text/html;charset=UTF-8");

        // Obtengo la sesion activa
        HttpSession session = request.getSession(false);

        String opcion = request.getParameter("opcion");
        System.out.println("Entro GESTION COMPROBANTE");
        if (opcion.equals("listar")) {

        } else if (opcion.equals("registrar")) {
            System.out.println("REGISTRAR COMPROBANTE");
            PrintWriter out = response.getWriter();
            ConectaDb db = new ConectaDb();
            Connection cn = null;
            Statement st = null;
            String sqlEjecucion = null;
            String json = null;
            try {
                cn = db.getConnection();
                cn.setAutoCommit(false);
                st = cn.createStatement();

                Integer idVenta = 0;
                String query = "SELECT NEXTVAL('gcfacturador.comprobante_id_comprobante_seq')";
                sqlEjecucion = query;

                ResultSet rs = st.executeQuery(query);

                if (rs.next()) {
                    idVenta = rs.getInt(1);
                }

                String tipoComprobante = request.getParameter("tipoComprobante");
                
                //DATOS COMPROBANTE REFERENCIA SI ES NOTA DE CREDITO (07) O NOTA DE DEBITO(08)
                String tipoComprobanteRef = "", nrodocumentoref="", serieRef = "", tipo_nota = "", motivo_nota = "";
                int correlativoRef = 0;
                
                if (tipoComprobante.equals("07") || tipoComprobante.equals("08")) {
                    tipoComprobanteRef = request.getParameter("tipocomprobanteref");
                    if (tipoComprobante.equals("07")) {
                        tipo_nota = request.getParameter("tiponotacredito");
                    } else {
                        tipo_nota = request.getParameter("tiponotadebito");
                    }
                    motivo_nota = request.getParameter("motivonota");
                    nrodocumentoref = request.getParameter("nrodocumentoref");
                    serieRef = nrodocumentoref.substring(0, 4);
                    correlativoRef = Integer.parseInt(nrodocumentoref.substring(6, 14));
                }
                
                //Obtener serie y correlativo actual
                String serie = "";
                int correlativo = 0;
                String query2 = "SELECT serie, correlativo_serie FROM gcfacturador.serie WHERE tipo_comprobante='" + tipoComprobante + "' AND tipo_comprobante_ref = '"+tipoComprobanteRef +"' AND estado='A';";
                ResultSet rs2 = st.executeQuery(query2);

                if (rs2.next()) {
                    serie = rs2.getString(1);
                    correlativo = rs2.getInt(2);
                }

                int newCorrelativo = correlativo + 1;
                String query3 = "UPDATE gcfacturador.serie SET correlativo_serie=" + newCorrelativo + " WHERE tipo_comprobante='" + tipoComprobante + "' AND tipo_comprobante_ref = '"+tipoComprobanteRef +"' AND estado='A';";
                st.executeUpdate(query3);
                cn.commit();

                java.util.Date utilDate = new java.util.Date(System.currentTimeMillis());
                java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                java.sql.Timestamp ts = new java.sql.Timestamp(sqlDate.getTime());
                String login_usuario = (String) session.getAttribute("login_usuario");

                //DATOS CLIENTE
                String tipoDocumento = request.getParameter("tipoDocumento");
                String numeroDocumento = request.getParameter("ruc");
                String nombre = request.getParameter("cliente");
                String correo = request.getParameter("correo");
                String direccion = request.getParameter("direccion");

                String fecha_emision = request.getParameter("fecha_emision");

                String flag_negociable = request.getParameter("flag_negociable");
                String fecha_vencimiento = request.getParameter("fecha_vencimiento");
                if (flag_negociable.equals("N")) {
                    fecha_vencimiento = null;
                }

                String moneda = request.getParameter("moneda");

                String formapago = request.getParameter("formapago");

                //LOGICA PARA FORMA DE PAGO
                Double importe_pago = Double.parseDouble(request.getParameter("importe_pago"));
                Double monto_efectivo = Double.parseDouble(request.getParameter("monto_efectivo"));
                Double monto_otro = Double.parseDouble(request.getParameter("monto_otro"));
                String referencia_otro = request.getParameter("referencia_otro");
                Double cambio_pago = Double.parseDouble(request.getParameter("cambio_pago"));
                //FIN LOGICA FORMA DE PAGO

                String estatuspago = request.getParameter("estatuspago");
                Double montopagado = 0.00;

                String tipo_descuentoglobal = request.getParameter("tipo_dctoglobal");
                Double pcto_dctoglobal = Double.parseDouble(request.getParameter("pcto_dctoglobal"));
                Double monto_dctoglobal = Double.parseDouble(request.getParameter("monto_dctoglobal"));

                String flag_gravada = request.getParameter("flag_gravada");
                Double total_gravada = Double.parseDouble(request.getParameter("total_gravada"));
                Double total_inafecta = Double.parseDouble(request.getParameter("total_inafecta"));
                Double total_exonerada = Double.parseDouble(request.getParameter("total_exonerada"));
                Double total_gratuita = Double.parseDouble(request.getParameter("total_gratuita"));
                Double total_impuesto = Double.parseDouble(request.getParameter("total_impuesto"));
                Double total_igv = Double.parseDouble(request.getParameter("total_igv"));
                Double total_isc = Double.parseDouble(request.getParameter("total_isc"));
                Double total_otrotributo = Double.parseDouble(request.getParameter("total_otrotributo"));
                Double total_valorventa = Double.parseDouble(request.getParameter("total_valorventa"));
                Double total_precioventa = Double.parseDouble(request.getParameter("total_precioventa"));
                Double total_descuento = Double.parseDouble(request.getParameter("total_descuento"));
                Double total_otrocargo = request.getParameter("total_otrocargo").equals("") ? 0.00 : Double.parseDouble(request.getParameter("total_otrocargo"));
                Double total_venta = Double.parseDouble(request.getParameter("total_venta"));

                //INICIO LOGICA PARA ANTICIPO
                Double total_anticipo = Double.parseDouble(request.getParameter("total_anticipo"));;
                //FIN LOGICA ANTICIPO 

                //REGISTRAR COMPROBANTE
                query = "INSERT INTO gcfacturador.comprobante (id_comprobante, id_empresa, cli_tipodocumento, cli_numerodocumento, cli_nombre, cli_direccion, cli_correo, tipo_comprobante, serie, correlativo_serie, fecha_emision, flag_negociable, "
                        + "fecha_vencimiento, moneda, tipo_descuentoglobal, monto_descuentoglobal, pcto_descuentoglobal, total_gravada, total_inafecta, "
                        + "total_exonerada, total_gratuita, total_impuesto, total_igv, total_isc, total_otrotributo, total_valorventa, total_precioventa, total_descuento, total_otrocargo, total_anticipo, "
                        + "total_venta, tipo_comprobante_modifica, serie_modifica, correlativo_serie_modifica, tipo_nota, motivo_nota, estado, motivo_anulacion, fecha_insercion, usuario_insercion, terminal_insercion, ip_insercion)"
                        + " VALUES (" + idVenta + ", 1, '" + tipoDocumento + "', '" + numeroDocumento + "', '" + nombre + "', '" + direccion + "', '" + correo + "', '" + tipoComprobante + "', '" + serie + "', " + correlativo + ", '" + fecha_emision + "', '" + flag_negociable + "', "
                        + fecha_vencimiento + ", '" + moneda + "', '" + tipo_descuentoglobal + "', " + monto_dctoglobal + ", " + pcto_dctoglobal + ", " + total_gravada + ", " + total_inafecta + ", "
                        + total_exonerada + ", " + total_gratuita + ", " + total_impuesto + ", " + total_igv + ", " + total_isc + ", " + total_otrotributo + ", " + total_valorventa + ", " + total_precioventa + ", " + total_descuento + ", " + total_otrocargo + ", " + total_anticipo + ", "
                        + total_venta + ", '" + tipoComprobanteRef + "', '" + serieRef + "', " + correlativoRef + ", '" + tipo_nota + "', '" + motivo_nota + "', 'E', null, '" + ts + "', '" + login_usuario + "', '" + request.getRemoteHost() + "', '" + request.getRemoteAddr() + "')";

                sqlEjecucion = query;
                System.out.println("query comprobante: " + query);
                st.executeUpdate(query);
                //FIN REGISTRAR COMPROBANTE

                //INICIO REGISTRAR DETALLE COMPROBANTE
                String detalleVenta = request.getParameter("detalleventa");
                JSONArray arrayDetalleVenta;
                arrayDetalleVenta = new JSONArray(detalleVenta);

                Double cantidad = 0.00, pctoIGV = 0.00, valor_unitario_venta = 0.00, precio_unitario_venta = 0.00, valor_venta = 0.00, precio_venta = 0.00, monto_igv = 0.00, monto_isc = 0.00,
                        descuento = 0.00, monto_descuento = 0.00, pcto_descuento = 0.00, valor_venta_descuento = 0.00, precio_venta_descuento = 0.00, monto_igv_descuento = 0.00;
                String codigo = "", descripcion = "", unidad = "", tipoIGV = "", tipoISC = "", tipo_descuento = "";
                for (int i = 0; i < arrayDetalleVenta.length(); i++) {
                    JSONObject fila1 = null;
                    fila1 = arrayDetalleVenta.getJSONObject(i);

                    codigo = (String) fila1.get("Código");

                    descripcion = (String) fila1.get("Descripción");

                    unidad = (String) fila1.get("Unidad");

                    cantidad = Double.parseDouble((String) fila1.get("Cantidad"));

                    valor_unitario_venta = Double.parseDouble((String) fila1.get("Valor Unitario"));

                    valor_venta = Double.parseDouble((String) fila1.get("Valor Total"));

                    precio_unitario_venta = Double.parseDouble((String) fila1.get("Precio Unitario"));

                    precio_venta = Double.parseDouble((String) fila1.get("Precio Total sDscto"));

                    monto_igv = Double.parseDouble((String) fila1.get("IGV sDscto"));

                    //FALTA TIPO ISC
                    monto_isc = Double.parseDouble((String) fila1.get("ISC"));

                    tipoIGV = (String) fila1.get("Tipo Afectación");

                    if (tipoIGV.trim().equals("G")) {
                        pctoIGV = 18.00;
                    }

                    //DESCUENTO
                    //descuento = Double.parseDouble((String) fila1.get("Descuento"));
                    tipo_descuento = "M";
                    monto_descuento = Double.parseDouble((String) fila1.get("Descuento Mont"));
                    pcto_descuento = Double.parseDouble((String) fila1.get("Descuento Porc"));

                    valor_venta_descuento = Double.parseDouble((String) fila1.get("Valor Total"));

                    monto_igv_descuento = Double.parseDouble((String) fila1.get("IGV"));

                    precio_venta_descuento = Double.parseDouble((String) fila1.get("Precio Total"));

                    //Insertar detalle venta
                    query = "INSERT INTO gcfacturador.detalle_comprobante (id_comprobante, orden, codigo_interno, codigo_sunat, descripcion_producto, unidad_medida, cantidad, moneda, tipo_igv, pcto_igv, valor_unitario_venta, precio_unitario_venta, valor_venta, precio_venta, "
                            + "monto_igv, tipo_isc, monto_isc, flag_bonificacion, tipo_descuento, monto_descuento, pcto_descuento, valor_venta_descuento, precio_venta_descuento, monto_igv_descuento, "
                            + "fecha_insercion, usuario_insercion, terminal_insercion, ip_insercion) "
                            + "VALUES (" + idVenta + ", " + (i + 1) + ", '" + codigo + "', '" + codigo + "', '" + descripcion + "', '" + unidad + "', " + cantidad + ", '" + moneda + "', '" + tipoIGV + "', " + pctoIGV + ", " + valor_unitario_venta + ", " + precio_unitario_venta + ", " + valor_venta + ", " + precio_venta + ", "
                            + monto_igv + ", '" + tipoISC + "', " + monto_isc + ", 'N', '" + tipo_descuento + "', " + monto_descuento + ", " + pcto_descuento + ", " + valor_venta_descuento + ", " + precio_venta_descuento + ", " + monto_igv_descuento + ", '"
                            + ts + "', '" + login_usuario + "', '" + request.getRemoteHost() + "', '" + request.getRemoteAddr() + "')";
                    System.out.println("detalle_comprobante - " + (i + 1) + ": " + query);
                    sqlEjecucion = query;
                    st.executeUpdate(query);
                }
                //FIN REGISTRAR DETALLE COMPROBANTE

                //REGISTRAR DETRACCION SI APLICA
                String flag_detraccion = request.getParameter("flag_detraccion");
                if (flag_detraccion.equals("S")) {
                    Double pcto_detraccion = Double.parseDouble(request.getParameter("pcto_detraccion"));
                    Double monto_detraccion = Double.parseDouble(request.getParameter("monto_detraccion"));
                    Double monto_ref_detraccion = Double.parseDouble(request.getParameter("monto_ref_detraccion"));
                    String descripcion_detraccion = request.getParameter("descripcion_detraccion");

                    //Insertar detraccion
                    query = "INSERT INTO gcfacturador.detraccion (id_comprobante, codigo_detraccion, pcto_detraccion, monto, monto_referencial, descripcion,"
                            + "fecha_insercion, usuario_insercion, terminal_insercion, ip_insercion) "
                            + "VALUES (" + idVenta + ", '037', " + pcto_detraccion + ", " + monto_detraccion + ", " + monto_ref_detraccion + ", '" + descripcion_detraccion + "', "
                            + "'" + ts + "', '" + login_usuario + "', '" + request.getRemoteHost() + "', '" + request.getRemoteAddr() + "')";
                    sqlEjecucion = query;
                    st.executeUpdate(query);
                }

                //REGISTRAR GUIA(S) DE REMISION SI APLICA
                String flag_guia = request.getParameter("flag_guia");
                if (flag_guia.equals("S")) {
                    String detalleGuia = request.getParameter("guia");
                    JSONArray arrayDetalleGuia;
                    arrayDetalleGuia = new JSONArray(detalleGuia);
                    String tipoGuia = "", numeroGuia = "";
                    for (int i = 0; i < arrayDetalleGuia.length(); i++) {
                        JSONObject filaguia = null;
                        filaguia = arrayDetalleGuia.getJSONObject(i);

                        tipoGuia = (String) filaguia.get("Tipo");

                        numeroGuia = (String) filaguia.get("Número");

                        //Insertar guia
                        query = "INSERT INTO gcfacturador.guia (id_comprobante, tipo_guia, numero_guia, fecha_insercion, usuario_insercion, terminal_insercion, ip_insercion) "
                                + "VALUES (" + idVenta + ", '" + tipoGuia + "', '" + numeroGuia + "', '" + ts + "', '" + login_usuario + "', '" + request.getRemoteHost() + "', '" + request.getRemoteAddr() + "')";
                        sqlEjecucion = query;
                        st.executeUpdate(query);
                    }
                }

                json = "{ \"mensaje\":\"<em>SE GENERÓ CORRECTAMENTE LA VENTA</em>\" ";
                json += ",";
                json += " \"idventa\":\"" + idVenta + "\" ";
                cn.commit();

            } catch (SQLException ex) {
                Logger.getLogger(GCFacturador_Comprobante_Servlet.class.getName()).log(Level.SEVERE, null, ex);
                json = "{ \"mensaje\":\"<em>ERROR AL EJECUTAR LA CONSULTA</em>\" ";
                json += ",";
                json += " \"html\":\"<div class='alert alert-danger'><span class='glyphicon glyphicon-remove'></span> " + ex.getMessage().replace("\n", "").concat(". " + sqlEjecucion) + "</div>\" ";
                if (cn != null) {
                    System.out.println("Rollback");
                    try {
                        //deshace todos los cambios realizados en los datos
                        cn.rollback();
                    } catch (SQLException ex1) {
                        //System.err.println( "No se pudo deshacer" + ex1.getMessage() );
                        Logger.getLogger(GCFacturador_Comprobante_Servlet.class.getName()).log(Level.SEVERE, null, ex1);
                    }
                }
            } finally {
                json += "}";
                out.print(json);
                out.close();
                try {
                    cn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(GCFacturador_Comprobante_Servlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                try {
                    if (cn != null) {
                        cn.close();
                    }
                    if (st != null) {
                        st.close();
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(GCFacturador_Comprobante_Servlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } else if (opcion.equals("buscar")) {

        } else if (opcion.equals("anular")) {

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (JSONException ex) {
            Logger.getLogger(GCFacturador_Comprobante_Servlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (JSONException ex) {
            Logger.getLogger(GCFacturador_Comprobante_Servlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
