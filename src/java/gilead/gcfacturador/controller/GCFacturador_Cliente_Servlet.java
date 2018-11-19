/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gilead.gcfacturador.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

/**
 *
 * @author Pablo
 */
public class GCFacturador_Cliente_Servlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String opcion = request.getParameter("opcion");
        System.out.println("entro a buscar cliente");
        if (opcion.equals("buscarws")) {
            try (PrintWriter out = response.getWriter()) {
                String idtipodocumento = request.getParameter("idtipodocumento");
                String numerodocumento = request.getParameter("numerodocumento");
                String url = "";
                if (idtipodocumento.equals("1")) {
                    url = "http://localhost:8080/WSRUC/webresources/generic/consultadni?dni=" + numerodocumento;
                } else {
                    url = "http://localhost:8080/WSRUC/webresources/generic/consultaruc?ruc=" + numerodocumento;
                }

                String aux = null;
                try {
                    DefaultHttpClient httpClient = new DefaultHttpClient();
                    HttpGet getRequest = new HttpGet(url);
                    HttpResponse httpResponse = httpClient.execute(getRequest);

                    if (httpResponse.getStatusLine().getStatusCode() != 200) {
                        throw new RuntimeException("Failed : HTTP error code : "
                                + httpResponse.getStatusLine().getStatusCode());
                    }
                    BufferedReader br = new BufferedReader(new InputStreamReader(
                            (httpResponse.getEntity().getContent()), "UTF-8"));

                    String output;
                    while ((output = br.readLine()) != null) {
                        aux = output;
                    }
                } catch (IOException ex) {
                }

                out.print(aux);
                System.out.println("buscarws -- " + aux);
            }
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
