<%-- 
    Document   : index
    Created on : Jan 7, 2026, 9:48:21 PM
    Author     : alvin
    Description: Entry point - Redirects to client dashboard
--%>

<%
    // Redirect to dashboard servlet
    response.sendRedirect(request.getContextPath() + "/dashboard");
%>
