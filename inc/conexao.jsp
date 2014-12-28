<%
Connection con = null;
Statement st = null;

//CONEXAO PARA HOSPEDAGEM
//Class.forName("org.gjt.mm.mysql.Driver");
//con = DriverManager.getConnection("jdbc:mysql://mysql.fortesystem.net.br/fortesystem02", "fortesystem02", "tonmaior123");
//st=con.createStatement();


//CONEXAO PARA PC-ALMIR
Class.forName("org.gjt.mm.mysql.Driver");
con=DriverManager.getConnection("jdbc:mysql://localhost/tonmaior","root","");
st=con.createStatement();

%>