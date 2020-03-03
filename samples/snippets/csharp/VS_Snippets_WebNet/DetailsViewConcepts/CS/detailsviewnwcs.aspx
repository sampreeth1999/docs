<!-- <Snippet1> -->
<%@ Page language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

  void EmployeesDropDownList_OnSelectedIndexChanged(Object sender, EventArgs e)
  {
    EmployeeDetailsView.DataBind();
  }

  void EmployeeDetailsView_ItemUpdated(Object sender, DetailsViewUpdatedEventArgs e)
  {
    EmployeesDropDownList.DataBind();
    EmployeesDropDownList.SelectedValue = e.Keys["EmployeeID"].ToString();
    EmployeeDetailsView.DataBind();
  }
  
  void EmployeeDetailsView_ItemDeleted(Object sender, DetailsViewDeletedEventArgs e)
  {
    EmployeesDropDownList.DataBind();
  }

  void EmployeeDetailsSqlDataSource_OnInserted(Object sender, SqlDataSourceStatusEventArgs e)
  {
    System.Data.Common.DbCommand command = e.Command;   
    EmployeesDropDownList.DataBind();
    EmployeesDropDownList.SelectedValue = 
      command.Parameters["@EmpID"].Value.ToString();
    EmployeeDetailsView.DataBind();
  }

</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
  <head runat="server">
    <title>Northwind Employees</title>
</head>
<body>
    <form id="form1" runat="server">
        
      <h3>Northwind Employees</h3>

        <table cellspacing="10">
            
          <tr>
            <td valign="top">
              <asp:DropDownList ID="EmployeesDropDownList" 
                DataSourceID="EmployeesSqlDataSource" 
                DataValueField="EmployeeID" 
                DataTextField="FullName"
                AutoPostBack="True"
                OnSelectedIndexChanged="EmployeesDropDownList_OnSelectedIndexChanged"
                RunAt="Server" />            
            </td>
                
            <td valign="top">                
              <asp:DetailsView ID="EmployeeDetailsView"
                DataSourceID="EmployeeDetailsSqlDataSource"
                AutoGenerateRows="false"
                AutoGenerateInsertbutton="true"
                AutoGenerateEditbutton="true"
                AutoGenerateDeletebutton="true"
                DataKeyNames="EmployeeID"     
                Gridlines="Both"
                OnItemUpdated="EmployeeDetailsView_ItemUpdated"
                OnItemDeleted="EmployeeDetailsView_ItemDeleted"      
                RunAt="server">
                
                <HeaderStyle backcolor="Navy"
                  forecolor="White"/>
                  
                <RowStyle backcolor="White"/>
                
                <AlternatingRowStyle backcolor="LightGray"/>
                
                <EditRowStyle backcolor="LightCyan"/>
                                    
                <Fields>                  
                  <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" InsertVisible="False" ReadOnly="true"/>                    
                  <asp:BoundField DataField="FirstName"  HeaderText="First Name"/>
                  <asp:BoundField DataField="LastName"   HeaderText="Last Name"/>                    
                  <asp:BoundField DataField="Address"    HeaderText="Address"/>                    
                  <asp:BoundField DataField="City"       HeaderText="City"/>                        
                  <asp:BoundField DataField="Region"     HeaderText="Region"/>
                  <asp:BoundField DataField="PostalCode" HeaderText="Postal Code"/>                    
                </Fields>                    
              </asp:DetailsView>
            </td>                
          </tr>            
        </table>
            
        <asp:SqlDataSource ID="EmployeesSqlDataSource"  
          SelectCommand="SELECT EmployeeID, LastName + ', ' + FirstName AS FullName FROM Employees" 
          Connectionstring="<%$ ConnectionStrings:NorthwindConnection %>" 
          RunAt="server">
        </asp:SqlDataSource>

 
        <asp:SqlDataSource ID="EmployeeDetailsSqlDataSource" 
          SelectCommand="SELECT EmployeeID, LastName, FirstName, Address, City, Region, PostalCode
                         FROM Employees WHERE EmployeeID = @EmpID"

          InsertCommand="INSERT INTO Employees(LastName, FirstName, Address, City, Region, PostalCode)
                         VALUES (@LastName, @FirstName, @Address, @City, @Region, @PostalCode); 
                         SELECT @EmpID = SCOPE_IDENTITY()"

          UpdateCommand="UPDATE Employees SET LastName=@LastName, FirstName=@FirstName, Address=@Address,
                           City=@City, Region=@Region, PostalCode=@PostalCode
                         WHERE EmployeeID=@EmployeeID"

          DeleteCommand="DELETE Employees WHERE EmployeeID=@EmployeeID"

          ConnectionString="<%$ ConnectionStrings:NorthwindConnection %>"
          OnInserted="EmployeeDetailsSqlDataSource_OnInserted"
          RunAt="server">
          
          <SelectParameters>
            <asp:ControlParameter ControlID="EmployeesDropDownList" PropertyName="SelectedValue"
                                  Name="EmpID" Type="Int32" DefaultValue="0" />
          </SelectParameters>
          
          <InsertParameters>
            <asp:Parameter Name="LastName"   Type="String" />
            <asp:Parameter Name="FirstName"  Type="String" />
            <asp:Parameter Name="Address"    Type="String" />
            <asp:Parameter Name="City"       Type="String" />
            <asp:Parameter Name="Region"     Type="String" />
            <asp:Parameter Name="PostalCode" Type="String" />
            <asp:Parameter Name="EmpID" Direction="Output" Type="Int32" DefaultValue="0" />
          </InsertParameters>

          <UpdateParameters>
            <asp:Parameter Name="LastName"   Type="String" />
            <asp:Parameter Name="FirstName"  Type="String" />
            <asp:Parameter Name="Address"    Type="String" />
            <asp:Parameter Name="City"       Type="String" />
            <asp:Parameter Name="Region"     Type="String" />
            <asp:Parameter Name="PostalCode" Type="String" />
            <asp:Parameter Name="EmployeeID" Type="Int32" DefaultValue="0" />
          </UpdateParameters>

          <DeleteParameters>
            <asp:Parameter Name="EmployeeID" Type="Int32" DefaultValue="0" />
          </DeleteParameters>

        </asp:SqlDataSource>
      </form>
  </body>
</html>
<!-- </Snippet1> -->