package gilead.gcfacturador.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GCFacturador_Download_Servlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");

        String opcion = request.getParameter("opcion");
        if (opcion.equals("descargar")) {
            PrintWriter out = response.getWriter();
            String filepath = request.getParameter("link");
            String[] split = filepath.split("\\/", 0);
            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-Disposition", "attachment; filename=\""
                    + split[5] + "\"");

            FileInputStream fileInputStream = new FileInputStream(filepath);

            int i;
            while ((i = fileInputStream.read()) != -1) {
                out.write(i);
            }
            fileInputStream.close();
            out.close();
        } else if (opcion.equals("imprimir")) {
            String linkpdf = request.getParameter("linkpdf");
            String[] split = linkpdf.split("\\/", 0);
            String fechaemision = request.getParameter("fechaemision");
            System.out.println("processRequest-linkpdf : " + linkpdf);
            FileInputStream archivo = new FileInputStream(linkpdf);
            int tamanoInput = archivo.available();
            byte[] datosPDF = new byte[tamanoInput];
            archivo.read(datosPDF, 0, tamanoInput);
            response.setHeader("Content-disposition", "inline; filename=\""
                    + split[5] + "\"");
            response.setContentType("application/pdf");
            response.setContentLength(tamanoInput);
            response.getOutputStream().write(datosPDF);
            archivo.close();
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
