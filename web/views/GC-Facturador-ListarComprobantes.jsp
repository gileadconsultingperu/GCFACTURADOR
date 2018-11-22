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
        <title>GC FACTURADOR - Listar Comprobantes</title>

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

        <script>
            function procesarcomprobante(idcomprobante, estado, ubl) {
                //estado: P: PDF, X: XML, S:SUNAT
                alert(idcomprobante + "|" + estado + "|" + ubl);
                $.ajax({
                    type: "POST",
                    url: "../Comprobante",
                    async: false,
                    data: {
                        idcomprobante: idcomprobante,
                        estado: estado,
                        ubl: ubl,
                        opcion: "procesarcomprobante"
                    },
                    success: function (resp) {
                        $('#detalleSeguimiento tbody').remove();
                        $.ajax({
                            url: "../Comprobante",
                            method: "GET",
                            data: {"opcion": 'obtenerseguimiento', "idcomprobante": idcomprobante},
                            success: function (data) {
                                var obj = jQuery.parseJSON(data);
                                for (i = 0; i < obj.data.length; i++) {
                                    var nuevaFila = "<tr class=\"dtSeguimiento\" id=\"" + i + "\">";
                                    nuevaFila += "<td>" + obj.data[i].proceso + "</td>";
                                    nuevaFila += "<td>" + obj.data[i].cdr + "</td>";
                                    nuevaFila += "<td>" + obj.data[i].nota + "</td>";
                                    nuevaFila += "<td>" + obj.data[i].observacion + "</td>";
                                    nuevaFila += "<td>" + obj.data[i].acciones + "</td>";
                                    $("#detalleSeguimiento").append(nuevaFila);
                                }
                            },
                            error: function (error) {
                                alertify.error('ERROR AL EJECUTAR EL PROCEDIMIENTO AJAX.');
                            }
                        }).done();
                    }
                });
            }
        </script>
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
                                Listar Comprobantes 
                            </h1>
                        </div><!-- /.page-header -->

                        <div>
                            <label for="date-label-from" class="control-label">Desde: </label> 
                            <input type="text" name="fecha_desde" id="fecha_desde" class="datepicker" style="width: 90px;" placeholder="dd/mm/yyyy" disabled/>
                            &nbsp;
                            <label for="date-label-to" class="control-label">Hasta: </label>
                            <input type="text" name="fecha_hasta" id="fecha_hasta" class="datepicker" style="width: 90px;" placeholder="dd/mm/yyyy" disabled/>
                            &nbsp;
                            <label for="text-label-voucher" class="control-label">Tipo Comprobrobante: </label>
                            <select id="tipoCmp" name="tipoCmp" tabindex="3" style="width: 140px;">
                                <option value="0" selected="selected">Todos</option>
                                <option value="01">FACTURA</option>
                                <option value="03">BOLETA</option>
                                <option value="07">NOTA CRÉDITO</option>
                                <option value="08">NOTA DÉBITO</option>
                            </select>
                            &nbsp;
                            <label for="text-label-nroComprob" class="control-label">Nº Comprobante: </label>
                            <input type="text" name="nroComprob" id="nroComprob" style="width: 120px; text-transform: uppercase;" placeholder="serie-correlativo"/>
                            &nbsp;&nbsp;&nbsp;
                            <input type="button" name="buscar" id="buscar" value="Buscar" class="btn btn-info"/>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-xs-12">
                                <!-- PAGE CONTENT BEGINS -->
                                <div class="clearfix">
                                    <div class="pull-right tableTools-container"></div>
                                </div>                               
                                <div>
                                    <table id="tablaComprobantes" class="table table-striped table-bordered table-hover small">
                                        <thead>
                                            <tr>
                                                <th>Fecha</th>
                                                <th>Tipo Comprobante</th>
                                                <th>Serie-Número</th>   
                                                <th>DOI</th>
                                                <th>Cliente</th>
                                                <th>Moneda</th>   
                                                <th>Total</th>
                                                <th>Estado</th>
                                                <th>PDF</th>
                                                <th>XML</th>
                                                <th>CDR</th>
                                                <th>Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody id="employee_data">
                                        </tbody>
                                    </table>
                                </div>
                                <!-- PAGE CONTENT ENDS -->
                            </div><!-- /.col -->
                        </div><!-- /.row -->
                    </div><!-- /.main-content -->

                    <!-- Modales -->
                    <div class="modal" id="modalSeguimientoComprobante" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="blue bigger" id="tituloModalSeguimientoComprobante">Seguimiento Comprobante</h4>
                                </div>

                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="form-group">     			
                                                <div>
                                                    <table id="detalleSeguimiento" class="table table-striped table-bordered table-hover small">
                                                        <thead>
                                                            <tr>
                                                                <th>Proceso</th>
                                                                <th>CDR</th>                       
                                                                <th>Nota</th>                       
                                                                <th>Observación</th>                       
                                                                <th>Acción</th>                       
                                                            </tr>
                                                        </thead>
                                                        <tbody id="employee_data">
                                                        </tbody>
                                                    </table>
                                                </div>     		
                                            </div>  
                                        </div>
                                    </div>
                                </div>

                                <div class="modal-footer">
                                </div>

                            </div>
                        </div>
                    </div>

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
        <script src="../assets/js/jquery.dataTables.min.js"></script>
        <script src="../assets/js/jquery.dataTables.bootstrap.min.js"></script>
        <script src="../assets/js/dataTables.buttons.min.js"></script>
        <script src="../assets/js/buttons.flash.min.js"></script>
        <script src="../assets/js/buttons.html5.min.js"></script>
        <script src="../assets/js/buttons.print.min.js"></script>
        <script src="../assets/js/buttons.colVis.min.js"></script>
        <script src="../assets/js/dataTables.select.min.js"></script>
        <script src="../assets/js/dataTables/jszip.min.js"></script>
        <script src="../assets/js/dataTables/pdfmake.min.js"></script>
        <script src="../assets/js/dataTables/vfs_fonts.js"></script>

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

        <link rel="stylesheet" href="../assets/css/jquery-ui.min.css" />

        <script type="text/javascript">
                    $(document).ready(function () {

                        var d = new Date();

                        var month = d.getMonth() + 1;
                        var day = d.getDate();

                        var output = (day < 10 ? '0' : '') + day + '/' +
                                (month < 10 ? '0' : '') + month + '/' +
                                d.getFullYear();

                        cargarComprobantes("", "0", output, output);

                        var tablaComprobantes;
                        function cargarComprobantes(nroComp, tipoComp, desde, hasta) {
                            tablaComprobantes = $('#tablaComprobantes').DataTable({
                                bAutoWidth: false,
                                "processing": true,
                                "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "Todos"]],
                                "iDisplayLength": -1,
                                destroy: true,
                                responsive: true,
                                "searching": true,
                                "order": [[0, 'asc']],
                                ajax: {
                                    method: "POST",
                                    url: "../Comprobante",
                                    data: {"opcion": "listar", "desde": desde, "hasta": hasta, "tipoComp": tipoComp, "nroComp": nroComp},
                                    dataSrc: "data"
                                },
                                columns: [
                                    {"data": "fecha"},
                                    {"data": "tipocomprobante"},
                                    {"data": "nrocomprobante"},
                                    {"data": "nrodocumento"},
                                    {"data": "cliente"},
                                    {"data": "moneda"},
                                    {"data": "total"},
                                    {"data": "estado"},
                                    {"data": "pdf"},
                                    {"data": "xml"},
                                    {"data": "cdr"},
                                    {"data": "acciones"}
                                ],
                                dom: '<"row"<"col-xs-12 col-sm-4 col-md-4"l><"col-xs-12 col-sm-4 col-md-4"B><"col-xs-12 col-sm-4 col-md-4"f>>' +
                                        'tr<"row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>> ',
                                'columnDefs': [
                                    {
                                        'targets': [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                                        'createdCell': function (td, cellData, rowData, row, col) {
                                            $(td).attr('contenteditable', 'false');
                                        }
                                    },
                                    {
                                        "targets": [1, 2, 3, 6, 8],
                                        "searchable": false
                                    }
                                ],
                                buttons: [
                                ],
                                language: {
                                    "url": "../assets/util/espanol.txt"
                                }
                            });

                            $.fn.dataTable.Buttons.defaults.dom.container.className = 'dt-buttons btn-overlap btn-group btn-overlap';
                            new $.fn.dataTable.Buttons(tablaComprobantes, {
                                buttons: [
                                    {
                                        "extend": "copy",
                                        "text": "<i class='fa fa-copy bigger-110 pink'></i>",
                                        "titleAttr": "Copiar",
                                        "className": "btn btn-white btn-primary btn-bold"
                                    },
                                    {
                                        "extend": 'excel',
                                        "titleAttr": "Excel",
                                        "text": "<i class='fa fa-file-excel-o bigger-110 green'></i>",
                                        "className": "btn btn-white btn-primary btn-bold"
                                    },
                                    {
                                        "extend": "pdf",
                                        "titleAttr": "PDF",
                                        "text": "<i class='fa fa-file-pdf-o bigger-110 red'></i>",
                                        "className": "btn btn-white btn-primary btn-bold"
                                    },
                                    {
                                        "extend": "print",
                                        "titleAttr": "Imprimir",
                                        "text": "<i class='fa fa-print bigger-110 grey'></i>",
                                        "className": "btn btn-white btn-primary btn-bold",
                                        autoPrint: true,
                                        message: 'This print was produced using the Print button for DataTables'
                                    }
                                ]
                            });

                            tablaComprobantes.buttons().container().appendTo($('.tableTools-container'));
                        }

                        $('#buscar').click(function () {
                            var fecha_desde = $('#fecha_desde').val();
                            var fecha_hasta = $('#fecha_hasta').val();
                            var tipoComp = $('#tipoCmp').val();
                            var nroComp = $('#nroComprob').val();
                            $('#tablaComprobantes').DataTable().destroy();
                            cargarComprobantes(nroComp, tipoComp, fecha_desde, fecha_hasta);
                        });

                        //Detallar seguimiento
                        $(document).on('click', '.detallarseguimiento', function () {
                            var datos = $(this).attr('id');
                            $('#modalSeguimientoComprobante').modal('show');
                            var array = [];
                            array = datos.split(" | ");
                            $('#detalleSeguimiento tbody').remove();
                            $('#tituloModalSeguimientoComprobante').text('Seguimiento Comprobante: ' + array[1]);
                            $.ajax({
                                url: "../Comprobante",
                                method: "GET",
                                data: {"opcion": 'obtenerseguimiento', "idcomprobante": array[0]},
                                success: function (data) {
                                    var obj = jQuery.parseJSON(data);
                                    for (i = 0; i < obj.data.length; i++) {
                                        var nuevaFila = "<tr class=\"dtSeguimiento\" id=\"" + i + "\">";
                                        nuevaFila += "<td>" + obj.data[i].proceso + "</td>";
                                        nuevaFila += "<td>" + obj.data[i].cdr + "</td>";
                                        nuevaFila += "<td>" + obj.data[i].nota + "</td>";
                                        nuevaFila += "<td>" + obj.data[i].observacion + "</td>";
                                        nuevaFila += "<td>" + obj.data[i].acciones + "</td>";
                                        $("#detalleSeguimiento").append(nuevaFila);
                                    }
                                },
                                error: function (error) {
                                    alertify.error('ERROR AL EJECUTAR EL PROCEDIMIENTO AJAX.');
                                }
                            }).done();
                        });

                        $(".datepicker").datepicker({
                            showOn: "button",
                            buttonImage: "../assets/images/gif/calendar.gif",
                            buttonImageOnly: false,
                            dateFormat: 'dd/mm/yy',
                            changeMonth: true,
                            changeYear: true
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
                    });
        </script>
    </body>
    <%
        } else {
            response.sendRedirect("../");
        }
    %>
</html>
