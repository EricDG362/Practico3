using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Practico3
{
    public partial class Cuentas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                mostrar();
            }


        }
        //muestra en una label lo que tengo en la base
        protected void mostrar()
        {
            String cadenaConexion = System.Configuration.ConfigurationManager.ConnectionStrings["CONEX3"].ConnectionString;
            SqlConnection conexion = new SqlConnection(cadenaConexion);
            conexion.Open();

            String consultas = $"select descripcion from Cuentas";

            SqlCommand comando = new SqlCommand(consultas, conexion);
            SqlDataReader registro = comando.ExecuteReader();

            if (registro.Read())
            {
                Label2.Text = registro["descripcion"].ToString() + " - ";

            }

            conexion.Close();

        }

        //inserta un elemneto en la base
        protected void Button1_Click(object sender, EventArgs e)
        {

           int resultado= sql1.Insert();
            if (resultado != 0)
            {
                Label1.Text = "Registro Exitoso";
                mostrar();
            }
            else
            {
                Label1.Text = "Error al Registrar";
            }
        }
        //me trae al textbox 2 lo q selecciono en el listbox
        protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            SqlDataSource1.DataSourceMode = SqlDataSourceMode.DataReader;
            SqlDataReader reader = (SqlDataReader)SqlDataSource1.Select(DataSourceSelectArguments.Empty);

            if (reader.Read())
            {

                TextBox2.Text = reader["descripcion"].ToString();
            }


        }

        protected void Button2_Click(object sender, EventArgs e)
        {


            try
            {

                int resultado = sql1.Delete();
                if (resultado != 0)
                {
                    Label1.Text = "Eliminacion Exitosa";
                    mostrar();
                }
                else
                {
                    Label1.Text = "Error al Eliminar";
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", $"alert('Error');", true);
            }
        }

            //modifica los valores
            protected void Button3_Click(object sender, EventArgs e)
        {
            sql1.UpdateParameters["id"].DefaultValue = ListBox1.SelectedValue.ToString();
            sql1.UpdateParameters["descripcion"].DefaultValue = TextBox2.Text;
            int resultado = sql1.Update();
            if (resultado != 0)
            {
                Label1.Text = "Modificacion Exitosa";
                mostrar();
            }
            else
            {
                Label1.Text = "Error al Modificar";
            }


        }
    }
}