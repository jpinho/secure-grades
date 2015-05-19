<%@ Page Title="Home" Language="C#" MasterPageFile="~/GradesPublisher.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="EduGradesPublisher.Index" %>

<asp:Content ID="IndexBody" ContentPlaceHolderID="ContentBody" runat="server">
    <div id="gradesBoard">
        <h1 style="font-weight: bold;">Visualização de Pautas Online</h1>
        <br />
        <br />

        <div id="content">
            <table class="filter" border="0" cellpadding="5" cellspacing="0">
                <tr>
                    <td>Campus:</td>
                    <td>
                        <asp:DropDownList ID="ddlCampus" runat="server">
                            <asp:ListItem>TagusPark</asp:ListItem>
                            <asp:ListItem>Alameda</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Curso:</td>
                    <td>
                        <asp:DropDownList ID="ddlCurso" runat="server">
                            <asp:ListItem>LEE</asp:ListItem>
                            <asp:ListItem>LEIC</asp:ListItem>
                            <asp:ListItem>LERC</asp:ListItem>
                            <asp:ListItem>MEIC</asp:ListItem>
                            <asp:ListItem>MERC</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Cadeira:</td>
                    <td>
                        <asp:DropDownList ID="ddlClass" runat="server">
                            <asp:ListItem>BD</asp:ListItem>
                            <asp:ListItem>SIRS</asp:ListItem>
                            <asp:ListItem>ASA</asp:ListItem>
                            <asp:ListItem>PGRI</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Avaliação:</td>
                    <td>
                        <asp:DropDownList ID="ddlEvaluationType" runat="server">
                            <asp:ListItem>Teste 1</asp:ListItem>
                            <asp:ListItem>Teste 2</asp:ListItem>
                            <asp:ListItem>Exame</asp:ListItem>
                            <asp:ListItem>Projecto</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <br />
            <asp:LinkButton ID="lbSearch" runat="server" CssClass="btn btn-default btn-sm active" OnClick="lbSearch_Click">Pesquisar</asp:LinkButton>

            <br />
            <br />
            <br />
            <br />

            <span style="font-weight: bold">Publicações</span><br /><br />
            <asp:GridView ID="gvPublications" runat="server" CssClass="table table-hover" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="sdsPublications" Width="100%">
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" InsertVisible="False" />
                    <asp:BoundField DataField="ProfessorID" HeaderText="ProfessorID" SortExpression="ProfessorID" />
                    <asp:BoundField DataField="Campus" HeaderText="Campus" SortExpression="Campus" />
                    <asp:BoundField DataField="Course" HeaderText="Course" SortExpression="Course" />
                    <asp:BoundField DataField="Class" HeaderText="Class" SortExpression="Class" />
                    <asp:BoundField DataField="EvaluationType" HeaderText="EvaluationType" SortExpression="EvaluationType" />
                    <asp:CommandField SelectText="Ver Notas" ShowSelectButton="True" />
                </Columns>
                <EmptyDataTemplate>
                    Não existem publicações de pautas para os parâmetros definidos!
                </EmptyDataTemplate>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>

            <br />
            <span style="font-weight: bold; <%= gvStudentScores.Rows.Count == 0 ? "display:none;" : string.Empty %>">Classificações</span><br /><br />
            <asp:GridView ID="gvStudentScores" runat="server" CssClass="table table-hover" AutoGenerateColumns="False" DataKeyNames="PublicationID,StudentID" DataSourceID="sdsStudentScores" Width="100%">
                <Columns>
                    <asp:BoundField DataField="PublicationID" HeaderText="PublicationID" ReadOnly="True" SortExpression="PublicationID">
                        <HeaderStyle Width="20px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="StudentID" HeaderText="StudentID" ReadOnly="True" SortExpression="StudentID" />
                    <asp:BoundField DataField="Score" HeaderText="Score" SortExpression="Score" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsPublications" runat="server" ConnectionString="Data Source=SAURON\SQLDEV2012;Initial Catalog=PublishedGrades;Integrated Security=True;MultipleActiveResultSets=True;Application Name=EntityFramework" ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [Publication] WHERE (([Campus] = @Campus) AND ([Class] = @Class) AND ([Course] = @Course) AND ([EvaluationType] = @EvaluationType))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlCampus" Name="Campus" PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="ddlClass" Name="Class" PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="ddlCurso" Name="Course" PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="ddlEvaluationType" Name="EvaluationType" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sdsStudentScores" runat="server" ConnectionString="Data Source=SAURON\SQLDEV2012;Initial Catalog=PublishedGrades;Integrated Security=True;MultipleActiveResultSets=True;Application Name=EntityFramework" ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [StudentScore] WHERE ([PublicationID] = @PublicationID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvPublications" Name="PublicationID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
