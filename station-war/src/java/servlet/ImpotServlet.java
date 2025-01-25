// ImpotServlet.java
package servlet;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;

@WebServlet("/ImpotServlet")
public class ImpotServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String maisonId = request.getParameter("maisonId");
            
            if (maisonId != null && !maisonId.isEmpty()) {
                // Passer le maisonId comme attribut de la requête
                request.setAttribute("maisonId", maisonId);
                
                // Utiliser le RequestDispatcher pour forward vers la JSP
                request.getRequestDispatcher("impot/paiement_impot.jsp").forward(request, response);
            } else {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"error\": \"maisonId manquant\"}");
            }
        } catch (Exception ex) {
            Logger.getLogger(ImpotServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"error\": \"" + ex.getMessage() + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}