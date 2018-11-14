/**
 * Compañia            : Gilead Consulting S.A.C.
 * Sistema             : GC-Business
 * Módulo              : Seguridad
 * Nombre              : GCBusiness_Login_Servlet.java
 * Versión             : 1.0
 * Fecha Creación      : 21-08-2018
 * Autor Creación      : Pablo Jimenez Aguado
 * Uso                 : Clase controlador para el acceso al sistema GC-Business
 */
/** Mantenimiento de codigo fuente
 *
 * @01 REQ_01 PJIMENEZ 22-08-2018: Agregar mensaje...
 * @02 INC_01 LROSALES 25-08-2018: Corregir error en...
 */
package gilead.gcfacturador.controller;

import gilead.gcfacturador.dao.impl.DaoEmpresaImpl;
import gilead.gcfacturador.dao.impl.DaoUsuarioImpl;
import gilead.gcfacturador.model.BeanEmpresa;
import gilead.gcfacturador.model.BeanUsuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class GCFacturador_Login_Servlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");

        if (user != null && !"".equals(user.trim())) {
            if (pass != null && !"".equals(pass.trim())) {
                DaoUsuarioImpl daoUsuarioImpl = new DaoUsuarioImpl();
                Integer idusuario = daoUsuarioImpl.autentica(user, pass);

                if (idusuario != null) {
                    BeanUsuario beanUsuario = (BeanUsuario) daoUsuarioImpl.accionObtener(idusuario);

                    if (beanUsuario.getEstado().charAt(0) == 'A') {
                        DaoEmpresaImpl daoEmpresa = new DaoEmpresaImpl();
                        BeanEmpresa beanEmpresa = (BeanEmpresa) daoEmpresa.accionObtener(1);
                        HttpSession sesion = request.getSession(true);
                        sesion.setAttribute("usuario", beanUsuario);
                        sesion.setAttribute("login_usuario", beanUsuario.getUsuario());
                        sesion.setAttribute("rucEmpresa", beanEmpresa.getRuc());
                        request.getRequestDispatcher("views/GC-Facturador-Home.jsp").forward(request, response);
                    } else {
                        request.setAttribute("errorSesion", "<div class='alert alert-danger'>El usuario no se encuentra habilitado. Consulte al Administrador.\n</div>");
                        request.getRequestDispatcher("views/GC-Facturador-Login.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("errorSesion", "<div align=\"center\" class='alert alert-danger'>El usuario y la contraseña no coinciden.\n</div>");
                    request.getRequestDispatcher("views/GC-Facturador-Login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("errorSesion", "<div align=\"center\" class='alert alert-danger'>Debe escribir una contraseña válida.</div>");
                request.getRequestDispatcher("views/GC-Facturador-Login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorSesion", "<div align=\"center\" class='alert alert-danger'>Debe escribir un usuario válido.</div>");
            request.getRequestDispatcher("views/GC-Facturador-Login.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
