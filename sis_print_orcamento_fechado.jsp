<%//@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ include file="inc/conexao.jsp" %>
<%@ include file="inc/seguranca.jsp" %>

<jsp:useBean id="item" class="pdv.OrcamentoItem" scope="page"></jsp:useBean>

<jsp:useBean id="empresa" class="cadastro.Empresa" scope="page"></jsp:useBean>

<jsp:useBean id="orcamento" class="pdv.Orcamento" scope="page"></jsp:useBean>

<jsp:useBean id="formatar" class="formatar.Datas" scope="page"></jsp:useBean>

<jsp:useBean id="forma" class="pdv.FormaPagamento" scope="page"></jsp:useBean>

<jsp:useBean id="usuario" class="cadastro.Usuario" scope="page"></jsp:useBean>

<jsp:useBean id="cliente" class="cadastro.Cliente" scope="page"></jsp:useBean>

<%
//Instancia um objeto do tipo Statemenet para auxiliar na query
Statement st01 = con.createStatement();
Statement st02 = con.createStatement();
Statement st03 = con.createStatement();
Statement st04 = con.createStatement();
Statement st05 = con.createStatement();
%>

<%
//Instancia um objeto do tipo Resultset para receber o resultado de uma consulta
ResultSet rs = null;
ResultSet rs01 = null;
ResultSet rs02 = null;
ResultSet rs03 = null;
ResultSet rs04 = null;
ResultSet rs05 = null;
%>

<%
//Verifica se foi passado vendaID como parametro via URL
if(request.getParameter("orcamentoID")!=null){
	item.orcamento.orcamentoID = Integer.parseInt(request.getParameter("orcamentoID"));
	orcamento.orcamentoID = Integer.parseInt(request.getParameter("orcamentoID"));
}else{
	response.sendRedirect("sis_menu.jsp");
}
%>

<%
//Usado para formatar Valores
Currency currency = Currency.getInstance("BRL");     
DecimalFormat formato = new DecimalFormat("R$ #,##0.00");
%>

<%
//Pesquisa os itens relacionados ao Orcamento
rs = st.executeQuery(item.listaItensPorID());
%>

<%
//Pesquisa os dados da Empresa para colocar no Cupom
rs01 = st01.executeQuery(empresa.dadosEmpresa());
%>

<%
//Pesquisa dados do Orcamento
rs02 = st02.executeQuery(orcamento.dadosOrcamento());
%>

<%
//Pesquisa o nome do Operador que est� Logado
if(rs02.next()){
	usuario.login = rs02.getString("usuario");
}
rs04 = st04.executeQuery(usuario.usuarioPorLogin());
%>

<%
//Pesquisa dados do Cliente
cliente.clienteID = Integer.parseInt(rs02.getString("clienteID"));

//Variaveis que ir� receber os dados do Cliente
String nome = "";
String cpf = "";

rs05 = st05.executeQuery(cliente.clientePorID());

//Atribui os valores �s variaveis

if(rs05.next()){
	nome = rs05.getString("clienteNomeFantasia");
	cpf = rs05.getString("clienteCnpj");
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Currency"%>
<%@page import="java.text.DecimalFormat"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Imprimir Cupom</title>

<script type="text/javascript">

function imprimirCupom(){
	window.print();
	
	if(confirm("Deseja Voltar para P�gina Anterior?")){
		fechar();	
	}
		
}

function fechar(){
	history.go(-1);	
}

</script>

</head>
<body bgcolor="#EEEEEE" onLoad="javascript: imprimirCupom()">

<div id="cupom" style="background-color:#FFFFFF; width:630px; font-family:Verdana, Geneva, sans-serif; font-size:11px; margin-left:auto; margin-right:auto">

<table width="590" align="center">
<tr bgcolor="#EEEEEE">
  <td height="15" colspan="3" align="center"><font size="6"><strong>O R &Ccedil; A M E N T O</strong></font></td>
</tr>
<%if(rs01.next()){ %>
<tr>
  <td height="20" rowspan="7" align="left" valign="top"><img src="relatorios/images/logo_relatorio.png" border="0" title="Iprimir Relatorio"></td>
  <td height="9" colspan="2" align="center"><strong><%=rs01.getString("nomeFantasia") %></strong></td>
  </tr>
<tr>
  <td height="9" colspan="2" align="left"><%=rs01.getString("rua") %>, <%=rs01.getString("numero") %></td>
  </tr>
<tr>
  <td height="20" colspan="2" align="left"><%=rs01.getString("bairro") %></td>
  </tr>
<tr>
  <td height="20" colspan="2" align="left"><%=rs01.getString("cidade") %> - <%=rs01.getString("uf") %></td>
  </tr>
<tr>
  <td height="20" colspan="2" align="left"><%=rs01.getString("telefone") %></td>
  </tr>
<tr>
  <td height="20" colspan="2" align="left">CNPJ: <%=rs01.getString("cnpj") %></td>
  </tr>
<tr>
  <td height="20" colspan="2" align="left">Insc. Estadual: <%=rs01.getString("inscEstadual") %></td>
  </tr>
<%}%>
<tr>
 <td colspan="3" height="20"></td>
</tr>

<%
String dataSemFormatacao = String.valueOf(rs02.getDate("data"));
String data = formatar.converteDeData(dataSemFormatacao);
%>
<tr>
 <td align="left">N&deg;: <%=rs02.getString("orcamentoID") %></td>
 <td align="center"><%=data %></td>
 <td align="right"><%=rs02.getTime("data") %></td>
</tr>

<tr>
  <td align="left" colspan="3" height="15"></td>
</tr>

<%if(rs04.next()){ %>
<tr>
 <td align="left" colspan="3">Operador: <%=rs04.getString("usuarioNome") %></td>
</tr>
<%} %>


<%
//Verifica se o tem um cliente para esse orcamento
if(nome!= ""){
%>
<tr>
 <td align="left" colspan="3"><hr></td>
</tr>
<tr>
 <td align="left" colspan="3">Cliente: <%=nome %></td>
</tr>
<tr>
 <td align="left" colspan="3"><hr></td>
</tr>
<%} %>

<tr>
 <td align="left" colspan="3" height="30"></td>
</tr>
<tr bgcolor="#CCCCCC">
 <td colspan="3" align="center"><strong>ITENS DO ORCAMENTO</strong></td>
</tr>
<tr>
 <td align="left" colspan="3"><hr></td>
</tr>

<%
//Enquanto n�o for final de arquivo lista os produtos adicionados ao pedido
while(rs.next()){
%>

  <%
    String preco = null;
	String total = null;
          
            
	preco = formato.format(rs.getDouble("valor"));
	total = formato.format(rs.getDouble("total"));
  %>

 <tr>
  <td width="152" align="left"><%=rs.getString("codigo")%></td>
  <td colspan="2" align="left"><%=rs.getString("tipo")%> <%=rs.getString("nome")%></td>
  </tr>
 <tr>
  <td align="left"><%=preco%> <%=rs.getString("unidade")%></td>
  <td width="158" align="left">qtd: <%=rs.getString("quantidade")%></td>
  <td width="159" align="left" bgcolor="#EEEEEE"><strong>total </strong><%=total%></td>
 </tr>
 <tr>
  <td colspan="3" height="15"></td>
 </tr>

<%} %>

<tr>
 <td align="left" colspan="3"><hr></td>
</tr>
<tr>
 <td align="left" colspan="3" height="30"></td>
</tr>

<%
//Declara variaveis para receber valor formatado para Moeda
String total;
String totalParcial;
String desconto;
String pago;
String troco;
String faltaPagar;
%>

<%
//Formata os valores para Moeda e atribui �s variaveis
total = formato.format(rs02.getDouble("valor") + rs02.getDouble("desconto"));
totalParcial = formato.format(rs02.getDouble("valor"));
desconto = formato.format(rs02.getDouble("desconto"));
pago = formato.format(rs02.getDouble("entrada"));
troco = formato.format(rs02.getDouble("troco"));
faltaPagar = formato.format(rs02.getDouble("valor") - rs02.getDouble("entrada"));
%>

<%
//Recupera o ID da Forma de Pagamento e pesquisa o nome
forma.formPagID = rs02.getInt("formPagID");

String formaPagamento = "";

rs03 = st03.executeQuery(forma.formaPorID());

//Verifica se retornou algum resultado e atribui � variavel
if(rs03.next()){
	formaPagamento = rs03.getString("descricao");
}
%>

<tr bgcolor="#33CC66">
 <td colspan="2" align="left"><strong>TOTAL DO ORCAMENTO</strong></td>
 <td align="right"><strong><%=total %></strong></td>
</tr>
<tr>
 <td align="left" colspan="3"><hr></td>
</tr>
<tr>
 <td align="center" height="20" colspan="3"></td>
</tr>
<tr>
 <td align="center" colspan="3">Esse Or&ccedil;amento &eacute; valido por 3 dias. Ap&oacute;s esse prazo estar&aacute; sujeito a altera&ccedil;&atilde;o no valor.</td>
</tr>
<tr>
  <td align="left" colspan="3"><hr></td>
</tr>
<tr>
  <td colspan="3">&nbsp;</td>
</tr>
<tr>
<td colspan="3">
<form>
<input type="button" onClick="fechar()" value="&lt;&lt; Voltar">&nbsp;
<input type="button" onClick="window.print()" value="Imprimir">
</form>
</td>
</tr>
</table>

</div>

</body>
</html>