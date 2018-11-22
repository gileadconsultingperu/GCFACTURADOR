<%--
    Compañia            : Gilead Consulting S.A.C.
    Sistema             : GC-Facturador
    Módulo              : Facturador
    Nombre              : GC-Facturador-RegistrarComprobante.jsp
    Versión             : 1.0
    Fecha Creación      : 14-11-2018
    Autor Creación      : Pablo Jimenez Aguado
    Uso                 : Registrar Factura, Boleta, NC y ND
--%>
<%@page import="gilead.gcfacturador.model.BeanUbigeo"%>
<%@page import="gilead.gcfacturador.dao.impl.DaoUbigeoImpl"%>
<%@page import="gilead.gcfacturador.model.BeanSerie"%>
<%@page import="gilead.gcfacturador.dao.impl.DaoSerieImpl"%>
<%@page import="java.util.List"%>
<%@page import="gilead.gcfacturador.model.BeanUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    BeanUsuario usuario = (BeanUsuario) session.getAttribute("usuario");
%>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta charset="utf-8" />
        <title>GC FACTURADOR - Registrar Comprobante</title>

        <meta name="description" content="Common form elements and layouts" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

        <!-- bootstrap & fontawesome -->
        <link rel="stylesheet" href="../assets/css/bootstrap.min.css" />
        <link rel="stylesheet" href="../assets/font-awesome/4.5.0/css/font-awesome.min.css" />

        <!-- page specific plugin styles -->
        <link rel="stylesheet" href="../assets/css/jquery-ui.custom.min.css" />
        <link rel="stylesheet" href="../assets/css/chosen.min.css" />
        <link rel="stylesheet" href="../assets/css/bootstrap-datepicker3.min.css" />
        <link rel="stylesheet" href="../assets/css/bootstrap-timepicker.min.css" />
        <link rel="stylesheet" href="../assets/css/daterangepicker.min.css" />
        <link rel="stylesheet" href="../assets/css/bootstrap-datetimepicker.min.css" />
        <link rel="stylesheet" href="../assets/css/bootstrap-colorpicker.min.css" />
        <link rel="stylesheet" href="../assets/css/ui.jqgrid.min.css" />

        <!-- text fonts -->
        <link rel="stylesheet" href="../assets/css/fonts.googleapis.com.css" />

        <!-- ace styles -->
        <link rel="stylesheet" href="../assets/css/ace.min.css" class="ace-main-stylesheet" id="main-ace-style" />

        <!--[if lte IE 9]>
                <link rel="stylesheet" href="../assets/css/ace-part2.min.css" class="ace-main-stylesheet" />
        <![endif]-->

        <!-- Alertify Version Nueva-->
        <link rel="stylesheet" href="../assets/css/alertify/alertify.css">

        <link rel="stylesheet" href="../assets/css/ace-skins.min.css" />
        <link rel="stylesheet" href="../assets/css/ace-rtl.min.css" />

        <!-- page specific plugin styles -->
        <link rel="stylesheet" href="../assets/css/jquery-ui.min.css" />

        <!--[if lte IE 9]>
          <link rel="stylesheet" href="../assets/css/ace-ie.min.css" />
        <![endif]-->

        <!-- inline styles related to this page -->

        <!-- ace settings handler -->
        <script src="../assets/js/ace-extra.min.js"></script>

        <!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

        <!--[if lte IE 8]>
        <script src="../assets/js/html5shiv.min.js"></script>
        <script src="../assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- Alertas Version Nueva -->
        <script src="../assets/js/alertify/alertify.js"></script>

    </head>
    <body class="no-skin">
        <%
            if (usuario != null) {
        %>
        <div id="navbar" class="navbar navbar-default ace-save-state">
            <div class="navbar-container ace-save-state" id="navbar-container">
                <button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
                    <span class="sr-only">Toggle sidebar</span>

                    <span class="icon-bar"></span>

                    <span class="icon-bar"></span>

                    <span class="icon-bar"></span>
                </button>

                <div class="navbar-header pull-left">
                    <a href="#" class="navbar-brand">
                        <small>
                            <%--<i class="fa fa-leaf"></i>--%>
                            GC FACTURADOR - Software de Facturador Electrónico
                        </small>
                    </a>
                </div>

                <div class="navbar-buttons navbar-header pull-right" role="navigation">
                    <ul class="nav ace-nav">

                        <li class="light-blue dropdown-modal">
                            <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                                <img class="nav-user-photo" src="../assets/images/avatars/avatar2.png" alt="Jason's Photo" />
                                <span class="user-info">
                                    <small>Bienvenido,</small>
                                    <%= usuario.getUsuario()%>
                                </span>

                                <i class="ace-icon fa fa-caret-down"></i>
                            </a>

                            <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
                                <li>
                                    <a href="GCPortal_Perfil.jsp">
                                        <i class="ace-icon fa fa-info-circle"></i>
                                        Perfil
                                    </a>
                                </li>

                                <li class="divider"></li>

                                <li>
                                    <a href="../Logout">
                                        <i class="ace-icon fa fa-power-off"></i>
                                        Cerrar Sesión
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div><!-- /.navbar-container -->
        </div>

        <div class="main-container ace-save-state" id="main-container">
            <script type="text/javascript">
                try {
                    ace.settings.loadState('main-container');
                } catch (e) {
                }
            </script>

            <div id="sidebar" class="sidebar                  responsive                    ace-save-state">
                <script type="text/javascript">
                    try {
                        ace.settings.loadState('sidebar');
                    } catch (e) {
                    }
                </script>

                <ul class="nav nav-list">
                    <li class="open">
                        <a href="#" class="dropdown-toggle">
                            <i class="menu-icon fa fa-list"></i>
                            <span class="menu-text">Comprobantes </span>

                            <b class="arrow fa fa-angle-down"></b>
                        </a>

                        <b class="arrow"></b>

                        <ul class="submenu">
                            <li class="">
                                <a href="GC-Facturador-RegistrarComprobante.jsp">
                                    <i class="menu-icon fa fa-caret-right"></i>
                                    Registrar Comprobante
                                </a>

                                <b class="arrow"></b>
                            </li>
                            <li class="">
                                <a href="GC-Facturador-ListarComprobantes.jsp">
                                    <i class="menu-icon fa fa-caret-right"></i>
                                    Listar Comprobantes
                                </a>

                                <b class="arrow"></b>
                            </li>
                            <li class="">
                                <a href="#">
                                    <i class="menu-icon fa fa-caret-right"></i>
                                    Anulaciones
                                </a>

                                <b class="arrow"></b>
                            </li>
                            <li class="">
                                <a href="#">
                                    <i class="menu-icon fa fa-caret-right"></i>
                                    Listar Comunicaciones de Baja
                                </a>

                                <b class="arrow"></b>
                            </li>
                            <li class="">
                                <a href="#">
                                    <i class="menu-icon fa fa-caret-right"></i>
                                    Proceso Resumen Diario
                                </a>

                                <b class="arrow"></b>
                            </li>
                            <li class="">
                                <a href="#">
                                    <i class="menu-icon fa fa-caret-right"></i>
                                    Listar Resumenes Diarios
                                </a>

                                <b class="arrow"></b>
                            </li>
                        </ul>
                    </li>            
                </ul><!-- /.nav-list -->

                <div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
                    <i id="sidebar-toggle-icon" class="ace-icon fa fa-angle-double-left ace-save-state" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
                </div>
            </div>

            <div class="main-content">
                <div class="main-content-inner">
                    <div class="breadcrumbs ace-save-state" id="breadcrumbs">
                        <ul class="breadcrumb">
                            <li>
                                <i class="ace-icon fa fa-home home-icon"></i>
                                <a href="#">Inicio</a>
                            </li>
                        </ul><!-- /.breadcrumb -->

                    </div>

                    <div class="page-content">

                        <div class="page-header">
                            <h1>
                                Registrar Comprobante 
                            </h1>
                        </div><!-- /.page-header -->

                        <!-- PAGE CONTENT BEGINS -->
                        <div class="row datos_comprobante">
                            <div class="col-xs-12">
                                <input type="hidden" id="flag_detraccion" value="N">
                                <div class="panel panel-primary">
                                    <div class="panel-heading" style="font-size: 12px;"> Datos Comprobante </div>
                                    <div class="panel-body">
                                        <div class="row col-md-12">
                                            <div class="form-group">
                                                <label for="tipocomprobante" class="control-label" style="width: 35px; font-size: 10px;">Tipo:</label>
                                                <select id="tipocomprobante" name="tipocomprobante" class="styled-select tipo_comprobante" style="width: 140px; font-size: 10px;" tabindex="1" >
                                                    <option value="01" selected>FACTURA</option>
                                                    <option value="03">BOLETA DE VENTA</option>
                                                    <option value="07">NOTA DE CRÉDITO</option>
                                                    <option value="08">NOTA DE DÉBITO</option>
                                                </select>
                                                &nbsp;&nbsp;&nbsp;
                                                <label for="nrodocumento" class="control-label" style="width: 60px; font-size: 10px;">Número:</label>                                               
                                                <input type="text" name="nrodocumento" id="nrodocumento" tabindex="-1" style="width: 150px; font-size: 10px;" class="styled-select tipo_comprobante" disabled>
                                                &nbsp;&nbsp;&nbsp;
                                                <label for="moneda" class="control-label" style="width: 60px; font-size: 10px;">Moneda:</label>
                                                <select id="moneda" name="moneda" class="styled-select tipo_comprobante" style="width: 120px; font-size: 10px;" tabindex="2" >
                                                    <option value="PEN" selected>PEN-Sol</option>
                                                    <option value="USD">USD-US Dolar</option>
                                                    <option value="EUR">EUR-Euro</option>
                                                </select>
                                                &nbsp;&nbsp;&nbsp;
                                                <label for="negociable" class="control-label hidden" style="width: 75px; font-size: 10px;">Negociable:</label>
                                                &nbsp;
                                                <input id="switch-negociable" class="ace ace-switch hidden" type="checkbox" />
                                                <span class="lbl hidden" data-lbl="SI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NO" tabindex="-1" ></span>
                                                &nbsp;
                                                <label id="lblfechavencimiento" class="control-label hide" style="width: 130px; font-size: 10px;">Fecha Vencimiento:</label>
                                                <input type="text" id="fechavencimiento" style="width: 120px;" class="hide" tabindex="-1" readonly>
                                                <i id="iconfechavencimiento" class="ace-icon fa fa-calendar hide" style="width: 10px; font-size: 10px;"></i>
                                                &nbsp;
                                                <label id="lblfechaemision" class="control-label" style="width: 100px; font-size: 10px;">Fecha Emisión:</label>
                                                <input type="text" id="fechaemision" style="width: 120px; font-size: 10px;" tabindex="3" readonly>
                                                <i id="iconfechaemision" class="ace-icon fa fa-calendar" style="width: 10px; font-size: 10px;"></i>
                                            </div>                                      
                                            <div class="form-group hide">
                                                <label for="operaciongratuita" class="control-label" style="width: 95px; font-size: 10px;">Operación Gratuita:</label>
                                                <input id="switch-operaciongratuita" type="checkbox" value="N"/>
                                                <label class="lblOperacionGratuita" style="font-size: 10px;">No</label>
                                            </div> 
                                            <div id="divdetraccion" class="form-group">
                                                <label for="detraccion" class="control-label" style="width: 55px; font-size: 10px;">Detracción:</label>  
                                                <input id="switch-detraccion" type="checkbox" value="N"/>
                                                &nbsp;&nbsp;
                                                <label for="cbporcentajedetraccion" id="lblporcentajedetraccion" class="control-label hide" style="width: 65px; font-size: 10px;">% Detracción:</label>
                                                <select id="cbporcentajedetraccion" name="cbporcentajedetraccion" class="styled-select hide" style="width: 48px; font-size: 10px;" tabindex="4">
                                                    <option value="1.5">1.5</option>
                                                    <option value="4" selected>4</option>                                                    
                                                    <option value="10">10</option>
                                                    <option value="12">12</option>
                                                    <option value="15">15</option>
                                                </select>
                                                &nbsp;
                                                <label for="inputtipocambio" id="lbltipocambio" class="control-label hide" style="width: 60px; font-size: 10px;">Tipo Cambio:</label>
                                                <input type="text" name="inputtipocambio" id="inputtipocambio" value="0.000" tabindex="5" style="width: 50px; font-size: 10px;" class="styled-select hide">
                                                &nbsp;&nbsp; 
                                                <label for="inputmontodetraccion" id="lblmontodetraccion" class="control-label hide" style="width: 87px; font-size: 10px;">Monto Detracción:</label>
                                                <input type="text" name="inputmontodetraccion" id="inputmontodetraccion" value="0.00" tabindex="5" style="width: 55px; font-size: 10px;" class="styled-select hide" disabled>
                                                &nbsp;&nbsp;
                                                <label for="inputmontodetraccionreferencial" id="lblmontodetraccionreferencial" class="control-label hide" style="width: 90px; font-size: 10px;">Monto Detracción Referencial:</label>
                                                <input type="text" name="inputmontodetraccionreferencial" id="inputmontodetraccionreferencial" value="0.00" tabindex="5" style="width: 50px; font-size: 10px;" class="styled-select hide">
                                            </div>
                                            <div id="divdetraccion" class="form-group">
                                                <label for="inputdescripciondetraccion" id="lbldescripciondetraccion" class="control-label hide" style="width: 68px; font-size: 10px;">Descripción:</label>
                                                <input type="text" name="inputdescripciondetraccion" id="inputdescripciondetraccion" tabindex="6" style="width: 520px; font-size: 10px;" class="styled-select hide" value="OPERACIÓN SUJETA AL SPOT CON EL GOBIERNO CENTRAL CTA. CTE. N° 00-054-014333">  
                                            </div>
                                            <div id="divguia" class="form-group">
                                                <input type="hidden" id="rowdetalleguia" value="0">
                                                <input type="hidden" id="flagGuia" value="N">
                                                <div class="row col-md-8">                                                                                                  
                                                    <button class="btn btn-sm btn-primary" style="font-size: 12px;" id="btnAgregarGuia" tabindex="30" title="Agregar Guía">
                                                        <i class="ace-icon fa fa-plus"></i>Agregar Guía
                                                    </button>
                                                    <table id="detalleGuia" class="table table-striped table-bordered table-hover hide" sortable="1" style="font-size:10px">
                                                        <thead>
                                                            <tr>
                                                                <th style="display: none">Item</th>
                                                                <th style="width:120px">Tipo</th>
                                                                <th style="width:100px">Número</th>
                                                                <th style="width:50px">Acciones</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="detalleGuia_data">
                                                        </tbody>
                                                    </table>                                                
                                                </div>

                                            </div>
                                            <div class="form-group hidden">
                                                <label for="formapago" class="control-label" style="width: 110px;">Forma de Pago:</label>
                                                <select id="formapago" name="formapago" class="styled-select tipo_comprobante" style="width: 160px;" tabindex="6">
                                                    <option value="E" selected>EFECTIVO</option>
                                                    <option value="T">TARJETA</option>
                                                    <option value="C">CHEQUE</option>
                                                    <option value="L">LETRA DE CAMBIO</option>
                                                    <option value="D">DEPÓSITO EN CUENTA</option>
                                                    <option value="O">OTROS</option>
                                                </select>
                                                &nbsp;
                                                <label id="lblnumeroletra" class="control-label hide" style="width: 100px;">Número Letra:</label>
                                                <input type="text" name="numeroletra" id="numeroletra" tabindex="-1" style="width: 100px;" class="styled-select tipo_comprobante hide">
                                                &nbsp;
                                                <label id="lblmontoletra" class="control-label hide" style="width: 100px;">Monto Letra:</label>
                                                <input type="text" name="montoletra" id="montoletra" tabindex="-1" style="width: 100px;" placeholder="0.00" class="styled-select tipo_comprobante hide">
                                                &nbsp;
                                                <label id="lblfechavencimientoletra" class="control-label hide" style="width: 130px;">Fecha Vencimiento:</label>
                                                <input type="text" id="fechavencimientoletra" style="width: 120px;" class="hide" tabindex="-1" readonly>
                                                <i id="iconfechavencimientoletra" class="ace-icon fa fa-calendar hide" style="width: 10px;"></i>
                                            </div>
                                            <div class="form-group hidden">
                                                <label for="estadopago" class="control-label" style="width: 110px;">Estatus Pago:</label>
                                                <select id="estadopago" name="estadopago" class="styled-select tipo_comprobante" style="width: 160px;" tabindex="-1">
                                                    <option value="S">SIN PAGAR</option>
                                                    <option value="P">PAGADO PARCIALMENTE</option>
                                                    <option value="T" selected="selected">PAGADO TOTALMENTE</option>
                                                </select>
                                                &nbsp;
                                                <label id="lblmontopagado" class="control-label hide" style="width: 100px;">Monto Pagado:</label>
                                                <input type="text" name="montopagado" id="montopagado" tabindex="-1" style="width: 100px;" placeholder="0.00" class="styled-select tipo_comprobante hide">
                                            </div>
                                            <div class="form-group hidden">
                                                <label for="facturagravada" class="control-label" style="width: 115px;">Factura Gravada:</label>
                                                <input id="switch-gravada" class="ace ace-switch" type="checkbox" />
                                                <span class="lbl" data-lbl="SI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NO" tabindex="-1" ></span>
                                            </div>
                                            <div class="form-group hidden">
                                                <label for="anticipo" class="control-label" style="width: 60px;">Anticipo:</label>
                                                <input id="switch-anticipo" class="ace ace-switch" type="checkbox" />
                                                <span class="lbl" data-lbl="SI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NO" tabindex="-1" ></span>
                                            </div>
                                        </div>
                                    </div>
                                </div><!-- /.col -->
                            </div>
                        </div><!-- /.row -->
                        <div id="documentoReferencia" class="row datos_comprobante_ref hide">
                            <div class="col-xs-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading" style="font-size: 12px;"> Datos Comprobante Referencia</div>
                                    <div class="panel-body">
                                        <div class="row col-md-12">
                                            <div class="form-group">
                                                <label for="tipocomprobanteref" class="control-label" style="width: 25px; font-size: 10px;">Tipo:</label>
                                                <select id="tipocomprobanteref" name="tipocomprobanteref" class="styled-select tipo_comprobante_ref" style="width: 115px; font-size: 10px;" tabindex="100">
                                                    <option value="01" selected>FACTURA</option>
                                                    <option value="03">BOLETA DE VENTA</option>
                                                </select>
                                                &nbsp;&nbsp;&nbsp;
                                                <label for="nrodocumentoref" class="control-label" style="width: 48px; font-size: 10px;">Número:</label>                                               
                                                <input type="text" name="nrodocumentoref" id="nrodocumentoref" tabindex="101" style="width: 100px; font-size: 10px;" class="styled-select tipo_comprobante_ref">
                                                &nbsp;&nbsp;&nbsp;
                                                <label id="lbltiponotacredito" class="control-label" style="width: 60px; font-size: 10px;">Tipo Nota Crédito:</label>
                                                <select id="tiponotacredito" name="tiponotacredito" class="styled-select tipo_comprobante_ref" style="width: 170px; font-size: 10px;" tabindex="102" >
                                                    <option value="01" selected>Anulación de la operación</option>
                                                    <option value="02">Anulación por error en el RUC</option>
                                                    <option value="03">Corrección por error en la descripción</option>
                                                    <option value="04">Descuento global</option>
                                                    <option value="05">Descuento por Item</option>
                                                    <option value="06">Devolución total</option>
                                                    <option value="07">Devolución parcial</option>
                                                    <option value="08">Bonificación</option>
                                                    <option value="09">Disminución en el valor</option>
                                                </select>
                                                <label id="lbltiponotadebito" class="control-label hide" style="width: 60px; font-size: 10px;">Tipo Nota Débito:</label>
                                                <select id="tiponotadebito" name="tiponotadebito" class="styled-select tipo_comprobante_ref hide" style="width: 125px; font-size: 10px;" tabindex="102" >
                                                    <option value="01" selected>Intereses por mora</option>
                                                    <option value="02">Aumento en el valor</option>
                                                    <option value="03">Penalidades</option>
                                                </select>
                                                &nbsp;&nbsp;&nbsp;
                                                <label for="motivonota" class="control-label" style="width: 45px; font-size: 10px;">Motivo:</label>
                                                <textarea rows='3' name="motivonota" id="motivonota" tabindex="103" style="resize:none; width: 350px; font-size: 10px; vertical-align: top; text-transform:uppercase" class="styled-select"></textarea>
                                            </div>
                                            <div class="form-group">

                                            </div>
                                        </div>
                                    </div>
                                </div><!-- /.col -->
                            </div>
                        </div><!-- /.row -->
                        <div class="row datos_cliente">
                            <div class="col-xs-12">
                                <input type="hidden" id="ubigeocliente" value="">
                                <div class="panel panel-primary">
                                    <div class="panel-heading" style="font-size: 12px;"> Datos Cliente </div>
                                    <div class="panel-body">
                                        <div class="row col-md-12">                                           
                                            <div class="form-group">
                                                <label id="lblruc" for="ruc" class="control-label" style="width: 80px; font-size: 10px;">RUC:</label>
                                                <select id="tipodocumento" name="tipodocumento" class="styled-select hide" style="width: 80px; font-size: 10px;" tabindex="4" >
                                                    <option value="1" selected>DNI</option>
                                                    <option value="6">RUC</option>
                                                </select>
                                                <input type="text" name="ruc" id="ruc" tabindex="7" style="width: 433px; font-size: 10px;">
                                                &nbsp;
                                                <button type="button" class="btn btn-xs btn-primary" id="buscarsunat">Buscar SUNAT</button>
                                                &nbsp;&nbsp;
                                                <label id="lbldepartamento" class="control-label hide" style="width: 110px; font-size: 10px;">Departamento:</label>
                                                <select id="departamento" name="departamento" class="hide"  style="width: 220px; font-size: 10px;" tabindex="15">
                                                    <%--
                                                    <%
                                                        DaoUbigeoImpl daoUbigeo = new DaoUbigeoImpl();
                                                        List<BeanUbigeo> departamento = daoUbigeo.accionListarDepartamentos();

                                                        for (int i = 0; i < departamento.size(); i++) {
                                                    %>
                                                    <option value="<%= departamento.get(i).getCodigo_ubidepartamento()%>">
                                                        <%= departamento.get(i).getDescripcionUbigeo()%>
                                                    </option>
                                                    <%

                                                        }
                                                    %>
                                                    --%> 
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label id="lblrazonsocial" for="cliente" class="control-label" style="width: 80px; font-size: 10px;">Razón Social:</label>
                                                <label id="lblnombre" for="cliente" class="control-label hide" style="width: 80px; font-size: 10px;">Nombre:</label>
                                                <input type="text" name="cliente" id="cliente" tabindex="8" style="width: 540px; font-size: 10px;" value="-">
                                                &nbsp;&nbsp;
                                                <label id="lblprovincia" class="control-label hide" style="width: 110px; font-size: 10px;">Provincia:</label>
                                                <select id="provincia" name="provincia" class="hide"  style="width: 220px; font-size: 10px;" tabindex="16">
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="direccion" class="control-label" style="width: 80px; font-size: 10px;">Dirección:</label>
                                                <input type="text" name="direccion" id="direccion" tabindex="9" style="width: 540px; font-size: 10px;" value="-">
                                                &nbsp;&nbsp;
                                                <label id="lbldistrito" class="control-label hide" style="width: 110px; font-size: 10px;">Distrito:</label>
                                                <select id="distrito" name="distrito" class="hide" style="width: 220px; font-size: 10px;" tabindex="17">
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="correo" class="control-label" style="width: 80px; font-size: 10px;">Correo:</label>
                                                <input type="text" name="correo" id="correo" tabindex="10" style="width: 540px; font-size: 10px;" value="-">
                                            </div>   
                                        </div>
                                    </div>
                                </div><!-- /.col -->
                            </div>
                        </div><!-- /.row -->
                        <div class="row datos_item">
                            <div class="col-xs-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading" style="font-size: 12px;"> Listado de Items </div>
                                    <div class="panel-body">
                                        <input type="hidden" id="rowdetalle" value="0">

                                        <div class="row col-md-12">
                                            <div class="form-group">                                                
                                                <button class="btn btn-sm btn-primary" style="font-size: 12px;" id="btnAgregarDetalle" tabindex="60" title="Agregar Item">
                                                    <i class="ace-icon fa fa-plus"></i>Agregar Item
                                                </button>
                                            </div>
                                            <div class="form-group">
                                                <table id="detalleVenta" class="table table-striped table-bordered table-hover hide" sortable="1" style="font-size:10px">
                                                    <thead>
                                                        <tr>
                                                            <th style="display: none">Item</th>
                                                            <th>Código</th>
                                                            <th style="width: 240px">Descripción</th>
                                                            <th>Unidad</th>
                                                            <th>Cantidad</th>
                                                            <th style="display: none">Precio Unitario</th>
                                                            <th>Valor Unitario</th>
                                                            <th style="display: none">Precio Total sDscto</th>
                                                            <th style="display: none">Valor Total sDscto</th>   
                                                            <th>Tipo Afectación</th>
                                                            <th style="display: none">IGV sDscto</th>
                                                            <th style="display: none">ISC</th>
                                                            <th style="display: none">Precio Unitario Dscto</th>
                                                            <th style="display: none">Valor Unitario Dscto</th>
                                                            <th>Descuento</th>
                                                            <th style="display: none">Descuento Porc</th>
                                                            <th style="display: none">Descuento Mont</th>
                                                            <th>Valor Total</th>
                                                            <th>IGV</th>
                                                            <th style="display: none">Precio Total</th>
                                                            <th>Acciones</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="detalleVenta_data">
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div><!-- /.col -->
                            </div>
                        </div><!-- /.row -->

                        <div class="row totales_div">
                            <div class="col-md-3">

                            </div>
                            <div class="col-md-4">
                                <div class="panel panel-primary">
                                    <div class="panel-heading" style="font-size: 12px;">Total impuestos</div>
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <label for="total_igv" class="control-label" style="width: 80px; font-size: 12px;">Total IGV:</label>
                                            <span class="label label-default" >
                                                <label class="lab_mon"> S/</label>
                                            </span>
                                            <input type="text" name="total_igv" id="total_igv" tabindex="-1" value="0.00" style="width: 160px; font-size: 12px;" disabled>
                                        </div>
                                        <div class="form-group">
                                            <label for="total_isc" class="control-label" style="width: 80px; font-size: 12px;">Total ISC:</label>
                                            <span class="label label-default" >
                                                <label class="lab_mon"> S/</label>
                                            </span>
                                            <input type="text" name="total_isc" id="total_isc" tabindex="-1" value="0.00" style="width: 160px; font-size: 12px;" disabled>
                                        </div>
                                        <div class="form-group">
                                            <label for="total_otros_impuestos" class="control-label" style="width: 80px; font-size: 12px;">Total otros impuestos:</label>
                                            <span class="label label-default" >
                                                <label class="lab_mon"> S/</label>
                                            </span>
                                            <input type="text" name="total_otros_impuestos" id="total_otros_impuestos" tabindex="-1" value="0.00" style="width: 160px; font-size: 12px;" disabled>
                                        </div>
                                    </div>
                                    <div class="panel-footer">
                                        <div class="form-group">
                                            <label for="total_impuestos" class="control-label" style="width: 80px; font-size: 12px;">Total:</label>
                                            <span class="label label-default" >
                                                <label class="lab_mon"> S/</label>
                                            </span>
                                            <input type="text" name="total_impuestos" id="total_impuestos" tabindex="-1" value="0.00" style="width: 160px; font-size: 12px;" disabled>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <input type="hidden" id="total_valorventa" value="0">
                                <input type="hidden" id="total_precioventa" value="0">
                                <input type="hidden" id="dcto_global_monto" value="0"> 
                                <input type="hidden" id="dcto_global_pcto" value="0"> 
                                <div class="panel panel-primary">
                                    <div class="panel-heading" style="font-size: 12px;">Totales factura</div>
                                    <div class="panel-body">
                                        <div class="form-group hidden">
                                            <label for="input_dcto_global" class="control-label" style="width: 180px; font-size: 12px;">Descuento global:</label>
                                            <input type="text" name="input_dcto_global" id="input_dcto_global" tabindex="-1" style="width: 115px; font-size: 12px;">
                                            <select id="select_dcto_total" style="width: 72px; font-size: 12px;">
                                                <option value="P">%</option>
                                                <option value="M">Monto</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label for="total_gravadas" class="control-label" style="width: 180px; font-size: 12px;">Total gravadas:</label>
                                            <span class="label label-default" >
                                                <label class="lab_mon"> S/</label>
                                            </span>
                                            <input type="text" name="total_gravadas" id="total_gravadas" tabindex="-1" value="0.00" style="width: 160px; font-size: 12px;" disabled>
                                        </div>
                                        <div class="form-group">
                                            <label for="total_inafectas" class="control-label" style="width: 180px; font-size: 12px;">Total inafectas:</label>
                                            <span class="label label-default" >
                                                <label class="lab_mon"> S/</label>
                                            </span>
                                            <input type="text" name="total_inafectas" id="total_inafectas" tabindex="-1" value="0.00" style="width: 160px; font-size: 12px;" disabled>
                                        </div>
                                        <div class="form-group">
                                            <label for="total_exoneradas" class="control-label" style="width: 180px; font-size: 12px;">Total exoneradas:</label>
                                            <span class="label label-default" >
                                                <label class="lab_mon"> S/</label>
                                            </span>
                                            <input type="text" name="total_exoneradas" id="total_exoneradas" tabindex="-1" value="0.00" style="width: 160px; font-size: 12px;" disabled>
                                        </div>
                                        <div class="form-group">
                                            <label for="total_gratuitas" class="control-label" style="width: 180px; font-size: 12px;">Total gratuitas:</label>
                                            <span class="label label-default" >
                                                <label class="lab_mon"> S/</label>
                                            </span>
                                            <input type="text" name="total_gratuitas" id="total_gratuitas" tabindex="-1" value="0.00" style="width: 160px; font-size: 12px;" disabled>
                                        </div>
                                        <div class="form-group">
                                            <label for="total_otros_cargos" class="control-label" style="width: 180px; font-size: 12px;">Total otros cargos:</label>
                                            <span class="label label-default" >
                                                <label class="lab_mon"> S/</label>
                                            </span>
                                            <input type="text" name="total_otros_cargos" id="total_otros_cargos" tabindex="-1" placeholder="0.00" style="width: 160px; font-size: 12px;">
                                        </div>
                                        <div class="form-group">
                                            <label for="total_descuentos" class="control-label" style="width: 180px; font-size: 12px;">Total descuentos:</label>
                                            <span class="label label-default" >
                                                <label class="lab_mon"> S/</label>
                                            </span>
                                            <input type="text" name="total_descuentos" id="total_descuentos" tabindex="-1" value="0.00" style="width: 160px; font-size: 12px;" disabled>
                                        </div>

                                        <div class="form-group" style="display:none;">
                                            <label for="total_anticipos" class="control-label" style="width: 180px; font-size: 12px;">Total anticipos:</label>
                                            <span class="label label-default" >
                                                <label class="lab_mon"> S/</label>
                                            </span>
                                            <input type="text" name="total_anticipos" id="total_anticipos" tabindex="-1" value="0.00" style="width: 160px; font-size: 12px;" disabled>
                                        </div>
                                        <div class="form-group" style="display:none;">
                                            <label for="total_percepciones" class="control-label" style="width: 180px; font-size: 12px;">Total percepciones:</label>
                                            <span class="label label-default" >
                                                <label class="lab_mon"> S/</label>
                                            </span>
                                            <input type="text" name="total_percepciones" id="total_percepciones" tabindex="-1" value="0.00" style="width: 160px; font-size: 12px;" disabled>
                                        </div>

                                    </div>
                                    <div class="panel-footer">
                                        <div class="form-group">
                                            <label for="total_venta" class="control-label" style="width: 180px; font-size: 12px;">Importe total venta:</label>
                                            <span class="label label-default" >
                                                <label class="lab_mon"> S/</label>
                                            </span>
                                            <input type="text" name="total_venta" id="total_venta" tabindex="-1" value="0.00" style="width: 160px; font-size: 12px;" disabled>
                                        </div>
                                        <div class="form-group mostrar_tipo_cambio" style="display:none;">
                                            <label for="total_venta_soles" class="control-label" style="width: 180px; font-size: 12px;">Importe total venta en soles:</label>
                                            <span class="label label-default" >
                                                <label class="lab_mon"> S/</label>
                                            </span>
                                            <input type="text" name="total_venta_soles" id="total_venta_soles" tabindex="-1" value="0.00" style="width: 160px; font-size: 12px;" disabled>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-3">
                            </div>
                            <div class="col-md-6 center" style="margin-top: 5px;">
                                <button class="btn btn-xs btn-primary registrar_comprobante" style="font-size: 12px;"> <span><i class="fa fa-save"></i></span> Registrar</button>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <a id="imprimir" class="btn btn-xs btn-primary imprimir" target="_blank" style="font-size: 12px;" disabled>
                                    <span><i class="fa fa-print"></i></span> Imprimir
                                </a> 
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <button class="btn btn-xs btn-primary limpiar" style="font-size: 12px;"> <span><i class="fa fa-trash"></i></span> Limpiar</button>
                            </div>
                            <div class="col-md-3">
                            </div>
                        </div>
                        <!-- PAGE CONTENT ENDS -->
                    </div><!-- /.main-content -->

                    <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
                        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
                    </a>
                </div>
            </div><!-- /.main-container -->
        </div>

        <!-- basic scripts -->

        <!--[if !IE]> -->
        <script src="../assets/js/jquery-2.1.4.min.js"></script>

        <!-- <![endif]-->

        <script src="../assets/js/jquery.tabletojson.min.js"></script>

        <!--[if IE]>
        <script src="../assets/js/jquery-1.11.3.min.js"></script>
        <![endif]-->
        <script src="../assets/js/chosen.jquery.min.js"></script>
        <script type="text/javascript">
                    if ('ontouchstart' in document.documentElement)
                        document.write("<script src='../assets/js/jquery.mobile.custom.min.js'>" + "<" + "/script>");
        </script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script src="../assets/js/jquery.maskedinput.min.js"></script>

        <!-- page specific plugin scripts -->

        <!--[if lte IE 8]>
        <script src="../assets/js/excanvas.min.js"></script>
        <![endif]-->
        <script src="../assets/js/jquery-ui.custom.min.js"></script>
        <script src="../assets/js/jquery.ui.touch-punch.min.js"></script>
        <script src="../assets/js/jquery.easypiechart.min.js"></script>
        <script src="../assets/js/jquery.sparkline.index.min.js"></script>
        <script src="../assets/js/jquery.flot.min.js"></script>
        <script src="../assets/js/jquery.flot.pie.min.js"></script>
        <script src="../assets/js/jquery.flot.resize.min.js"></script>

        <!-- ace scripts -->
        <script src="../assets/js/ace-elements.min.js"></script>
        <script src="../assets/js/ace.min.js"></script>

        <!-- page specific plugin scripts -->
        <script src="../assets/js/jquery-ui.min.js"></script>
        <script src="../assets/js/jquery.ui.touch-punch.min.js"></script>

        <script type="text/javascript">
                    $(document).ready(function () {
                        $(window).load(function () {
                            cargarCorrelativo();
                            $('#ruc').focus();
                            //$('#tipodocumento').val('6');
                            cambiarporcomprobante();
                        });

                        var cargarCorrelativo = function () {
                            var tipocomprobante = $('#tipocomprobante').val();
                            var tipocomprobanteref = $('#tipocomprobanteref').val();
                            if (tipocomprobante === '01' || tipocomprobante === '03') {
                                tipocomprobanteref = "";
                            }
                            $.get('../Serie', {
                                tipocomprobante: tipocomprobante, tipocomprobanteref: tipocomprobanteref
                            }, function (response) {
                                $('#nrodocumento').val(response);
                            });
            <%--
            var departamentoActual = $("#departamento").val();

                                            $.get('../Ubigeo', {
                                                "codigo_ubidepartamento": departamentoActual
                                            }, function (response) {
                                                $('#provincia').html(response);

                                                var provinciaActual = $("#provincia").val();

                                                $.get('../Ubigeo', {
                                                    "codigo_ubiprovincia": provinciaActual
                                                }, function (response) {
                                                    $('#distrito').html(response);
                                                });
                                            });
            --%>
                        };

                        var cambiarporcomprobante = function () {
                            var tipo = $('#tipocomprobante').val();
                            $('#ruc').val('');
                            $('#cliente').val('-');
                            $('#direccion').val('-');
                            $('#correo').val('-');
                            switch (tipo)
                            {
                                case '01':
                                    $('#lblruc').removeClass('hide');
                                    $('#tipodocumento').addClass('hide');
                                    $('#lblrazonsocial').removeClass('hide');
                                    $('#lblnombre').addClass('hide');
                                    $("#documentoReferencia").addClass('hide');
                                    $("#lbltiponotadebito").addClass('hide');
                                    $("#tiponotadebito").addClass('hide');
                                    $("#lbltiponotacredito").removeClass('hide');
                                    $("#tiponotacredito").removeClass('hide');
                                    $('#divdetraccion').removeClass('hide');
                                    $('#divguia').removeClass('hide');
                                    $('#ruc').focus();
                                    $('#tipodocumento').val('6');
                                    break;
                                case '03':
                                    $('#lblruc').addClass('hide');
                                    $('#tipodocumento').removeClass('hide');
                                    $('#lblrazonsocial').addClass('hide');
                                    $('#lblnombre').removeClass('hide');
                                    $("#documentoReferencia").addClass('hide');
                                    $("#lbltiponotadebito").addClass('hide');
                                    $("#tiponotadebito").addClass('hide');
                                    $("#lbltiponotacredito").removeClass('hide');
                                    $("#tiponotacredito").removeClass('hide');
                                    $('#divdetraccion').removeClass('hide');
                                    $('#divguia').removeClass('hide');
                                    $('#ruc').focus();
                                    $('#tipodocumento').val('1');
                                    break;
                                case '07':
                                    var tiporef = $('#tipocomprobanteref').val();
                                    $("#documentoReferencia").removeClass('hide');
                                    $("#lbltiponotadebito").addClass('hide');
                                    $("#tiponotadebito").addClass('hide');
                                    $("#lbltiponotacredito").removeClass('hide');
                                    $("#tiponotacredito").removeClass('hide');
                                    if (tiporef === '01') {
                                        $('#lblruc').removeClass('hide');
                                        $('#tipodocumento').addClass('hide');
                                        $('#lblrazonsocial').removeClass('hide');
                                        $('#lblnombre').addClass('hide');
                                        $('#tipodocumento').val('6');
                                    } else {
                                        $('#lblruc').addClass('hide');
                                        $('#tipodocumento').removeClass('hide');
                                        $('#lblrazonsocial').addClass('hide');
                                        $('#lblnombre').removeClass('hide');
                                        $('#tipodocumento').val('1');
                                    }
                                    $('#divdetraccion').addClass('hide');
                                    $('#divguia').addClass('hide');
                                    resetearCamposDetraccion();
                                    resetearCamposGuia();
                                    $('#nrodocumentoref').focus();
                                    break;
                                case '08':
                                    var tiporef = $('#tipocomprobanteref').val();
                                    $("#documentoReferencia").removeClass('hide');
                                    $("#lbltiponotadebito").removeClass('hide');
                                    $("#tiponotadebito").removeClass('hide');
                                    $("#lbltiponotacredito").addClass('hide');
                                    $("#tiponotacredito").addClass('hide');
                                    if (tiporef === '01') {
                                        $('#lblruc').removeClass('hide');
                                        $('#tipodocumento').addClass('hide');
                                        $('#lblrazonsocial').removeClass('hide');
                                        $('#lblnombre').addClass('hide');
                                        $('#tipodocumento').val('6');
                                    } else {
                                        $('#lblruc').addClass('hide');
                                        $('#tipodocumento').removeClass('hide');
                                        $('#lblrazonsocial').addClass('hide');
                                        $('#lblnombre').removeClass('hide');
                                        $('#tipodocumento').val('1');
                                    }
                                    $('#divdetraccion').addClass('hide');
                                    $('#divguia').addClass('hide');
                                    resetearCamposDetraccion();
                                    resetearCamposGuia();
                                    $('#nrodocumentoref').focus();
                                    break;
                            }

                        };

                        $("#motivonota").focusout(function () {
                            var motivonota = $("#motivonota").val().split("\n").join(" ").trim();
                            if (motivonota.length > 250.0) {
                                alertify.error("EL MOTIVO DE LA NOTA NO PUEDE SER MAYOR A 250 CARACTERES");
                                $('#motivonota').val('');
                            } else {
                                $('#motivonota').val(motivonota);
                            }
                        });

                        $("#inputtipocambio").focusout(function () {
                            var tipocambio = parseFloat(Number($("#inputtipocambio").val())).toFixed(3);
                            if (tipocambio === 'NaN') {
                                $("#inputtipocambio").val('0.000');
                            } else {
                                $("#inputtipocambio").val(tipocambio.toString());
                            }
                            calculardetraccion();
                        });

                        $("#inputmontodetraccionreferencial").focusout(function () {
                            var tipocambio = parseFloat(Number($("#inputmontodetraccionreferencial").val())).toFixed(2);
                            if (tipocambio === 'NaN') {
                                $("#inputmontodetraccionreferencial").val('0.00');
                            } else {
                                $("#inputmontodetraccionreferencial").val(tipocambio.toString());
                            }
                        });

                        $('#moneda').change(function () {
                            var moneda = $('#moneda').val();
                            if (moneda === 'PEN') {
                                $('.lab_mon').text('S/');
                            } else if (moneda === 'USD') {
                                $('.lab_mon').text('$');
                            } else if (moneda === 'EUR') {
                                $('.lab_mon').text('€');
                            }

                            if ($('#switch-detraccion').prop("checked")) {
                                calculardetraccion();
                            }
                        });

                        $('#tipocomprobante').change(function () {
                            $('#tipocomprobanteref').val('01');
                            cargarCorrelativo();
                            cambiarporcomprobante();
                        });

                        $('#tipocomprobanteref').change(function () {
                            cargarCorrelativo();
                            cambiarporcomprobante();
                        });

                        $("#switch-operaciongratuita").click(function () {
                            if ($(this).prop("checked")) {
                                $('label.lblOperacionGratuita').html("Si");
                                $('#switch-detraccion').prop('checked', false);
                                $("#switch-detraccion").attr("disabled", "disabled");
                                $('#lblmontodetraccionreferencial').addClass('hide');
                                $('#inputmontodetraccionreferencial').addClass('hide');
                                $('#lblporcentajedetraccion').addClass('hide');
                                $('#cbporcentajedetraccion').addClass('hide');
                                $('#lblmontodetraccion').addClass('hide');
                                $('#inputmontodetraccion').addClass('hide');
                                $('#lbldescripciondetraccion').addClass('hide');
                                $('#inputdescripciondetraccion').addClass('hide');
                                $('#lbltipocambio').addClass('hide');
                                $('#inputtipocambio').addClass('hide');
                            } else {
                                $('label.lblOperacionGratuita').html("No");
                                $("#switch-detraccion").removeAttr("disabled");
                            }
                        });

                        function calculardetraccion() {
                            var moneda = $('#moneda').val();
                            var porcDetraccion = $('#cbporcentajedetraccion').val();
                            var importa_total = $('#total_venta').val();
                            var tipocambio = $('#inputtipocambio').val();
                            if (moneda !== 'PEN') {
                                if (tipocambio === '0.000') {
                                    alertify.error("DEBE INGRESAR TIPO DE CAMBIO DIFERENTE A CERO.");
                                }
                                var monto_detraccion = Number(porcDetraccion) * Number(importa_total) * Number(tipocambio) / 100;
                                $('#inputmontodetraccion').val(parseFloat(monto_detraccion).toFixed(2));
                            } else {
                                var monto_detraccion = Number(porcDetraccion) * Number(importa_total) / 100;
                                $('#inputmontodetraccion').val(parseFloat(monto_detraccion).toFixed(2));
                            }
                        }

                        $('#cbporcentajedetraccion').change(function () {
                            calculardetraccion();
                        });

                        $('#switch-detraccion').click(function () {
                            if ($(this).prop("checked")) {
                                $('#lblporcentajedetraccion').removeClass('hide');
                                $('#cbporcentajedetraccion').removeClass('hide');
                                $('#lblmontodetraccion').removeClass('hide');
                                $('#inputmontodetraccion').removeClass('hide');
                                $('#lblmontodetraccionreferencial').removeClass('hide');
                                $('#inputmontodetraccionreferencial').removeClass('hide');
                                $('#lbltipocambio').removeClass('hide');
                                $('#inputtipocambio').removeClass('hide');
                                calculardetraccion();
                                $('#flag_detraccion').val('S');
                                $('#lbldescripciondetraccion').removeClass('hide');
                                $('#inputdescripciondetraccion').removeClass('hide');
                                $('#inputdescripciondetraccion').focus();
                            } else {
                                resetearCamposDetraccion();
                            }
                        });

                        function resetearCamposDetraccion() {
                            $('#switch-detraccion').prop('checked', false);
                            $('#lblmontodetraccionreferencial').addClass('hide');
                            $('#inputmontodetraccionreferencial').addClass('hide');
                            $('#lblporcentajedetraccion').addClass('hide');
                            $('#cbporcentajedetraccion').val('4');
                            $('#cbporcentajedetraccion').addClass('hide');
                            $('#lblmontodetraccion').addClass('hide');
                            $('#inputmontodetraccion').addClass('hide');
                            $('#lbldescripciondetraccion').addClass('hide');
                            $('#inputdescripciondetraccion').addClass('hide');
                            $('#lbltipocambio').addClass('hide');
                            $('#inputtipocambio').addClass('hide');
                            $('#inputmontodetraccion').val('0.00');
                            $('#inputmontodetraccionreferencial').val('0.00');
                            $('#inputtipocambio').val('0.000');
                            //$('#inputdescripciondetraccion').val('');
                            $('#flag_detraccion').val('N');
                        }

                        $("#btnAgregarGuia").click(function () {
                            var cont = parseInt($('#rowdetalleguia').val());
                            var newRow = cont + 1;
                            $('#rowdetalleguia').val(newRow);
                            var nuevaFila = "<tr>";
                            nuevaFila += "<td style='display: none;'>" + newRow + "</td>"; //Numero ITEM                          
                            nuevaFila += "<td><select class='select_tipo_guia' id='tipo_guia_" + newRow + "' style='font-size:10px; width:120px;' tabindex='25'>" //TIPO GUIA
                                    + "<option value='31' selected>TRANSPORTISTA</option>"
                                    + "<option value='09'>REMITENTE</option>"
                                    + "</select></td>";
                            nuevaFila += "<td><input id='numeroguia_" + newRow + "' size='15' type='text' style='font-size:10px' tabindex='26'></td>"; // NUMERO GUIA                        
                            //ACCIONES
                            nuevaFila += "<td><button type='button' name='eliminarDetalleGuia' id='" + newRow + "' class='btn btn-danger btn-xs eliminarDetalleGuia' title='Eliminar'  ><span class='glyphicon glyphicon-trash'></span></button></td>";
                            nuevaFila += "</tr>";
                            $("#detalleGuia").append(nuevaFila);
                            $('#detalleGuia').removeClass('hide');
                            $('#numeroguia_' + newRow).focus();
                        });

                        $("#detalleGuia").on('click', '.eliminarDetalleGuia', function () {
                            $(this).closest('tr').remove();
                            var cont = $('#detalleGuia >tbody >tr').length;
                            if (cont === 0) {
                                $("#detalleGuia").addClass('hide');
                                $('#flagGuia').val('N');
                            }
                        });

                        function resetearCamposGuia() {
                            $('#detalleGuia tbody').remove();
                            $('#detalleGuia').addClass('hide');
                            $('#flagGuia').val('N');
                        }

                        $('#switch-negociable').removeAttr('checked').on('click', function () {
                            //$validation = this.checked;
                            if (this.checked) {
                                $('#fechavencimiento').removeClass('hide');
                                $('#lblfechavencimiento').removeClass('hide');
                                $('#iconfechavencimiento').removeClass('hide');
                                $('#lbldepartamento').removeClass('hide');
                                $('#departamento').removeClass('hide');
                                $('#lblprovincia').removeClass('hide');
                                $('#provincia').removeClass('hide');
                                $('#lbldistrito').removeClass('hide');
                                $('#distrito').removeClass('hide');
                            } else {
                                $('#fechavencimiento').addClass('hide');
                                $('#lblfechavencimiento').addClass('hide');
                                $('#iconfechavencimiento').addClass('hide');
                                $('#lbldepartamento').addClass('hide');
                                $('#departamento').addClass('hide');
                                $('#lblprovincia').addClass('hide');
                                $('#provincia').addClass('hide');
                                $('#lbldistrito').addClass('hide');
                                $('#distrito').addClass('hide');
                            }
                        });

                        $("#fechavencimiento").datepicker({
                            dateFormat: 'dd/mm/yy',
                            minDate: '+1d'
                        }).datepicker("setDate", new Date());

                        $("#fechaemision").datepicker({
                            dateFormat: 'dd/mm/yy',
                            minDate: '-7'
                        }).datepicker("setDate", new Date());

                        $.datepicker.regional['es'] = {
                            closeText: 'Cerrar',
                            prevText: '< Ant',
                            nextText: 'Sig >',
                            currentText: 'Hoy',
                            monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
                            monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
                            dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
                            dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mié', 'Juv', 'Vie', 'Sáb'],
                            dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sá'],
                            weekHeader: 'Sm',
                            dateFormat: 'dd/mm/yy',
                            firstDay: 1,
                            isRTL: false,
                            showMonthAfterYear: false,
                            yearSuffix: ''
                        };
                        $.datepicker.setDefaults($.datepicker.regional['es']);



                        $('#formapago').change(function () {
                            var formapago = $('#formapago').val();
                            if (formapago === "L") {
                                $('#lblnumeroletra').removeClass('hide');
                                $('#numeroletra').removeClass('hide');
                                $('#lblmontoletra').removeClass('hide');
                                $('#montoletra').removeClass('hide');
                                $('#fechavencimientoletra').removeClass('hide');
                                $('#lblfechavencimientoletra').removeClass('hide');
                                $('#iconfechavencimientoletra').removeClass('hide');
                            } else {
                                $('#lblnumeroletra').addClass('hide');
                                $('#numeroletra').addClass('hide');
                                $('#lblmontoletra').addClass('hide');
                                $('#montoletra').addClass('hide');
                                $('#fechavencimientoletra').addClass('hide');
                                $('#lblfechavencimientoletra').addClass('hide');
                                $('#iconfechavencimientoletra').addClass('hide');
                            }
                        });

                        $("#fechavencimientoletra").datepicker({
                            dateFormat: 'dd/mm/yy',
                            minDate: '+1d'
                        }).datepicker("setDate", new Date());

                        $('#estadopago').change(function () {
                            var formapago = $('#estadopago').val();
                            if (formapago === "P") {
                                $('#lblmontopagado').removeClass('hide');
                                $('#montopagado').removeClass('hide');
                                $('#montopagado').focus();
                            } else {
                                $('#lblmontopagado').addClass('hide');
                                $('#montopagado').addClass('hide');
                                $('#montopagado').val('');
                            }
                        });

                        $('#departamento').change(function () {
                            var codigoDpto = $('#departamento').val();
                            $.get('../Ubigeo', {
                                "codigo_ubidepartamento": codigoDpto
                            }, function (response) {
                                $('#provincia').html(response);

                                var provinciaActual = $("#provincia").val();

                                $.get('../Ubigeo', {
                                    "codigo_ubiprovincia": provinciaActual
                                }, function (response) {
                                    $('#distrito').html(response);
                                });
                            });
                        });

                        $('#provincia').change(function () {
                            var codigoProv = $('#provincia').val();
                            $.get('../Ubigeo', {
                                "codigo_ubiprovincia": codigoProv
                            }, function (response) {
                                $('#distrito').html(response);
                            });
                        });

                        $("#btnAgregarDetalle").click(function () {
                            var rowCount = $('#detalleVenta >tbody >tr').length;
                            var cont = parseInt($('#rowdetalle').val());
                            var newRow = cont + 1;
                            $('#rowdetalle').val(newRow);
                            var nuevaFila = "<tr>";
                            nuevaFila += "<td style='display: none;'>" + newRow + "</td>"; //Numero ITEM
                            nuevaFila += "<td><input size='9' class='input_codigo' id='codigo_" + newRow + "' type='text' style='font-size:10px; text-transform:uppercase;' tabindex='51'></td>"; //CODIGO
                            nuevaFila += "<td><textarea class='input_descripcion' id='descripcion_" + newRow + "' rows='5' style='resize:none; font-size:10px; width:100%; text-transform:uppercase;' tabindex='52'></textarea></td>"; //DESCRIPCION
                            //nuevaFila += "<td>ZZ</td>"; //UNIDAD MEDIDA
                            nuevaFila += "<td><select class='select_unidadmedida' id='unidadmedida_" + newRow + "' style='font-size:10px;' tabindex='55'>" //UNIDAD MEDIDA
                                    + "<option value='ZZ' selected>ZZ</option>"
                                    + "<option value='NIU'>NIU</option>"
                                    + "</select></td>";
                            nuevaFila += "<td><input type='number' class='input_cantidad' id='cantidad_" + newRow + "' value='1.000' style='font-size:10px; width: 6em' tabindex='53'></td>";//CANTIDAD
                            nuevaFila += "<td style='display: none;'><input  id='precio_uni_" + newRow + "' placeholder='0.00' size='5' type='text' style='font-size:10px' disabled></td>";//PRECIO UNITARIO
                            nuevaFila += "<td><input class='valor_unitario' id='valor_uni_" + newRow + "' placeholder='0.00' size='7' type='text' style='font-size:10px' tabindex='54'></td>";//VALOR UNITARIO
                            nuevaFila += "<td id='precio_tot_" + newRow + "' style='display: none; font-size:10px;'>0.00</td>"; //PRECIO TOTAL SIN DCTO
                            nuevaFila += "<td id='valor_tot_" + newRow + "' style='display: none; font-size:10px;'>0.00</td>"; //VALOR TOTAL SIN DCTO
                            nuevaFila += "<td><select class='select_afectacion' id='afecto_igv_" + newRow + "' style='font-size:10px;' tabindex='55'>" //TIPO AFECTACION
                                    + "<option value='G' selected>GRAVADO - OPERACIÓN ONEROSA</option>"
                                    + "<option value='E'>EXONERADO - OPERACIÓN ONEROSA</option>"
                                    + "<option value='I'>INAFECTO - OPERACIÓN ONEROSA</option>"
                                    + "</select></td>";
                            nuevaFila += "<td id='igv_" + newRow + "' style='display: none; font-size:10px;'>0.00</td>"; // IGV SIN DCTO
                            nuevaFila += "<td id='isc_" + newRow + "' style='display: none; font-size:10px;'>0.00</td>"; // ISC
                            nuevaFila += "<td id='precio_uni_dscto_" + newRow + "' style='display: none; font-size:10px;'>0.00</td>"; // Precio unitario con DCTO
                            nuevaFila += "<td id='valor_uni_dscto_" + newRow + "' style='display: none; font-size:10px;'>0.00</td>"; // Valor unitario con DCTO
                            nuevaFila += "<td><input class='monto_descuento' id='descuento_" + newRow + "' placeholder='0.00' size='7' type='text' style='font-size:10px' tabindex='56'></td>"; // DESCUENTO
                            nuevaFila += "<td id='dscto_porc_" + newRow + "' style='display: none; font-size:10px;'>0.00</td>"; // DESCUENTO EN PORCENTAJE
                            nuevaFila += "<td id='dscto_mont_" + newRow + "' style='display: none; font-size:10px;'>0.00</td>"; // DESCUENTO EN MONTO
                            nuevaFila += "<td id='valor_tot_dscto_" + newRow + "' style='font-size:10px;'>0.00</td>"; // VALOR TOTAL
                            nuevaFila += "<td id='igv_dscto_" + newRow + "' style='font-size:10px;'>0.00</td>"; // IGV CON DESCUENTO
                            nuevaFila += "<td id='precio_tot_dscto_" + newRow + "' style='display: none; font-size:10px;'>0.00</td>"; // PRECIO TOTAL
                            //ACCIONES
                            nuevaFila += "<td><button type='button' name='eliminarDetalleVenta' id='" + newRow + "' class='btn btn-danger btn-xs eliminarDetalleVenta' title='Eliminar'  ><span class='glyphicon glyphicon-trash'></span></button></td>";
                            nuevaFila += "</tr>";
                            $("#detalleVenta").append(nuevaFila);
                            $('#detalleVenta').removeClass('hide');
                            $('#codigo_' + newRow).focus();
                        });

                        $("#detalleVenta").on('click', '.eliminarDetalleVenta', function () {
                            $(this).closest('tr').remove();
                            var cont = $('#detalleVenta >tbody >tr').length;
                            if (cont === 0) {
                                $("#detalleVenta").addClass('hide');
                            }
                            calcularTotales();
                        });


                        function calcular(orden) {
                            var cantidad = $('#cantidad_' + orden).val();
                            var valorUni = $('#valor_uni_' + orden).val();  //Number($('#tarifa_' + orden + ' option:selected').text());

                            var afecto_igv = $('#afecto_igv_' + orden).val();
                            var valorIGV = 0;
                            var igv = 0;
                            var precioUni = 0;
                            if (afecto_igv === 'G') {
                                valorIGV = 0.18;
                                igv = valorUni * valorIGV;
                            }
                            $('#igv_' + orden).html(parseFloat(igv * cantidad).toFixed(2));

                            var precioUni = Number(valorUni) + Number(igv);
                            $('#precio_uni_' + orden).val(parseFloat(precioUni).toFixed(2));
                            var precioTot = Number(cantidad * precioUni);
                            var valorTot = Number(cantidad * valorUni);
                            $('#precio_tot_' + orden).html(parseFloat(precioTot).toFixed(2));
                            $('#valor_tot_' + orden).html(parseFloat(valorTot).toFixed(2));

                            var descuento = Number($('#descuento_' + orden).val());
                            var tipoDcto = 'M';//$('#dcto_prod_' + orden).val();
                            var valorTotDscto = 0;
                            if (tipoDcto === 'P') {
                                var montDscto = valorTot * (descuento / 100);
                                $('#dscto_porc_' + orden).html(parseFloat(descuento).toFixed(2));
                                $('#dscto_mont_' + orden).html(parseFloat(montDscto).toFixed(2));
                                valorTotDscto = valorTot - montDscto;
                            } else {
                                var porcDscto = (descuento / valorTot) * 100;
                                $('#dscto_porc_' + orden).html(parseFloat(porcDscto).toFixed(2));
                                $('#dscto_mont_' + orden).html(parseFloat(descuento).toFixed(2));
                                valorTotDscto = valorTot - descuento;
                            }

                            var valorUniDscto = valorTotDscto / cantidad;
                            $('#valor_tot_dscto_' + orden).html(parseFloat(valorTotDscto).toFixed(2));
                            $('#valor_uni_dscto_' + orden).html(parseFloat(valorUniDscto).toFixed(2));

                            var igvDscto = 0;
                            if (afecto_igv === 'G') {
                                valorIGV = 0.18;
                                igvDscto = valorTotDscto * valorIGV;
                            }
                            $('#igv_dscto_' + orden).html(parseFloat(igvDscto).toFixed(2));

                            var precioTotDscto = valorTotDscto + igvDscto;
                            var precioUniDscto = precioTotDscto / cantidad;
                            $('#precio_tot_dscto_' + orden).html(parseFloat(precioTotDscto).toFixed(2));
                            $('#precio_uni_dscto_' + orden).html(parseFloat(precioUniDscto).toFixed(2));
                        }

                        $('#detalleVenta').on('focusout', '.input_cantidad', function () {
                            var orden = $(this).parents('tr').find('td:eq(20)').find('button.eliminarDetalleVenta').attr('id');
                            $('#cantidad_' + orden).val(parseFloat(Number($("#cantidad_" + orden).val())).toFixed(3).toString());
                            calcular(orden);
                            calcularTotales();
                        });

                        $('#detalleVenta').on('focusout', '.valor_unitario', function () {
                            var orden = $(this).parents('tr').find('td:eq(20)').find('button.eliminarDetalleVenta').attr('id');
                            $('#valor_uni_' + orden).val(parseFloat(Number($("#valor_uni_" + orden).val())).toFixed(2).toString());
                            calcular(orden);
                            calcularTotales();
                        });

                        $('#detalleVenta').on('focusout', '.monto_descuento', function () {
                            var orden = $(this).parents('tr').find('td:eq(20)').find('button.eliminarDetalleVenta').attr('id');
                            $('#descuento_' + orden).val(parseFloat(Number($("#descuento_" + orden).val())).toFixed(2).toString());
                            calcular(orden);
                            calcularTotales();
                        });

                        $('#detalleVenta').on('focusout', '.input_descripcion', function () {
                            var orden = $(this).parents('tr').find('td:eq(20)').find('button.eliminarDetalleVenta').attr('id');
                            var descripcion = $("#descripcion_" + orden).val().split("\n").join(" ").trim();
                            if (descripcion.length > 250.0) {
                                alertify.error("LA DESCRIPCIÓN DEL PRODUCTO O SERVICIO NO PUEDE SER MAYOR A 250 CARACTERES");
                                $('#descripcion_' + orden).val('');
                            } else {
                                $('#descripcion_' + orden).val(descripcion);
                            }
                        });

                        $('#detalleVenta').on('focusout', '.input_codigo', function () {
                            var orden = $(this).parents('tr').find('td:eq(20)').find('button.eliminarDetalleVenta').attr('id');
                            var codigo = $("#codigo_" + orden).val().trim();
                            if (codigo.length > 30.0) {
                                alertify.error("EL CÓDIGO DEL PRODUCTO O SERVICIO NO PUEDE SER MAYOR A 30 CARACTERES");
                                $('#codigo_' + orden).val('');
                            } else {
                                $('#codigo_' + orden).val(codigo);
                            }
                        });

                        $('#detalleVenta').on('change', '.input_cantidad', function () {
                            var orden = $(this).parents('tr').find('td:eq(20)').find('button.eliminarDetalleVenta').attr('id');
                            calcular(orden);
                            calcularTotales();
                        });

                        $('#detalleVenta').on('keyup', '.input_cantidad', function () {
                            var orden = $(this).parents('tr').find('td:eq(20)').find('button.eliminarDetalleVenta').attr('id');
                            calcular(orden);
                            calcularTotales();
                        });

                        $('#detalleVenta').on('keyup', '.valor_unitario', function () {
                            var orden = $(this).parents('tr').find('td:eq(20)').find('button.eliminarDetalleVenta').attr('id');
                            calcular(orden);
                            calcularTotales();
                        });

                        $('#detalleVenta').on('change', '.select_afectacion', function () {
                            var orden = $(this).parents('tr').find('td:eq(20)').find('button.eliminarDetalleVenta').attr('id');
                            calcular(orden);
                            calcularTotales();
                        });

                        $('#detalleVenta').on('keyup', '.monto_descuento', function () {
                            var orden = $(this).parents('tr').find('td:eq(20)').find('button.eliminarDetalleVenta').attr('id');
                            calcular(orden);
                            calcularTotales();
                        });

                        $('#detalleVenta').on('blur', '.monto_descuento', function () {
                            var orden = $(this).parents('tr').find('td:eq(20)').find('button.eliminarDetalleVenta').attr('id');
                            calcular(orden);
                            calcularTotales();
                        });

                        function calcularTotales() {
                            var afecto_igv = "";
                            var total_igv = 0;
                            var total_isc = 0;
                            var total_gravadas = 0;
                            var total_inafectas = 0;
                            var total_exoneradas = 0;
                            var total_gravadas_sdscto = 0;
                            var total_inafectas_sdscto = 0;
                            var total_exoneradas_sdscto = 0;
                            var total_gratuitas = 0;
                            var total_descuentos = 0;
                            $(".valor_unitario").each(function () {
                                var orden = $(this).parents('tr').find('td:eq(20)').find('button.eliminarDetalleVenta').attr('id');
                                var cantidad = $('#cantidad_' + orden).val();

                                afecto_igv = $('#afecto_igv_' + orden).val();//$(this).parent().find('td:eq(10)').html();
                                if (afecto_igv === 'G') {
                                    total_gravadas += Number($('#valor_tot_dscto_' + orden).html());
                                    total_gravadas_sdscto += Number($('#valor_tot_' + orden).html());
                                }
                                if (afecto_igv === 'E') {
                                    total_exoneradas += Number($('#valor_tot_dscto_' + orden).html());
                                    total_exoneradas_sdscto += Number($('#valor_tot_' + orden).html());
                                }
                                if (afecto_igv === 'I') {
                                    total_inafectas += Number($('#valor_tot_dscto_' + orden).html());
                                    total_inafectas_sdscto += Number($('#valor_tot_' + orden).html());
                                }

                                total_igv += Number($('#igv_dscto_' + orden).html());
                                total_descuentos += Number($('#dscto_mont_' + orden).html());
                            });

                            //Valor total de venta sin descuento ni impuestos
                            var totalValorVenta = total_gravadas_sdscto + total_exoneradas_sdscto + total_inafectas_sdscto;
                            $('#total_valorventa').val(parseFloat(totalValorVenta).toFixed(2));

                            var dctoGlobal = $('#input_dcto_global').val();
                            var tipoDctoGlobal = $('#select_dcto_total').val();
                            var dctoGlobalMonto = 0;
                            var dctoGlobalPorcentaje = 0;
                            if (dctoGlobal !== '') {
                                if (total_gravadas + total_exoneradas + total_inafectas + total_igv + total_isc > 0) {
                                    if (tipoDctoGlobal === 'P') {
                                        dctoGlobalPorcentaje = dctoGlobal;
                                        $('#dcto_global_pcto').val(dctoGlobalPorcentaje);
                                        dctoGlobalMonto = (total_gravadas + total_exoneradas + total_inafectas + total_igv + total_isc) * dctoGlobalPorcentaje / 100;
                                        $('#dcto_global_monto').val(dctoGlobalMonto);
                                    } else {
                                        dctoGlobalPorcentaje = (dctoGlobal / (total_gravadas + total_exoneradas + total_inafectas + total_igv + total_isc)) * 100;
                                        $('#dcto_global_pcto').val(dctoGlobalPorcentaje);
                                        dctoGlobalMonto = (total_gravadas + total_exoneradas + total_inafectas + total_igv + total_isc) * dctoGlobalPorcentaje / 100;
                                        $('#dcto_global_monto').val(dctoGlobalMonto);
                                    }
                                } else {
                                    $('#input_dcto_global').val('');
                                    alertify.error("NO EXISTE MONTO PARA APLICAR DESCUENTO GLOBAL");
                                    calcularTotales();
                                }
                            }
                            total_gravadas = total_gravadas * (1 - dctoGlobalPorcentaje / 100);
                            total_exoneradas = total_exoneradas * (1 - dctoGlobalPorcentaje / 100);
                            total_inafectas = total_inafectas * (1 - dctoGlobalPorcentaje / 100);
                            total_igv = total_igv * (1 - dctoGlobalPorcentaje / 100);
                            total_isc = total_isc * (1 - dctoGlobalPorcentaje / 100);
                            total_descuentos = total_descuentos + dctoGlobalMonto;

                            $('#total_igv').val(parseFloat(total_igv).toFixed(2));
                            $('#total_gravadas').val(parseFloat(total_gravadas).toFixed(2));
                            $('#total_exoneradas').val(parseFloat(total_exoneradas).toFixed(2));
                            $('#total_inafectas').val(parseFloat(total_inafectas).toFixed(2));
                            $('#total_gratuitas').val(parseFloat(total_gratuitas).toFixed(2));
                            $('#total_descuentos').val(parseFloat(total_descuentos).toFixed(2));

                            var total_impuestos = total_igv + total_isc;
                            $('#total_impuestos').val(parseFloat(total_impuestos).toFixed(2));

                            var total_otros_cargos = $('#total_otros_cargos').val() * 1;

                            var total_venta = total_gravadas + total_exoneradas + total_inafectas + total_igv + total_isc + total_otros_cargos;
                            $('#total_venta').val(parseFloat(total_venta).toFixed(2));

                            //Precio total de venta incluye impuestos y descuentos, pero no cargos.
                            var totalPrecioVenta = total_gravadas + total_exoneradas + total_inafectas + total_igv + total_isc;
                            $('#total_precioventa').val(parseFloat(totalPrecioVenta).toFixed(2));

                            if ($('#switch-detraccion').prop("checked") && !$('#switch-operaciongratuita').prop("checked")) {
                                calculardetraccion();
                            }
                        }

                        $("#input_dcto_global").keyup(function () {
                            calcularTotales();
                        });

                        $("#input_dcto_global").blur(function () {
                            calcularTotales();
                        });

                        $("#select_dcto_total").change(function () {
                            calcularTotales();
                        });

                        $("#total_otros_cargos").keyup(function () {
                            calcularTotales();
                        });

                        $("#total_otros_cargos").blur(function () {
                            calcularTotales();
                        });

                        //REGISTRAR COMPROBANTE
                        $('.registrar_comprobante').click(function (event) {
                            event.preventDefault();

                            var rowCountGuia = $('#detalleGuia >tbody >tr').length;
                            if (rowCountGuia !== 0) {
                                $('#flagGuia').val('S');
                                var guia = $('#detalleGuia tbody tr').map(function (idxRow, ele) {
                                    // comienza construyendo el objeto retVal
                                    var retVal = {};
                                    // Por cada celda
                                    var $td = $(ele).find('td').map(function (idxCell, ele) {
                                        var input = $(ele).find(':input');

                                        // Si la celda contiene un input o un select
                                        if (input.length === 1) {
                                            var attr = $('#detalleGuia thead tr th').eq(idxCell).text();
                                            retVal[attr] = input.val();
                                        } else {
                                            var attr = $('#detalleGuia thead tr th').eq(idxCell).text();
                                            retVal[attr] = $(ele).text();
                                        }
                                    });
                                    return retVal;
                                }).get();
                            }

                            if ($('#switch-detraccion').prop('checked')) {
                                if ($('#inputmontodetraccion').val() === '0.00') {
                                    alertify.error("EL TIPO CAMBIO NO PUEDE SER CERO");
                                    $('#inputtipocambio').focus();
                                    return;
                                }
                            }

                            var rowCount = $('#detalleVenta >tbody >tr').length;
                            if (rowCount === 0) {
                                alertify.error("NO HA INGRESADO NINGÚN ITEM");
                                $('#btnAgregarDetalle').focus();
                                return;
                            }

                            var table = $('#detalleVenta tbody tr').map(function (idxRow, ele) {
                                // comienza construyendo el objeto retVal
                                var retVal = {};
                                // Por cada celda
                                var $td = $(ele).find('td').map(function (idxCell, ele) {
                                    var input = $(ele).find(':input');

                                    // Si la celda contiene un input o un select
                                    if (input.length === 1) {
                                        var attr = $('#detalleVenta thead tr th').eq(idxCell).text();

                                        retVal[attr] = input.val();

                                    } else {
                                        var attr = $('#detalleVenta thead tr th').eq(idxCell).text();
                                        retVal[attr] = $(ele).text();
                                    }
                                });
                                return retVal;
                            }).get();

                            if ($('#estadopago').val() === "P") {
                                if ($('#estadopago').val() >= $('#total_venta').val()) {
                                    alertify.error("PARA UN PAGO PARCIAL EL MONTO A PAGAR: " + $('#montopagado').val() + " DEBE SER MENOR AL MONTO TOTAL DE LA VENTA: " + $('#total_venta').val());
                                    $('#montopagado').focus();
                                }
                            }

                            var flag_negociable = $('#switch-negociable').is(':checked') ? "S" : "N";

                            var tipo_dctoglobal = $("#select_dcto_total").val();
                            /*var monto_dctoglobal = 0;
                             var pcto_dctoglobal = 0;
                             
                             if (tipo_dctoglobal === "P")
                             pcto_dctoglobal = $("#input_dcto_global").val() || 0;
                             else
                             monto_dctoglobal = $("#input_dcto_global").val() || 0;*/

                            var flag_gravada = $('#switch-gravada').is(':checked') ? "S" : "N";

                            var total_anticipo = 0;

                            //CALCULO IMPORTE PAGO
                            var importe_pago = 0;
                            var monto_efectivo = 0;
                            var monto_otro = 0;
                            var referencia_otro = "";
                            var cambio_pago = 0;
                            $('.registrar_comprobante').prop('disabled', true);
                            $.ajax({
                                method: "POST",
                                url: "../Comprobante",
                                data: {"opcion": "registrar", "detalleventa": JSON.stringify(table), "tipoComprobante": $('#tipocomprobante').val(), "tipoDocumento": $('#tipodocumento').val(),
                                    "flag_negociable": flag_negociable, "fecha_vencimiento": $("#fechavencimiento").val(), "moneda": $('#moneda').val(),
                                    "formapago": $('#formapago').val(), "estatuspago": $('#estadopago').val(), "montopagado": $('#montopagado').val(), "tipo_dctoglobal": tipo_dctoglobal, "pcto_dctoglobal": $('#dcto_global_pcto').val(),
                                    "monto_dctoglobal": $('#dcto_global_monto').val(), "total_gravada": $('#total_gravadas').val(), "total_inafecta": $('#total_inafectas').val(),
                                    "total_exonerada": $('#total_exoneradas').val(), "total_gratuita": $('#total_gratuitas').val(), "total_impuesto": $('#total_impuestos').val(), "total_igv": $('#total_igv').val(),
                                    "total_isc": $('#total_isc').val(), "total_otrotributo": $('#total_otros_impuestos').val(), "total_valorventa": $('#total_valorventa').val(), "total_precioventa": $('#total_precioventa').val(),
                                    "total_descuento": $('#total_descuentos').val(), "total_otrocargo": $('#total_otros_cargos').val(), "total_anticipo": total_anticipo, "total_venta": $('#total_venta').val(),
                                    "importe_pago": importe_pago, "monto_efectivo": monto_efectivo, "monto_otro": monto_otro, "referencia_otro": referencia_otro, "cambio_pago": cambio_pago,
                                    "ruc": $('#ruc').val(), "direccion": $('#direccion').val(), "ubigeocliente": $('#ubigeocliente').val(), "correo": $('#correo').val(), "cliente": $('#cliente').val(), "fecha_emision": $("#fechaemision").val(),
                                    "flag_detraccion": $('#flag_detraccion').val(), "pcto_detraccion": $('#cbporcentajedetraccion').val(), "monto_detraccion": $('#inputmontodetraccion').val(), "monto_ref_detraccion": $('#inputmontodetraccionreferencial').val(),
                                    "descripcion_detraccion": $('#inputdescripciondetraccion').val(), "flag_guia": $('#flagGuia').val(), "guia": JSON.stringify(guia),
                                    "tipocomprobanteref": $('#tipocomprobanteref').val(), "nrodocumentoref": $('#nrodocumentoref').val(), "tiponotacredito": $('#tiponotacredito').val(), "tiponotadebito": $('#tiponotadebito').val(), "motivonota": $('#motivonota').val()
                                }
                            }).done(function (data) {
                                var obj = jQuery.parseJSON(data);
                                if (obj.mensaje.indexOf('ERROR') !== -1) {
                                    $('.divError').html(obj.html);
                                    $('.divError').addClass('tada animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                                        $('.divError').removeClass('tada animated');
                                    });
                                } else {


                                    $('#imprimir').attr('disabled', false);
                                    $('#imprimir').attr('href', '../Download?opcion=imprimir&linkpdf=' + obj.linkpdf);
                                    window.open('../Download?opcion=imprimir&linkpdf=' + obj.linkpdf, '_blank');

                                    alertify.success(obj.mensaje);
                                }
                            });

                        });

                        $('.limpiar').click(function () {
                            $('#ruc').val('-');
                            $('#direccion').val('-');
                            $('#correo').val('-');
                            $('#cliente').val('-');
                            $('#ubigeocliente').val('');
                            $('#dcto_global_pcto').val('0');
                            $('#dcto_global_monto').val('0');
                            $('#total_valorventa').val('0');
                            $('#total_precioventa').val('0');

                            $('#total_igv').val('0.00');
                            $('#total_impuestos').val('0.00');
                            $('#input_dcto_global').val('');
                            $('#select_dcto_global').prop('selectedIndex', 0);
                            $('#total_gravadas').val('0.00');
                            $('#total_inafectas').val('0.00');
                            $('#total_exoneradas').val('0.00');
                            $('#total_gratuitas').val('0.00');
                            $('#total_otros_cargos').val('');
                            $('#total_descuentos').val('0.00');
                            $('#total_venta').val('0.00');


                            $('#moneda').prop('selectedIndex', 0);
                            $('#tipocomprobante').prop('selectedIndex', 0);
                            cargarCorrelativo();
                            cambiarporcomprobante();
                            $('#formapago').prop('selectedIndex', 0);
                            $('#lblnumeroletra').addClass('hide');
                            $('#numeroletra').addClass('hide');
                            $('#lblmontoletra').addClass('hide');
                            $('#montoletra').addClass('hide');
                            $('#fechavencimientoletra').addClass('hide');
                            $('#lblfechavencimientoletra').addClass('hide');
                            $('#iconfechavencimientoletra').addClass('hide');

                            $('#estadopago').prop('selectedIndex', 0);
                            $('#lblmontopagado').addClass('hide');
                            $('#montopagado').addClass('hide');
                            $('#montopagado').val('');

                            $('#switch-operaciongratuita').prop('checked', false);

                            resetearCamposDetraccion();

                            resetearCamposGuia();

                            $('#switch-negociable').prop('checked', false);
                            $('#fechavencimiento').addClass('hide');
                            $('#lblfechavencimiento').addClass('hide');
                            $('#iconfechavencimiento').addClass('hide');
                            $('#lbldepartamento').addClass('hide');
                            $('#departamento').addClass('hide');
                            $('#lblprovincia').addClass('hide');
                            $('#provincia').addClass('hide');
                            $('#lbldistrito').addClass('hide');
                            $('#distrito').addClass('hide');
                            $("#fechavencimiento").datepicker({
                                dateFormat: 'dd/mm/yy',
                                minDate: '+1d'
                            }).datepicker("setDate", new Date());
                            $("#fechaemision").datepicker({
                                dateFormat: 'dd/mm/yy'
                            }).datepicker("setDate", new Date());
                            $("#fechavencimientoletra").datepicker({
                                dateFormat: 'dd/mm/yy',
                                minDate: '+1d'
                            }).datepicker("setDate", new Date());
                            $('#detalleVenta tbody').remove();
                            $('#detalleVenta').addClass('hide');

                            $('.registrar_comprobante').prop('disabled', false);
                            $('#imprimir').attr('disabled', true);
                            $("#imprimir").removeAttr('href');
                            $('#ruc').focus();
                        });

                        $('#buscarsunat').click(function (event) {
                            var tipodocumento = '6';
                            if ($('#tipocomprobante').val() === '03') {
                                tipodocumento = $('#tipodocumento').val();
                            }
                            var numerodocumento = $('#ruc').val();
                            $.ajax({
                                method: "POST",
                                url: "../Cliente",
                                data: {"opcion": "buscarws", "idtipodocumento": tipodocumento, "numerodocumento": numerodocumento}
                            }).done(function (data) {
                                if (tipodocumento === '1') {
                                    $('#cliente').val(data);
                                    $('#direccion').focus();
                                } else {
                                    var obj = jQuery.parseJSON(data);
                                    $('#cliente').val(obj.razon_social);
                                    $('#direccion').val(obj.direccioncompleta);
                                    $('#ubigeocliente').val(obj.ubigeo);
                                    $('#correo').focus();
                                }
                            });
                        });
                    });
        </script>
    </body>
    <%
        } else {
            response.sendRedirect("../");
        }
    %>
</html>
