using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;

using System.Runtime.Serialization.Formatters.Binary;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Security.Cryptography.X509Certificates;
using System.Security;
using System.Xml;
using System.Xml.Serialization;

namespace EduMaterialCertificator
{
    [WebService(Namespace = "http://edumaterialcertifcator.net/gradescertifier")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class GradesCertifier : System.Web.Services.WebService
    {
        [WebMethod]
        [SoapDocumentMethod(ParameterStyle = SoapParameterStyle.Bare)]
        public string SignGrades(GradesPublication publication) {
            try {
                byte[] dataBytes = null;

                //serializing the data object representation to xml
                XmlSerializerNamespaces ns = new XmlSerializerNamespaces();
                ns.Add("xsd", "http://edumaterialcertifcator.net/gradescertifier");
                XmlSerializer xs = new XmlSerializer(typeof(GradesPublication));

                using (MemoryStream memForData = new MemoryStream()) {
                    //using (FileStream fs = new FileStream(HttpContext.Current.Request.PhysicalApplicationPath + DateTime.Now.Ticks + ".xml", FileMode.CreateNew)) {
                    //    xs.Serialize(fs, publication, ns);
                    //    fs.Flush();
                    //}

                    xs.Serialize(memForData, publication, ns);
                    
                    //bytes of the xml data representation
                    dataBytes = memForData.ToArray();
                }

                byte[] sha1Hash = null;
                using (SHA1CryptoServiceProvider sha = new SHA1CryptoServiceProvider()) {
                    sha1Hash = sha.ComputeHash(dataBytes);
                }

                //acquiring private key certificate from keystore
                X509Certificate2 keyCertificate = LoadPrivateKeyCert();

                //signing the merged hashes
                byte[] signedHash = null;
                using (RSACryptoServiceProvider rsa = (RSACryptoServiceProvider)keyCertificate.PrivateKey) {
                    signedHash = rsa.SignHash(sha1Hash, CryptoConfig.MapNameToOID("SHA-512"));
                }

                //return of signed data base64 representation
                return Convert.ToBase64String(signedHash);
            }
            catch (Exception ex) {
                return ex.GetType().FullName + " - " + ex.Message + " -->> " + ex.StackTrace;
            }
        }

        private X509Certificate2 LoadPrivateKeyCert() {
            string keyCertificateDN = Properties.Settings.Default.CertificateDN;

            X509Store personal = new X509Store(StoreName.My, StoreLocation.LocalMachine);
            personal.Open(OpenFlags.ReadOnly);

            foreach (X509Certificate2 cert in personal.Certificates)
                if (cert.IssuerName.Name.Equals(keyCertificateDN, StringComparison.InvariantCultureIgnoreCase))
                    return cert;

            personal.Close();
            return null;
        }
    }
}