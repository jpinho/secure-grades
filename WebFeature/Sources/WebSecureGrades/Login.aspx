<%@ Page Title="Login" Language="C#" MasterPageFile="~/SecureGrades.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebSecureGrades.Login" %>

<asp:Content ID="LoginBody" ContentPlaceHolderID="ContentBody" runat="server">
    <div style="width: 360px; margin: 0 auto; margin-top: 50px; border: 1px solid #333; padding: 20px 30px;">
        <asp:Login ID="lgBoard" runat="server" Height="130px" Width="300px">
            <LayoutTemplate>
                <table cellpadding="1" cellspacing="0" style="border-collapse: collapse;">
                    <tr>
                        <td>
                            <table cellpadding="4" style="height: 132px; width: 303px;">
                                <tr>
                                    <td align="center" colspan="2">
                                        <span style="font-weight:bold;">SISTEMA DE PUBLICAÇÃO</span>
                                        <br />
                                        <br /><br />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                                        &nbsp;&nbsp; </td>
                                    <td>
                                        <asp:TextBox ID="UserName" runat="server" Width="180px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="lgBoard">*</asp:RequiredFieldValidator>
                                        <br />
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                        &nbsp;&nbsp; </td>
                                    <td>
                                        <asp:TextBox ID="Password" runat="server" TextMode="Password" Width="180px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="lgBoard">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" style="color: Red;">
                                        <br />
                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2" style="padding-right: 38px;">
                                        <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In" ValidationGroup="lgBoard" CssClass="btn btn-default" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
        </asp:Login>
    </div>
</asp:Content>
