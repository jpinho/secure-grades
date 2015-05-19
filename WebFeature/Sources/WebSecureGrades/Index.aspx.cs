using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Security.Cryptography.X509Certificates;
using System.Web.Services.Protocols;

namespace WebSecureGrades
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) {
            new Class1();

            if (!IsPostBack && Session.Count > 0) {
                //clean session vars on page load
                Session.Remove("publication-object");
                Session.Remove("signed-data");
            }
        }

        [WebMethod]
        public static object SubmitGrades(string campus, string course, string classe, string evaluation, string[][] grades) 
        {
            GradesCertificator.GradesPublication publication = new GradesCertificator.GradesPublication();

            publication.Campus = campus;
            publication.Class = classe;
            publication.Course = course;
            publication.EvaluationType = evaluation;
            List<GradesCertificator.StudentEvaluation> evals = new List<GradesCertificator.StudentEvaluation>();

            foreach (string[] grade in grades) {
                int studentID = 0;
                double score = 0;

                Int32.TryParse(grade[0], out studentID);
                Double.TryParse(grade[2], out score);

                evals.Add(new GradesCertificator.StudentEvaluation() {
                    StudentID = studentID, 
                    Score = score
                });
            }

            publication.Evaluations = evals.ToArray();
            string signature = string.Empty;
            
            try {
                GradesCertificator.GradesCertifier proxyWS = new GradesCertificator.GradesCertifier();
                signature = proxyWS.SignGrades(publication);

                //persist state to current session
                HttpContext.Current.Session["publication-object"] = publication;
                HttpContext.Current.Session["signed-data"] = signature;
            }
            catch(Exception ex) { throw ex; }
            
            return new { signedData = signature };
        }

        [WebMethod]
        public static object PublishGrades() {
            GradesCertificator.GradesPublication publication = 
                HttpContext.Current.Session["publication-object"] as GradesCertificator.GradesPublication;

            string signedDataB64 = HttpContext.Current.Session["signed-data"] as string;

            if (publication == null || signedDataB64 == null)
                throw new InvalidOperationException("Os dados de sessão relativos à sua publicação expiraram, por favor tente novamente!");

            GradesPublisher.publication pub = new GradesPublisher.publication();
            pub.Campus = publication.Campus;
            pub.Class = publication.Class;
            pub.Course = publication.Course;
            pub.EvaluationType = publication.EvaluationType;
            pub.ProfessorID = Convert.ToUInt32(publication.ProfessorID);
            
            List<GradesPublisher.ArrayOfGradesPublicationStudentEvaluationStudentEvaluation> evaluations = 
                new List<GradesPublisher.ArrayOfGradesPublicationStudentEvaluationStudentEvaluation>();

            foreach (GradesCertificator.StudentEvaluation eval in publication.Evaluations) {
                evaluations.Add(new GradesPublisher.ArrayOfGradesPublicationStudentEvaluationStudentEvaluation() { 
                    StudentID = Convert.ToUInt32(eval.StudentID),
                    Score = eval.Score
                });          
            }

            pub.Evaluations = evaluations.ToArray();

            string response = string.Empty;

            try {
                GradesPublisher.GradesPublisher proxyWS = new GradesPublisher.GradesPublisher();
                proxyWS.Url = "https://sauron:44301/gradespublisher.asmx";
                SetSSLEnabled(proxyWS);
                proxyWS.TokenValue = new GradesPublisher.Token() { CertificateToken = proxyWS.ClientCertificates[0].GetCertHashString() };
                response = proxyWS.PublishGrades(pub, signedDataB64);
            }
            catch (Exception ex) { throw ex; }

            return response;
        }

        private static void SetSSLEnabled(SoapHttpClientProtocol ws) {
            X509Certificate2 certificate = GetPublicKey();
            if (certificate == null) throw new InvalidOperationException("Client Certificate is missing!");

            ws.ClientCertificates.Clear();
            ws.ClientCertificates.Add(certificate);
        }

        private static X509Certificate2 GetPublicKey() {
            string keyCertificateDN = Properties.Settings.Default.PublicKeyCertificateDN;

            X509Store store = new X509Store(StoreName.Root, StoreLocation.LocalMachine);
            store.Open(OpenFlags.ReadOnly);

            foreach (X509Certificate2 cert in store.Certificates)
                if (cert.IssuerName.Name.Equals(keyCertificateDN, StringComparison.InvariantCultureIgnoreCase))
                    return cert;

            store.Close();
            return null;
        }
    }
}