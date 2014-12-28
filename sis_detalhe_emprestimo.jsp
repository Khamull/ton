<%@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ include file="inc/seguranca.jsp" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="emprestimo" class="financeiro.Emprestimo" scope="page"></jsp:useBean>

<jsp:useBean id="contapagar" class="financeiro.ContasPagar" scope="page"></jsp:useBean>

<jsp:useBean id="data" class="formatar.Datas" scope="page"></jsp:useBean>

<%
//Instancia um objeto do tipo Statement para ajudar na query
Statement st01 = con.createStatement();
%>


<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
ResultSet rs01 = null;
%>


<%
//Recupera o emprestimoID trazido via URL
emprestimo.emprestimoID = Integer.parseInt(request.getParameter("emprestimoID"));
%>


<%
//Pesquisa informações sobre o Empréstimo
rs = st.executeQuery(emprestimo.detalheEmprestimo());
%>


<%
//Objetos usado para formatar valores no estilo Moeda
Currency currency = Currency.getInstance("BRL");

DecimalFormat formato = new DecimalFormat("R$ #,##0.00");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Currency"%>
<%@page import="java.text.DecimalFormat"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-2" />
<title>FORTE SYSTEM</title>

<script type="text/javascript">
function verForm(){
	
}
</script>

<script type="text/javascript" src="js/jquery.js"></script>


<script type="text/javascript" src="js/jquery-1.4.3.min.js"></script>
    <script type="text/javascript" src="js/jquery.pstrength-min.1.2.js"></script>
        <script>
        	$(document).ready(function(){
				$('.password').pstrength();
			});
        </script>

<script type="text/javascript" src="js/interface.js"></script>

<!--[if lt IE 7]>
 <style type="text/css">
 .dock img { behavior: url(iepngfix.htc) }
 </style>
<![endif]-->   

<link href="css/menu.css" rel="stylesheet" type="text/css" />
<link href="css/geral.css" rel="stylesheet" type="text/css" />

</head>

<body>

<div id="container">

<div id="topo">
 <jsp:include page="inc/menu_superior.jsp" />
</div>


<div id="corpo">
<table width="985" align="center" height="400">
<tr>
 <td height="25" bgcolor="#EEEEEE"><input type="button" class="botao" onclick="javascript: window.location.href='sis_view_livro_caixa.jsp'" value="Lista Bancos" /></td>
</tr>
<tr>
 <td height="25"></td>
</tr>
<tr>
 <td valign="top" align="center">
 
 <table width="427" align="center" cellpadding="4" cellspacing="4" style="border:1px solid #444444">
   <tr bgcolor="#EEEEEE">
     <td colspan="3" align="center"><strong>DETALHES DO EMPR&Eacute;STIMO</strong></td>
   </tr>
   <%if(rs.next()){ %>
   <tr bgcolor="#CCCCCC">
     <td width="150" align="left" bgcolor="#FFFFFF">Valor Emprestado</td>
     <td colspan="2" align="left" bgcolor="#FFFFFF"><%=formato.format(rs.getDouble("valor")) %> &nbsp;&nbsp; de ( <strong><%=rs.getString("favorecido") %></strong> )</td>
   </tr>
   <tr bgcolor="#CCCCCC">
     <td align="left" bgcolor="#FFFFFF">Depositado no Banco</td>
     <td width="116" align="left" bgcolor="#FFFFFF"><%=rs.getString("banco") %></td>
     <td width="119" align="left" bgcolor="#FFFFFF"><marquee direction="left"> 
     <font color="#009933"><img src="ico/bancoPara.png" border="0" /></font>
   </marquee></td>
   </tr>
   <tr bgcolor="#EEEEEE">
     <td colspan="3" align="center"><strong>DETALHES DO PAGAMENTO DO EMPR&Eacute;STIMO</strong></td>
   </tr>
   <tr>
     <td align="left" bgcolor="#FFFFFF">Favorecido</td>
     <td colspan="2" align="left" bgcolor="#FFFFFF"><%=rs.getString("favorecido") %></td>
   </tr>
   <tr>
     <td align="left" bgcolor="#FFFFFF">Forma de Pgto</td>
     <td colspan="2" align="left" bgcolor="#FFFFFF"><%=rs.getString("descricao") %></td>
   </tr>
   <tr>
     <td align="left" bgcolor="#FFFFFF">Vezes</td>
     <td colspan="2" align="left" bgcolor="#FFFFFF">
     <%if(rs.getString("vezes").equals("1")){ %>
     	A vista
     <%}else{ %>
     	<%=rs.getString("vezes") %> vezes
     <%} %>     </td>
   </tr>
   <tr>
     <td align="left" bgcolor="#FFFFFF"><p>Vencimento 1&ordf; Parcela</p></td>
     <td colspan="2" align="left" bgcolor="#FFFFFF"><%=data.converteDeData(String.valueOf(rs.getDate("data"))) %></td>
   </tr>
   <tr>
     <td align="left" bgcolor="#FFFFFF">Intevalo entre parcelas</td>
     <td colspan="2" align="left" bgcolor="#FFFFFF"><%=rs.getString("intervalo") %> dias</td>
   </tr>
   <%} %>
   <tr>
     <td align="center" colspan="3"><input type="button" class="botao" onclick="javascript: history.go(-1)" value="&lt;&lt; Voltar" /></td>
   </tr>
 </table>
 
 </td>
</tr>
</table>
</div>


<div id="rodape"><jsp:include page="inc/rodape.jsp" /></div>

</div>

<script type="text/javascript">
	
	$(document).ready(
		function()
		{
			$('#dock').Fisheye(
				{
					maxWidth: 50,
					items: 'a',
					itemsText: 'span',
					container: '.dock-container',
					itemWidth: 40,
					proximity: 50,
					halign : 'center'
				}
			)
		}
	);

</script>

</body>
</html>