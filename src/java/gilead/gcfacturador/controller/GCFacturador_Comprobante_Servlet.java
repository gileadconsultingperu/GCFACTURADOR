package gilead.gcfacturador.controller;

import gilead.gcfacturador.dao.impl.DaoComprobanteImpl;
import gilead.gcfacturador.dao.impl.DaoSeguimientoComprobanteImpl;
import gilead.gcfacturador.model.BeanComprobante;
import gilead.gcfacturador.model.BeanSeguimientoComprobante;
import gilead.gcfacturador.sql.ConectaDb;
import gilead.gcfacturador.util.NumeroLetra;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
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
            try (PrintWriter out = response.getWriter()) {
                String accion = request.getParameter("accion");
                String fecha_desde = !request.getParameter("desde").equals("") ? (String) request.getParameter("desde") : "01/01/1990";
                String fecha_hasta = !request.getParameter("hasta").equals("") ? (String) request.getParameter("hasta") : "12/12/9999";
                String numeroComprobante = request.getParameter("nroComp") != null ? (String) request.getParameter("nroComp") : "";
                String tipoComprobante = request.getParameter("tipoComp") != null ? (String) request.getParameter("tipoComp") : "0";
                DaoComprobanteImpl daoComprobanteImpl = new DaoComprobanteImpl();
                List<BeanComprobante> listComprobante = null;

                listComprobante = daoComprobanteImpl.getListar(numeroComprobante, tipoComprobante, fecha_desde, fecha_hasta);

                org.json.simple.JSONArray datos = new org.json.simple.JSONArray();

                DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.DATE_FIELD, Locale.UK);

                for (int i = 0; i < listComprobante.size(); i++) {
                    String acciones = "";

                    acciones = "<div class=\"hidden-sm hidden-xs btn-group\">"
                            + "<button type='button' name='detallarseguimiento' id='" + listComprobante.get(i).getIdcomprobante() + " | " + listComprobante.get(i).getNrocomprobante() + "' class='btn btn-info btn-xs detallarseguimiento' title='Detalle'><span class='fa fa-info-circle'></span></button>"
                            + "</div>";

                    org.json.simple.JSONObject obj = new org.json.simple.JSONObject();
                    obj.put("fecha", listComprobante.get(i).getFechaemision());
                    obj.put("tipocomprobante", listComprobante.get(i).getAbrevtipocomprobante());
                    obj.put("nrocomprobante", listComprobante.get(i).getNrocomprobante());
                    obj.put("nrodocumento", listComprobante.get(i).getCli_numerodocumento());
                    obj.put("cliente", listComprobante.get(i).getCli_denominacion());
                    obj.put("moneda", listComprobante.get(i).getMoneda());
                    obj.put("total", listComprobante.get(i).getTotal());
                    obj.put("estado", listComprobante.get(i).getEstado());
                    obj.put("pdf", (listComprobante.get(i).getLinkpdf() == null ? "" : "<a class='btn btn-info btn-xs' href=\"../Download?opcion=descargar&link=" + listComprobante.get(i).getLinkpdf() + "\" title='Descargar pdf'><span class='fa fa-file-pdf-o'></span></a>"));
                    obj.put("xml", (listComprobante.get(i).getLinkxml() == null ? "" : "<a class='btn btn-info btn-xs' href=\"../Download?opcion=descargar&link=" + listComprobante.get(i).getLinkxml() + "\" title='Descargar xml'><span class='fa fa-file-code-o'></span></a>"));
                    obj.put("cdr", (listComprobante.get(i).getLinkcdr() == null ? "" : "<a class='btn btn-info btn-xs' href=\"../Download?opcion=descargar&link=" + listComprobante.get(i).getLinkcdr() + "\" title='Descargar cdr'><span class='fa fa-file-zip-o'></span></a>"));
                    obj.put("acciones", acciones);
                    datos.add(obj);
                }
                System.out.println(" {\"data\":" + datos.toJSONString() + "} ");
                out.print(" {\"data\":" + datos.toJSONString() + "} ");
            }
        } else if (opcion.equals("obtenerseguimiento")) {
            try (PrintWriter out = response.getWriter()) {
                Integer idcomprobante = Integer.parseInt(request.getParameter("idcomprobante"));
                DaoSeguimientoComprobanteImpl daoSeguimientoComprobanteImpl = new DaoSeguimientoComprobanteImpl();
                List<BeanSeguimientoComprobante> listSeguimientoComprobante = daoSeguimientoComprobanteImpl.getListar(idcomprobante);

                DaoComprobanteImpl daoComprobanteImpl = new DaoComprobanteImpl();
                BeanComprobante beanComprobante = daoComprobanteImpl.get(idcomprobante);

                org.json.simple.JSONArray datos = new org.json.simple.JSONArray();

                for (int i = 0; i < listSeguimientoComprobante.size(); i++) {
                    String acciones = "";

                    if (listSeguimientoComprobante.get(i).getCdr().equals("0")) {
                        acciones = "<div class=\"hidden-sm hidden-xs btn-group\">"
                                + "<button type='button' class='btn btn-success btn-xs' disabled><span>OK</span></button>"
                                + "</div>";
                    } else {
                        acciones = "<div class=\"hidden-sm hidden-xs btn-group\">"
                                + "<button type='button' name='procesar' onclick=\"procesarcomprobante(" + listSeguimientoComprobante.get(i).getIdcomprobante() + ",'" + listSeguimientoComprobante.get(i).getEstado() + "','" + beanComprobante.getUbl() + "');return false;\" class='btn btn-info btn-xs procesar' title='Procesar'><span class='glyphicon glyphicon-cog'></span></button>"
                                + "</div>";
                    }

                    org.json.simple.JSONObject obj = new org.json.simple.JSONObject();
                    obj.put("proceso", listSeguimientoComprobante.get(i).getDescripcionestado());
                    obj.put("cdr", listSeguimientoComprobante.get(i).getCdr());
                    obj.put("nota", listSeguimientoComprobante.get(i).getCdrnota());
                    obj.put("observacion", listSeguimientoComprobante.get(i).getCdrobservacion() == null ? "" : listSeguimientoComprobante.get(i).getCdrobservacion());
                    obj.put("acciones", acciones);
                    datos.add(obj);
                }
                System.out.println(" {\"data\":" + datos.toJSONString() + "} ");
                out.print(" {\"data\":" + datos.toJSONString() + "} ");
            }
        } else if (opcion.equals("registrar")) {
            System.out.println("REGISTRAR COMPROBANTE");
            PrintWriter out = response.getWriter();
            ConectaDb db = new ConectaDb();
            Connection cn = null;
            Statement st = null;
            String sqlEjecucion = null;
            String json = null;
            String linkpdf = null;
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
                String tipoComprobanteRef = "", nrodocumentoref = "", serieRef = "", tipo_nota = "", motivo_nota = "";
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
                    String[] referencia = nrodocumentoref.split("-");
                    serieRef = referencia[0];
                    correlativoRef = Integer.parseInt(referencia[1]);
                }

                //Obtener serie y correlativo actual
                String serie = "";
                int correlativo = 0;
                String query2 = "SELECT serie, correlativo_serie FROM gcfacturador.serie WHERE tipo_comprobante='" + tipoComprobante + "' AND tipo_comprobante_ref = '" + tipoComprobanteRef + "' AND estado='A';";
                ResultSet rs2 = st.executeQuery(query2);

                if (rs2.next()) {
                    serie = rs2.getString(1);
                    correlativo = rs2.getInt(2);
                }

                int newCorrelativo = correlativo + 1;
                String query3 = "UPDATE gcfacturador.serie SET correlativo_serie=" + newCorrelativo + " WHERE tipo_comprobante='" + tipoComprobante + "' AND tipo_comprobante_ref = '" + tipoComprobanteRef + "' AND estado='A';";
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
                        + " VALUES (" + idVenta + ", 1, '" + tipoDocumento + "', '" + numeroDocumento + "', '" + nombre.toUpperCase() + "', '" + direccion.toUpperCase() + "', '" + correo + "', '" + tipoComprobante + "', '" + serie + "', " + correlativo + ", '" + ts + "', '" + flag_negociable + "', "
                        + fecha_vencimiento + ", '" + moneda + "', '" + tipo_descuentoglobal + "', " + monto_dctoglobal + ", " + pcto_dctoglobal + ", " + total_gravada + ", " + total_inafecta + ", "
                        + total_exonerada + ", " + total_gratuita + ", " + total_impuesto + ", " + total_igv + ", " + total_isc + ", " + total_otrotributo + ", " + total_valorventa + ", " + total_precioventa + ", " + total_descuento + ", " + total_otrocargo + ", " + total_anticipo + ", "
                        + total_venta + ", '" + tipoComprobanteRef + "', '" + serieRef + "', " + correlativoRef + ", '" + tipo_nota + "', '" + motivo_nota.toUpperCase() + "', 'E', null, '" + ts + "', '" + login_usuario + "', '" + request.getRemoteHost() + "', '" + request.getRemoteAddr() + "')";

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
                            + "VALUES (" + idVenta + ", " + (i + 1) + ", '" + codigo + "', '" + codigo + "', '" + descripcion.toUpperCase() + "', '" + unidad + "', " + cantidad + ", '" + moneda + "', '" + tipoIGV + "', " + pctoIGV + ", " + valor_unitario_venta + ", " + precio_unitario_venta + ", " + valor_venta + ", " + precio_venta + ", "
                            + monto_igv + ", '" + tipoISC + "', " + monto_isc + ", 'N', '" + tipo_descuento + "', " + monto_descuento + ", " + pcto_descuento + ", " + valor_venta_descuento + ", " + precio_venta_descuento + ", " + monto_igv_descuento + ", '"
                            + ts + "', '" + login_usuario + "', '" + request.getRemoteHost() + "', '" + request.getRemoteAddr() + "')";
                    System.out.println("detalle_comprobante - " + (i + 1) + ": " + query);
                    sqlEjecucion = query;
                    st.executeUpdate(query);
                }
                //FIN REGISTRAR DETALLE COMPROBANTE

                //REGISTRAR DETRACCION SI APLICA
                String flag_detraccion = request.getParameter("flag_detraccion");
                String pctodetraccion = null;
                String montodetraccion = null;
                String cuentabancodetraccion = null;
                if (flag_detraccion.equals("S")) {
                    Double pcto_detraccion = Double.parseDouble(request.getParameter("pcto_detraccion"));
                    pctodetraccion = request.getParameter("pcto_detraccion");
                    Double monto_detraccion = Double.parseDouble(request.getParameter("monto_detraccion"));
                    Double monto_ref_detraccion = Double.parseDouble(request.getParameter("monto_ref_detraccion"));
                    if (monto_ref_detraccion > 0) {
                        montodetraccion = request.getParameter("monto_ref_detraccion");
                    } else {
                        montodetraccion = request.getParameter("monto_detraccion");
                    }
                    cuentabancodetraccion = "00-054-014333";
                    String descripcion_detraccion = request.getParameter("descripcion_detraccion");

                    //Insertar detraccion
                    query = "INSERT INTO gcfacturador.detraccion (id_comprobante, codigo_detraccion, pcto_detraccion, monto, monto_referencial, descripcion,"
                            + "fecha_insercion, usuario_insercion, terminal_insercion, ip_insercion) "
                            + "VALUES (" + idVenta + ", '027', " + pcto_detraccion + ", " + monto_detraccion + ", " + monto_ref_detraccion + ", '" + descripcion_detraccion.toUpperCase() + "', "
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

                //ENVIAR DATOS AL SERVICIO FACTURACION ELECTRONICA
                //Obtener montos en letras
                NumeroLetra NumLetra = new NumeroLetra();
                String numeroenletra = NumLetra.Convertir(request.getParameter("total_venta"), true);

                //Obtener datos de la cabecera
                query = "SELECT e.ruc emp_ruc, e.razon_social emp_denominacion, '6' emp_tipodocumento, e.codigo_ubidistrito emp_ubigeo, "
                        + "e.direccion emp_direccion, de.descripcion emp_departamento, pr.descripcion emp_provincia, di.descripcion emp_distrito, e.codigo_pais emp_codigopais, "
                        + "c.cli_tipodocumento cli_tipodocumento, c.cli_numerodocumento cli_numerodocumento, c.cli_nombre cli_denominacion, c.cli_direccion cli_direccion, "
                        + "c.tipo_comprobante tipocomprobante, c.serie serie, cast(c.correlativo_serie as varchar) correlativo, cast(date(c.fecha_emision) as varchar) fechaemision, to_char(c.fecha_emision, 'HH24:MI:SS') horaemision, c.moneda moneda, "
                        + "cast(c.total_gravada as varchar) totalgravada, cast(c.total_exonerada as varchar) totalexonerada, cast(c.total_igv as varchar) totaligv, cast(c.total_venta as varchar) total, c.usuario_insercion vendedor, "
                        + "c.tipo_comprobante_modifica, c.serie_modifica, c.correlativo_serie_modifica, c.tipo_nota, c.motivo_nota "
                        + "FROM gcfacturador.comprobante c "
                        + "LEFT JOIN gcfacturador.empresa e ON e.id_empresa = c.id_empresa "
                        + "LEFT JOIN gcfacturador.ubidistrito di ON di.codigo_ubidistrito = e.codigo_ubidistrito "
                        + "LEFT JOIN gcfacturador.ubiprovincia pr ON pr.codigo_ubiprovincia = di.codigo_ubiprovincia "
                        + "LEFT JOIN gcfacturador.ubidepartamento de ON de.codigo_ubidepartamento = pr.codigo_ubidepartamento "
                        + "WHERE c.id_comprobante = " + idVenta;

                rs = st.executeQuery(query);

                org.json.simple.JSONObject objetoCabecera = null;
                while (rs.next()) {
                    String enviarsunat = "N";
                    if (rs.getString("tipocomprobante").equals("01")) {
                        enviarsunat = "S";
                    } else if (rs.getString("tipocomprobante").equals("07") || rs.getString("tipocomprobante").equals("08")) {
                        if (rs.getString("tipo_comprobante_modifica").equals("01")) {
                            enviarsunat = "S";
                        }
                    }
                    objetoCabecera = new org.json.simple.JSONObject();
                    objetoCabecera.put("ubl", "2.0");//ubl2.1
                    objetoCabecera.put("emp_ruc", rs.getString("emp_ruc"));
                    objetoCabecera.put("emp_denominacion", rs.getString("emp_denominacion"));
                    objetoCabecera.put("emp_nombrecomercial", "-");//ubl2.1
                    objetoCabecera.put("emp_codigofiscal", "0000");//ubl2.1
                    objetoCabecera.put("emp_tipodocumento", rs.getString("emp_tipodocumento"));
                    objetoCabecera.put("emp_ubigeo", rs.getString("emp_ubigeo"));
                    objetoCabecera.put("emp_direccion", rs.getString("emp_direccion"));
                    objetoCabecera.put("emp_departamento", rs.getString("emp_departamento"));
                    objetoCabecera.put("emp_provincia", rs.getString("emp_provincia"));
                    objetoCabecera.put("emp_distrito", rs.getString("emp_distrito"));
                    objetoCabecera.put("emp_codigopais", rs.getString("emp_codigopais"));
                    objetoCabecera.put("cli_tipodocumento", rs.getString("cli_tipodocumento"));
                    objetoCabecera.put("cli_numerodocumento", rs.getString("cli_numerodocumento"));
                    objetoCabecera.put("cli_denominacion", rs.getString("cli_denominacion"));
                    objetoCabecera.put("cli_direccion", rs.getString("cli_direccion"));
                    if (flag_detraccion.equals("S")) {
                        objetoCabecera.put("tipooperacion", "1004");//ubl2.1
                    } else {
                        objetoCabecera.put("tipooperacion", "0101");//ubl2.1 
                    }
                    objetoCabecera.put("tipocomprobante", rs.getString("tipocomprobante"));
                    objetoCabecera.put("serie", rs.getString("serie"));
                    objetoCabecera.put("correlativo", rs.getString("correlativo"));
                    objetoCabecera.put("fechaemision", rs.getString("fechaemision"));
                    objetoCabecera.put("horaemision", rs.getString("horaemision"));//ubl2.1
                    objetoCabecera.put("fechavencimiento", rs.getString("fechaemision"));//ubl2.1
                    objetoCabecera.put("moneda", rs.getString("moneda"));
                    objetoCabecera.put("descuentoglobal", "0.00");//ubl2.1
                    objetoCabecera.put("porcentajedescuentoglobal", "0.00");//ubl2.1
                    objetoCabecera.put("basedescuentoglobal", "0.00");//ubl2.1
                    objetoCabecera.put("totalgravada", rs.getString("totalgravada"));
                    objetoCabecera.put("totalinafecta", "0.00");
                    objetoCabecera.put("totalexonerada", rs.getString("totalexonerada"));
                    objetoCabecera.put("totalgratuita", "0.00");
                    objetoCabecera.put("totaligvgratuita", "0.00");//ubl2.1
                    objetoCabecera.put("totalimpuesto", rs.getString("totaligv"));//ubl2.1
                    objetoCabecera.put("totaligv", rs.getString("totaligv"));
                    objetoCabecera.put("totalisc", "0.00");
                    objetoCabecera.put("baseisc", "0.00");//ubl2.1
                    objetoCabecera.put("totalotrotributo", "0.00");
                    objetoCabecera.put("baseotrotributo", "0.00");//ubl2.1
                    objetoCabecera.put("totalvalorventa", rs.getString("total"));//ubl2.1
                    objetoCabecera.put("totalprecioventa", rs.getString("total"));//ubl2.1                        
                    objetoCabecera.put("totaldescuento", "0.00");
                    objetoCabecera.put("totalotrocargo", "0.00");
                    objetoCabecera.put("totalanticipo", "0.00");//ubl2.1
                    objetoCabecera.put("total", rs.getString("total"));
                    if (flag_detraccion.equals("S")) {
                        objetoCabecera.put("totaldetraccion", montodetraccion);//ubl2.1
                        objetoCabecera.put("porcentajedetraccion", pctodetraccion);//ubl2.1
                        objetoCabecera.put("codigoproductodetraccion", "027");//ubl2.1
                        objetoCabecera.put("cuentabanco", cuentabancodetraccion);//ubl2.1   
                    } else {
                        objetoCabecera.put("totaldetraccion", "0.00");//ubl2.1
                        objetoCabecera.put("porcentajedetraccion", "0.00");//ubl2.1
                        objetoCabecera.put("codigoproductodetraccion", "-");//ubl2.1
                        objetoCabecera.put("cuentabanco", "-");//ubl2.1
                    }
                    objetoCabecera.put("totalpercepcion", "0.00");
                    objetoCabecera.put("basepercepcion", "0.00");
                    objetoCabecera.put("totalincluidopercepcion", "0.00");
                    objetoCabecera.put("tipoproceso", "1");
                    objetoCabecera.put("enviosunat", enviarsunat);
                    objetoCabecera.put("enviocliente", "N");
                    if (rs.getString("tipocomprobante").equals("07") || rs.getString("tipocomprobante").equals("08")) {
                        objetoCabecera.put("notatipocomprobante", rs.getString("tipo_comprobante_modifica"));
                        objetoCabecera.put("notaserie", rs.getString("serie_modifica"));
                        objetoCabecera.put("notacorrelativo", rs.getString("correlativo_serie_modifica"));
                        objetoCabecera.put("notamotivo", rs.getString("tipo_nota"));
                        objetoCabecera.put("notasustento", rs.getString("motivo_nota"));
                    } else {
                        objetoCabecera.put("notatipocomprobante", "");
                        objetoCabecera.put("notaserie", "");
                        objetoCabecera.put("notacorrelativo", "");
                        objetoCabecera.put("notamotivo", "");
                        objetoCabecera.put("notasustento", "");
                    }

                    objetoCabecera.put("vendedor", rs.getString("vendedor"));
                }
                //Fin obtener datos de la cabecera

                //Obtener datos del detalle
                query = "select dc.codigo_interno itemcodigo, dc.descripcion_producto itemdescripcion, dc.unidad_medida itemunidadmedida, cast(dc.cantidad as varchar) itemcantidad, cast(dc.valor_venta_descuento as varchar) itemvalorventa, "
                        + "cast(dc.valor_unitario_venta as varchar) itemvalorventaunitario, cast(dc.precio_venta_descuento as varchar) itemprecioventa, cast(dc.precio_unitario_venta as varchar) itemprecioventaunitario, "
                        + "cast(dc.monto_igv_descuento as varchar) itemigv, case when dc.tipo_igv = 'G' then '10' when dc.tipo_igv = 'E' then '20' when dc.tipo_igv = 'I' then '30' end itemafectacionigv, cast(dc.pcto_igv as varchar) itempctoigv "
                        + "from gcfacturador.detalle_comprobante dc "
                        + "where dc.id_comprobante = " + idVenta;

                rs = st.executeQuery(query);

                org.json.simple.JSONArray lista = new org.json.simple.JSONArray();
                org.json.simple.JSONObject detalle_linea = null;
                while (rs.next()) {
                    detalle_linea = new org.json.simple.JSONObject();

                    detalle_linea.put("itemcodigo", rs.getString("itemcodigo"));
                    detalle_linea.put("itemcodigosunat", "-");//2.1
                    detalle_linea.put("itemdescripcion", rs.getString("itemdescripcion"));
                    detalle_linea.put("itemunidadmedida", rs.getString("itemunidadmedida"));
                    detalle_linea.put("itemcantidad", rs.getString("itemcantidad"));
                    detalle_linea.put("itemmoneda", moneda);
                    detalle_linea.put("itemvalorventa", rs.getString("itemvalorventa"));
                    detalle_linea.put("itemvalorventaunitario", rs.getString("itemvalorventaunitario"));
                    detalle_linea.put("itemvalornoonerosaunitario", "0.00");
                    detalle_linea.put("itemprecioventa", rs.getString("itemprecioventa"));
                    detalle_linea.put("itemprecioventaunitario", rs.getString("itemprecioventaunitario"));
                    detalle_linea.put("itemdescuento", "0.00");//2.1
                    detalle_linea.put("itemporcentajedescuento", "0.00");//2.1
                    detalle_linea.put("itembasedescuento", "0.00");//2.1
                    detalle_linea.put("itemcargo", "0.00");//2.1
                    detalle_linea.put("itemporcentajecargo", "0.00");//2.1
                    detalle_linea.put("itembasecargo", "0.00");//2.1
                    detalle_linea.put("itemtotalimpuesto", rs.getString("itemigv"));//2.1                       
                    detalle_linea.put("itemigv", rs.getString("itemigv"));
                    if (rs.getString("itemafectacionigv").equals("10")) {
                        detalle_linea.put("itembaseigv", rs.getString("itemvalorventa"));//2.1
                        detalle_linea.put("itemporcentajeigv", "18.00");//2.1
                    } else {
                        detalle_linea.put("itembaseigv", "0.00");//2.1  
                        detalle_linea.put("itemporcentajeigv", "0.00");//2.1
                    }
                    detalle_linea.put("itemafectacionigv", rs.getString("itemafectacionigv"));
                    detalle_linea.put("itemisc", "0.00");
                    detalle_linea.put("itembaseisc", "0.00");
                    detalle_linea.put("itemporcentajeisc", "0.00");
                    detalle_linea.put("itemisctipo", "");

                    lista.add(detalle_linea);
                }
                objetoCabecera.put("comprobantedetalles", lista);
                //Fin obtener datos del detalle

                //Obtener guias
                query = "select numero_guia numeroguia, tipo_guia tipoguia from gcfacturador.guia "
                        + "where id_comprobante = " + idVenta;

                rs = st.executeQuery(query);

                org.json.simple.JSONArray guia = new org.json.simple.JSONArray();
                org.json.simple.JSONObject detalle_guia = null;
                while (rs.next()) {
                    detalle_guia = new org.json.simple.JSONObject();

                    detalle_guia.put("guiaserienumero", rs.getString("numeroguia"));
                    detalle_guia.put("guiatipo", rs.getString("tipoguia"));

                    guia.add(detalle_guia);
                }
                objetoCabecera.put("guias", guia);
                //Fin obtener guias

                //Obtener leyendas
                org.json.simple.JSONArray lista_leyenda = new org.json.simple.JSONArray();
                org.json.simple.JSONObject leyenda_linea_1 = new org.json.simple.JSONObject();

                leyenda_linea_1.put("leyendacodigo", "1000");
                leyenda_linea_1.put("leyendadescripcion", numeroenletra);

                lista_leyenda.add(leyenda_linea_1);

                if (flag_detraccion.equals("S")) {
                    org.json.simple.JSONObject leyenda_linea_2 = new org.json.simple.JSONObject();

                    leyenda_linea_2.put("leyendacodigo", "2006");
                    leyenda_linea_2.put("leyendadescripcion", "OPERACIÓN SUJETA A DETRACCIÓN");

                    lista_leyenda.add(leyenda_linea_2);
                }

                objetoCabecera.put("leyendas", lista_leyenda);

                //FIN CONSTRUIR OBJETO JSON PARA ENVIAR AL SERVICIO
                //
                try {
                    DefaultHttpClient httpClient = new DefaultHttpClient();
                    HttpPost postRequest = new HttpPost(
                            "http://localhost:8084/WebServiceSunat21/rest/comprobante/procesarComprobante");

                    StringEntity input = new StringEntity(objetoCabecera.toString(), "utf-8");

                    input.setContentType("application/json");
                    postRequest.setEntity(input);

                    HttpResponse httpResponse = httpClient.execute(postRequest);

                    if (httpResponse.getStatusLine().getStatusCode() != 200) {
                        throw new RuntimeException("Failed : HTTP error code : "
                                + httpResponse.getStatusLine().getStatusCode());
                    }

                    BufferedReader br = new BufferedReader(new InputStreamReader(
                            (httpResponse.getEntity().getContent())));

                    String output;
                    String[] aux = null;
                    System.out.println("Output from Server .... \n");
                    while ((output = br.readLine()) != null) {
                        aux = output.split("\\|", 0);
                    }

                    linkpdf = aux[6];
                    System.out.println("linkpdf: " + linkpdf);
                    httpClient.getConnectionManager().shutdown();

                } catch (MalformedURLException e) {

                    e.printStackTrace();
                } catch (IOException e) {

                    e.printStackTrace();

                }

                json = "{ \"mensaje\":\"<em>SE GENERÓ CORRECTAMENTE LA VENTA</em>\" ";
                json += ",";
                json += " \"idventa\":\"" + idVenta + "\" ";
                json += ",";
                json += " \"linkpdf\":\"" + linkpdf + "\"";
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
        } else if (opcion.equals("procesarcomprobante")) {
            String idcomprobante = request.getParameter("idcomprobante");
            String estado = request.getParameter("estado");
            String ubl = request.getParameter("ubl");

            //API REST
            try {
                DefaultHttpClient httpClient = new DefaultHttpClient();
                HttpPost postRequest = new HttpPost(
                        "http://localhost:8084/WebServiceSunat21/rest/comprobante/reprocesarComprobante");

                StringEntity input = new StringEntity(idcomprobante + "|" + estado + "|" + ubl, "utf-8");

                input.setContentType("application/json");
                postRequest.setEntity(input);

                HttpResponse responseREST;
                responseREST = httpClient.execute(postRequest);

                if (responseREST.getStatusLine().getStatusCode() != 200) {
                    throw new RuntimeException("Failed : HTTP error code : "
                            + responseREST.getStatusLine().getStatusCode());
                }

                BufferedReader br = new BufferedReader(new InputStreamReader(
                        (responseREST.getEntity().getContent())));

                String output;
                String[] aux = null;
                System.out.println("Output from Server .... \n");
                while ((output = br.readLine()) != null) {
                    //aux = output.split("\\|", 0);
                    System.out.println(output);
                }

                httpClient.getConnectionManager().shutdown();

            } catch (MalformedURLException e) {
                e.printStackTrace();
                System.out.println("MalformedURLException: " + e.getMessage());
            } catch (IOException e) {
                e.printStackTrace();
                System.out.println("IOException: " + e.getMessage());
            }

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
