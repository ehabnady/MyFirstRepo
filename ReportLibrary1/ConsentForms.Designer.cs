namespace ReportLibrary1
{
	partial class ConsentForms
	{
		#region Component Designer generated code
		/// <summary>
		/// Required method for telerik Reporting designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ConsentForms));
            Telerik.Reporting.TableGroup tableGroup1 = new Telerik.Reporting.TableGroup();
            Telerik.Reporting.TableGroup tableGroup2 = new Telerik.Reporting.TableGroup();
            Telerik.Reporting.ReportParameter reportParameter1 = new Telerik.Reporting.ReportParameter();
            Telerik.Reporting.Drawing.StyleRule styleRule1 = new Telerik.Reporting.Drawing.StyleRule();
            this.pageHeaderSection1 = new Telerik.Reporting.PageHeaderSection();
            this.txtFormHeader = new Telerik.Reporting.TextBox();
            this.detail = new Telerik.Reporting.DetailSection();
            this.pictureBox1 = new Telerik.Reporting.PictureBox();
            this.list1 = new Telerik.Reporting.List();
            this.panel1 = new Telerik.Reporting.Panel();
            this.htmlTextBox1 = new Telerik.Reporting.HtmlTextBox();
            this.sqlDataSource1 = new Telerik.Reporting.SqlDataSource();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // pageHeaderSection1
            // 
            this.pageHeaderSection1.Height = Telerik.Reporting.Drawing.Unit.Inch(1D);
            this.pageHeaderSection1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.txtFormHeader,
            this.pictureBox1});
            this.pageHeaderSection1.Name = "pageHeaderSection1";
            // 
            // txtFormHeader
            // 
            this.txtFormHeader.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(1.8D), Telerik.Reporting.Drawing.Unit.Inch(0D));
            this.txtFormHeader.Name = "txtFormHeader";
            this.txtFormHeader.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(4.7D), Telerik.Reporting.Drawing.Unit.Inch(1D));
            this.txtFormHeader.Style.BackgroundColor = System.Drawing.SystemColors.Highlight;
            this.txtFormHeader.Style.Color = System.Drawing.Color.White;
            this.txtFormHeader.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(24D);
            this.txtFormHeader.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.txtFormHeader.Value = "Communication Consent Form";
            // 
            // detail
            // 
            this.detail.Height = Telerik.Reporting.Drawing.Unit.Inch(7.3D);
            this.detail.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.list1});
            this.detail.Name = "detail";
            // 
            // pictureBox1
            // 
            this.pictureBox1.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0D), Telerik.Reporting.Drawing.Unit.Inch(0D));
            this.pictureBox1.MimeType = "image/jpeg";
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.7D), Telerik.Reporting.Drawing.Unit.Inch(1D));
            this.pictureBox1.Sizing = Telerik.Reporting.Drawing.ImageSizeMode.Center;
            this.pictureBox1.Value = ((object)(resources.GetObject("pictureBox1.Value")));
            // 
            // list1
            // 
            this.list1.Body.Columns.Add(new Telerik.Reporting.TableBodyColumn(Telerik.Reporting.Drawing.Unit.Inch(6.326D)));
            this.list1.Body.Rows.Add(new Telerik.Reporting.TableBodyRow(Telerik.Reporting.Drawing.Unit.Inch(6.9D)));
            this.list1.Body.SetCellContent(0, 0, this.panel1);
            tableGroup1.Name = "ColumnGroup";
            this.list1.ColumnGroups.Add(tableGroup1);
            this.list1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.panel1});
            this.list1.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.1D), Telerik.Reporting.Drawing.Unit.Inch(0.1D));
            this.list1.Name = "list1";
            tableGroup2.Groupings.Add(new Telerik.Reporting.Grouping(null));
            tableGroup2.Name = "DetailGroup";
            this.list1.RowGroups.Add(tableGroup2);
            this.list1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(6.326D), Telerik.Reporting.Drawing.Unit.Inch(6.9D));
            // 
            // panel1
            // 
            this.panel1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.htmlTextBox1});
            this.panel1.Name = "panel1";
            this.panel1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(6.326D), Telerik.Reporting.Drawing.Unit.Inch(6.9D));
            // 
            // htmlTextBox1
            // 
            this.htmlTextBox1.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.1D), Telerik.Reporting.Drawing.Unit.Inch(0.1D));
            this.htmlTextBox1.Name = "htmlTextBox1";
            this.htmlTextBox1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(6.1D), Telerik.Reporting.Drawing.Unit.Inch(4.2D));
            this.htmlTextBox1.Value = resources.GetString("htmlTextBox1.Value");
            // 
            // sqlDataSource1
            // 
            this.sqlDataSource1.ConnectionString = "ReportLibrary1.Properties.Settings.AmounCRM2";
            this.sqlDataSource1.Name = "sqlDataSource1";
            this.sqlDataSource1.Parameters.AddRange(new Telerik.Reporting.SqlDataSourceParameter[] {
            new Telerik.Reporting.SqlDataSourceParameter("@param_Region", System.Data.DbType.String, null),
            new Telerik.Reporting.SqlDataSourceParameter("@param_Spec", System.Data.DbType.String, null),
            new Telerik.Reporting.SqlDataSourceParameter("@param_SMS", System.Data.DbType.String, null),
            new Telerik.Reporting.SqlDataSourceParameter("@param_Mail", System.Data.DbType.String, null),
            new Telerik.Reporting.SqlDataSourceParameter("@param_Call", System.Data.DbType.String, null),
            new Telerik.Reporting.SqlDataSourceParameter("@param_MessageApps", System.Data.DbType.String, null)});
            this.sqlDataSource1.SelectCommand = resources.GetString("sqlDataSource1.SelectCommand");
            // 
            // ConsentForms
            // 
            this.DataSource = this.sqlDataSource1;
            this.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.pageHeaderSection1,
            this.detail});
            this.Name = "ConsentForms";
            this.PageSettings.ContinuousPaper = false;
            this.PageSettings.Landscape = false;
            this.PageSettings.Margins = new Telerik.Reporting.Drawing.MarginsU(Telerik.Reporting.Drawing.Unit.Inch(0.5D), Telerik.Reporting.Drawing.Unit.Inch(0.5D), Telerik.Reporting.Drawing.Unit.Inch(0.5D), Telerik.Reporting.Drawing.Unit.Inch(0.5D));
            this.PageSettings.PaperKind = System.Drawing.Printing.PaperKind.A4;
            reportParameter1.Name = "Parameter1";
            this.ReportParameters.Add(reportParameter1);
            styleRule1.Selectors.AddRange(new Telerik.Reporting.Drawing.ISelector[] {
            new Telerik.Reporting.Drawing.TypeSelector(typeof(Telerik.Reporting.TextItemBase)),
            new Telerik.Reporting.Drawing.TypeSelector(typeof(Telerik.Reporting.HtmlTextBox))});
            styleRule1.Style.Padding.Left = Telerik.Reporting.Drawing.Unit.Point(2D);
            styleRule1.Style.Padding.Right = Telerik.Reporting.Drawing.Unit.Point(2D);
            this.StyleSheet.AddRange(new Telerik.Reporting.Drawing.StyleRule[] {
            styleRule1});
            this.Width = Telerik.Reporting.Drawing.Unit.Inch(6.5D);
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

            }
		#endregion
		
		private Telerik.Reporting.PageHeaderSection pageHeaderSection1;
		private Telerik.Reporting.DetailSection detail;
        private Telerik.Reporting.TextBox txtFormHeader;
        private Telerik.Reporting.PictureBox pictureBox1;
        private Telerik.Reporting.List list1;
        private Telerik.Reporting.Panel panel1;
        private Telerik.Reporting.HtmlTextBox htmlTextBox1;
        private Telerik.Reporting.SqlDataSource sqlDataSource1;
    }
}