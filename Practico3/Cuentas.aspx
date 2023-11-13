<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cuentas.aspx.cs" Inherits="Practico3.Cuentas" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Menu.aspx">VOLVER</asp:HyperLink>
            <br />
            <br />


            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="AGREGAR" />
            <br />
            <asp:Label ID="Label1" runat="server" Text="*ESTADO*"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="*CUENTAS*"></asp:Label>
            <br />
            <br />
            <asp:ListBox ID="ListBox1" runat="server" AutoPostBack="True" DataSourceID="sql1" DataTextField="descripcion" DataValueField="id" Height="121px" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged"></asp:ListBox>
            <br />
            <br />
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="ELIMINAR" />
            <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="MODIFICAR" />
            <br />
            <br />
            <br />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CONEX3 %>" SelectCommand="SELECT * FROM [Cuentas] WHERE ([id] = @id)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ListBox1" Name="id" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <br />

            <asp:SqlDataSource ID="sql1" runat="server" ConnectionString="<%$ ConnectionStrings:CONEX3 %>" DeleteCommand="DELETE FROM [Cuentas] WHERE [id] = @id" InsertCommand="INSERT INTO [Cuentas] ([descripcion]) VALUES (@descripcion)" SelectCommand="SELECT * FROM [Cuentas]" UpdateCommand="UPDATE [Cuentas] SET [descripcion] = @descripcion WHERE [id] = @id">
                <DeleteParameters>
                    <asp:ControlParameter ControlID="ListBox1" Name="id" PropertyName="SelectedValue" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="TextBox1" Name="descripcion" PropertyName="Text" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="descripcion" Type="String" />
                    <asp:Parameter Name="id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        
        
        
        
        
        </div>
    </form>
</body>
</html>
