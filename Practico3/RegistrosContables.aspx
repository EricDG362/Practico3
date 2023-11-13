<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrosContables.aspx.cs" Inherits="Practico3.RegistrosContables" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
           
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Menu.aspx">VOLVER</asp:HyperLink>
           
            <br />
             INGRESE PRECIO: 
            <asp:TextBox ID="txtprecio" runat="server"></asp:TextBox>






            <asp:DropDownList ID="ddCuenta" runat="server" DataSourceID="LISTCUENTA" DataTextField="descripcion" DataValueField="id">
            </asp:DropDownList>
            <asp:DropDownList ID="ddlTIpo" runat="server">
                <asp:ListItem Value="0">Debe</asp:ListItem>
                <asp:ListItem Value="1">Haber</asp:ListItem>
            </asp:DropDownList>
            
            <asp:Button ID="Button1" runat="server" Text="AGREGAR" OnClick="Button1_Click" Height="49px" />
            <asp:Button ID="Button3" runat="server" Height="49px" OnClick="Button3_Click1" Text="MODIFICAR" />
            <br />


        <br />
        <asp:Label ID="Label1" runat="server" Text="*ESTADO*"></asp:Label>

            <br />
            <br />
            <asp:DropDownList ID="ddRegistro" runat="server" AutoPostBack="True" DataSourceID="CRUD" DataTextField="id" DataValueField="id" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="ELIMINAR" Width="133px" />

            <br />
            <br />
            <asp:Table ID="Table1" runat="server" Width="657px">
            </asp:Table>
            <br />
            <br />
            <br />

            <br />
            <asp:SqlDataSource ID="LISTCUENTA" runat="server" ConnectionString="<%$ ConnectionStrings:CONEX3 %>" SelectCommand="SELECT * FROM [Cuentas]"></asp:SqlDataSource>
        </div>
        
        <asp:SqlDataSource ID="CRUD" runat="server" ConnectionString="<%$ ConnectionStrings:CONEX3 %>" DeleteCommand="DELETE FROM [RegistrosContables] WHERE [id] = @id" InsertCommand="INSERT INTO [RegistrosContables] ([idCuenta], [monto], [tipo]) VALUES (@idCuenta, @monto, @tipo)" SelectCommand="SELECT * FROM [RegistrosContables]" UpdateCommand="UPDATE [RegistrosContables] SET [idCuenta] = @idCuenta, [monto] = @monto, [tipo] = @tipo WHERE [id] = @id">
            <DeleteParameters>
                <asp:ControlParameter ControlID="ddRegistro" Name="id" PropertyName="SelectedValue" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="ddCuenta" Name="idCuenta" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="txtprecio" Name="monto" PropertyName="Text" Type="Int32" />
                <asp:ControlParameter ControlID="ddlTIpo" Name="tipo" PropertyName="SelectedValue" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="ddCuenta" Name="idCuenta" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="txtprecio" Name="monto" PropertyName="Text" Type="Int32" />
                <asp:ControlParameter ControlID="ddlTIpo" Name="tipo" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="ddRegistro" Name="id" PropertyName="SelectedValue" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        
        <asp:SqlDataSource ID="TABLASQLDATA" runat="server" ConnectionString="<%$ ConnectionStrings:CONEX3 %>" SelectCommand="SELECT RegistrosContables.id, RegistrosContables.monto, 
case when RegistrosContables.tipo = 0 then 'Debe' else 'Haber' end tipo, Cuentas.descripcion 
FROM RegistrosContables INNER JOIN Cuentas ON RegistrosContables.idCuenta = Cuentas.id"></asp:SqlDataSource>
        
    </form>
</body>
</html>
