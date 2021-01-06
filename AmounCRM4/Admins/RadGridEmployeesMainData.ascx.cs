using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Telerik.Web.UI;

namespace AmounCRM4.Admins
{
    public partial class RadGridEmployeesMainData : System.Web.UI.UserControl
    {
        protected void OnItemDataBoundHandler(object sender, GridItemEventArgs e)
        {
            if (e.Item.IsInEditMode)
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                if (!(e.Item is IGridInsertItem))
                {
                    RadComboBox combo = (RadComboBox)item.FindControl("RadComboBox1");
                    RadComboBoxItem selectedItem = new RadComboBoxItem();
                    selectedItem.Text = ((DataRowView)e.Item.DataItem)["CompanyName"].ToString();
                    selectedItem.Value = ((DataRowView)e.Item.DataItem)["SupplierID"].ToString();
                    selectedItem.Attributes.Add("ContactName", ((DataRowView)e.Item.DataItem)["ContactName"].ToString());
                    combo.Items.Add(selectedItem);
                    selectedItem.DataBind();
                    Session["SupplierID"] = selectedItem.Value;
                }
            }
        }

        protected void RadComboBox1_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            string sql = "SELECT [SupplierID], [CompanyName], [ContactName], [City] FROM [Suppliers]  WHERE CompanyName LIKE @CompanyName + '%'";
            SqlDataAdapter adapter = new SqlDataAdapter(sql,
                ConfigurationManager.ConnectionStrings["NorthwindConnectionString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@CompanyName", e.Text);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            RadComboBox comboBox = (RadComboBox)sender;
            // Clear the default Item that has been re-created from ViewState at this point. 
            comboBox.Items.Clear();
            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Text = row["CompanyName"].ToString();
                item.Value = row["SupplierID"].ToString();
                item.Attributes.Add("ContactName", row["ContactName"].ToString());
                comboBox.Items.Add(item);
                item.DataBind();
            }
        }

        protected void OnSelectedIndexChangedHandler(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["SupplierID"] = e.Value;
        }
    }
}