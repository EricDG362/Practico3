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
    public partial class RegistrosContables : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                completarTabla(); 
            }

        }

        protected void completarTabla()
        {
            try
            {
                DataView dv = (DataView)TABLASQLDATA.Select(DataSourceSelectArguments.Empty);

                if(dv !=null && dv.Count > 0){

                    //titulos
                    TableRow headerRow = new TableRow();

                    TableCell headerCell3 = new TableCell();
                    headerCell3.Text = "Id";
                    headerRow.Cells.Add(headerCell3);

                    TableCell headerCell = new TableCell();
                    headerCell.Text = "Descripcion";
                    headerRow.Cells.Add(headerCell);

                    TableCell headerCell1 = new TableCell();
                    headerCell1.Text = "Monto";
                    headerRow.Cells.Add(headerCell1);

                    TableCell headerCell2 = new TableCell();
                    headerCell2.Text = "Tipo";
                    headerRow.Cells.Add(headerCell2);

                    Table1.Rows.Add(headerRow);

                    //llenado
                    foreach(DataRowView rowView in dv)
                    {
                        DataRow row = rowView.Row;
                        TableRow tableRow = new TableRow();

                        TableCell Cell4 = new TableCell();
                        Cell4.Text = row["id"].ToString();
                        tableRow.Cells.Add(Cell4);

                        TableCell Cell1 = new TableCell();
                        Cell1.Text = row ["Descripcion"].ToString();
                        tableRow.Cells.Add(Cell1);

                        TableCell Cell2 = new TableCell();
                        Cell2.Text = row["monto"].ToString();
                        tableRow.Cells.Add(Cell2);

                        TableCell Cell3 = new TableCell();
                        Cell3.Text = row["tipo"].ToString();
                        tableRow.Cells.Add(Cell3);

                        Table1.Rows.Add(tableRow);


                    }




                }

            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", $"alert('Error');", true);
            }
            
            
            


        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int resultado = CRUD.Insert();
            if (resultado != 0)
            {
                Label1.Text = "Registro Exitoso";
                completarTabla();
                txtprecio.Text = String.Empty;
                
            }
            else
            {
                Label1.Text = "Error al Registrar";
            }
        }
        private void LlenarDatos()
        {
            string Conexion = System.Configuration.ConfigurationManager.ConnectionStrings["CONEX3"].ConnectionString;
            SqlConnection con = new SqlConnection(Conexion);
            con.Open();
            SqlCommand c = new SqlCommand(@"select idCuenta, monto, tipo from RegistrosContables where id = @id", con);
            c.CommandType = CommandType.Text;
            c.Parameters.AddWithValue("@id", ddRegistro.SelectedValue);
            SqlDataReader reader = c.ExecuteReader();

            if (reader.Read())
            {
                txtprecio.Text = reader["monto"].ToString();
                ddCuenta.SelectedValue = reader["idCuenta"].ToString();
                if (Convert.ToBoolean(reader["tipo"].ToString()) == false) ddlTIpo.SelectedValue = "0";
                else ddlTIpo.SelectedValue = "1";



            }
            reader.Close();
            con.Close();

        }
        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            //DataView dv = (DataView)CRUD.Select(DataSourceSelectArguments.Empty);
            //if (dv != null && dv.Count > 0)
            //{
            //    DataRowView row = dv[0];
            //    txtprecio.Text = row["monto"].ToString();
            //    ddCuenta.SelectedValue = row["id"].ToString();
            //    listTipo.Text = row["tipo"].ToString();
            //}
            LlenarDatos();
            completarTabla();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            int resultado = CRUD.Delete();
            if (resultado != 0)
            {
                Label1.Text = "Eliminado";
                completarTabla();
                txtprecio.Text = String.Empty;

            }
            else
            {
                Label1.Text = "Error al Eliminar";
            }
        }
        //modifica los registros
        protected void Button3_Click(object sender, EventArgs e)
        {
            int resultado = CRUD.Update();
            if (resultado != 0)
            {
                Label1.Text = "Modificado";
                completarTabla();
                txtprecio.Text = String.Empty;

            }
            else
            {
                Label1.Text = "Error al Modificar";
            }
        }

        protected void Button3_Click1(object sender, EventArgs e)
        {
            CRUD.Update();
            completarTabla();
        }
    }
}