package Controller;


import dao.ParameterDAO;
import model.Parameter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.sql.Date;


@WebServlet(name = "ParameterController", value = "/par")
public class ParameterController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LocalDate localDate = LocalDate.now();
        if(localDate.getDayOfMonth() == 29){
            ParameterDAO parameterDAO = new ParameterDAO();
            Parameter p = new Parameter();

            String id = String.valueOf(Date.valueOf(LocalDate.now()));
            double number_cus = Double.parseDouble(request.getParameter("countCus"));
            double number_ord = Double.parseDouble(request.getParameter("countOrd"));
            double number_pro = Double.parseDouble(request.getParameter("countPro"));
            double revenue = Double.parseDouble(request.getParameter("calculateRev"));
            Date update_date = Date.valueOf(LocalDate.now());

            p.setId(id);
            p.setNumber_cus(number_cus);
            p.setNumber_ord(number_ord);
            p.setNumber_pro(number_pro);
            p.setRevenue(revenue);
            p.setUpdate_date(update_date);

            parameterDAO.insert(p);
        }
            request.getRequestDispatcher("thongke.jsp").forward(request, response);
    }
}

