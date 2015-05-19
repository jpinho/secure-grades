using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

using System.IO;
using System.Xml;
using System.Xml.Serialization;
using System.Security;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using EduGradesPublisher.DataModel;
using System.Web.Services.Protocols;
using System.Net;

namespace EduGradesPublisher
{
    [WebService(Namespace = "http://edugradespublisher.net/gradespublisher")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class GradesPublisher : System.Web.Services.WebService
    {
        public class Token: SoapHeader{
            public string CertificateToken;
        }

        public Token AuthenticationToken;

        [SoapHeader("AuthenticationToken", Required=true)]
        [WebMethod]
        public string PublishGrades(GradesPublication publication, string signature) {
            if (!HttpContext.Current.Request.IsSecureConnection || !ValidClientCertificate())
                throw new HttpException((int)(HttpStatusCode.BadRequest),
                    "Access as been denied, bad certificate! This incident will be reported");
           
            try {
                bool dataValid = ModelHelper.IsValidSignature(publication, signature);
                string response = string.Empty;

                if (dataValid) {
                    ModelHelper.Save(publication, signature);
                    response = "Pauta publicada com sucesso, após validação da assinatura digital!";
                }
                else throw new InvalidOperationException(
                    "A publicação da pauta foi anulada, a assinatura digital não corresponde aos dados recebidos!");

                return response;
            }
            catch (Exception ex) {
                return ex.GetType().FullName + " - " + ex.Message + " -->> " + ex.StackTrace;
            }
        }

        private bool ValidClientCertificate() {
            var x509 = new X509Certificate2(HttpContext.Current.Request.ClientCertificate.Certificate);
            X509Certificate2 publicKeyCert = ModelHelper.LoadPublicKeyCert();
            return publicKeyCert.GetCertHashString().Equals(AuthenticationToken.CertificateToken);
        }
    }
}