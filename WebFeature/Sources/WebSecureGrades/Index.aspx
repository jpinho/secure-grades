<%@ Page Title="Home" Language="C#" MasterPageFile="~/SecureGrades.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="WebSecureGrades.Index" %>

<asp:Content ID="IndexBody" ContentPlaceHolderID="ContentBody" runat="server">
    <div id="gradesBoard">
        <h1 style="font-weight: bold;">Submissão de Notas</h1>
        <br />
        <br />

        <div id="content">
            <table class="filter" border="0" cellpadding="5" cellspacing="0">
                <tr>
                    <td>Campus:</td>
                    <td>
                        <select id="ddlCampus">
                            <option>TagusPark</option>
                            <option>Alameda</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Curso:</td>
                    <td>
                        <select id="ddlCurso">
                            <option>LEE</option>
                            <option>LEIC</option>
                            <option>LERC</option>
                            <option>MEIC</option>
                            <option>MERC</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Cadeira:</td>
                    <td>
                        <select id="ddlClass">
                            <option>BD</option>
                            <option>SIRS</option>
                            <option>ASA</option>
                            <option>PGRI</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Avaliação:</td>
                    <td>
                        <select id="ddlEvaluationType">
                            <option>Teste 1</option>
                            <option>Teste 2</option>
                            <option>Exame</option>
                            <option>Projecto</option>
                        </select>
                    </td>
                </tr>
            </table>

            <% 
                string[][] students = new string[5][]{
                  new string[]{"66047", "João Pedro Rocha Pinho",	 "LEIC-T 2006"}
                , new string[]{"66998", "Hugo Miguel Vieira Gonçalves",  "MEIC-T 2006"}
                , new string[]{"67073", "Rita Marques Tomé",  "MEIC-T 2006"}
                , new string[]{"68121", "Andreia Filipa Caseiro dos Santos",  "MEIC-T 2006"}
                , new string[]{"68135", "Diogo Manuel Gomes Alves",  "LEIC-T 2006"}
            };     
            %>

            <table class="table grades" width="100%" border="1" cellpadding="5" cellspacing="0" style="width: 100%; margin-top: 30px;">
                <thead>
                    <tr>
                        <td width="40px">N.º</td>
                        <td>Aluno</td>
                        <td width="200px">Turma</td>
                        <td width="20px">Nota</td>
                    </tr>
                </thead>
                <tbody>
                    <% foreach (string[] student in students) { %>
                    <tr class="grade-row">
                        <td class="student-id"><%= student[0] %></td>
                        <td class="student-name"><%= student[1] %></td>
                        <td class="student-class"><%= student[2] %></td>
                        <td class="student-grade">
                            <input type="text" maxlength="2" onkeyup="javascript: return validGradesOnly.call(this);" /></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div id="messageBox" class="alert alert-success" style="display: none;">
        </div>

        <div class="progress progress-striped active" style="display: none;">
            <div class="progress-bar" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 45%">
                <span class="sr-only">45% Complete</span>
            </div>
        </div>

        <div id="confirmBox" style="text-align: right; display: none; height: 30px;">
            <div class="text" style="display: inline; margin-right: 15px;">Confirma o envio das notas para o Sistema de Publicação?</div>
            <a id="lbConfirmYes" class="btn btn-success btn-sm active" role="button">Sim</a>
            <a id="lbConfirmNo" class="btn btn-danger btn-sm active" role="button">Não</a>
        </div>

        <div style="text-align: right;">
            <a id="lbSubmitGrades" class="btn btn-default btn-sm active" role="button" onclick="submitGrades();">Publicar Pauta</a>
        </div>
    </div>
</asp:Content>
