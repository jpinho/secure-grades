using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.IO;
using System.Xml;
using System.Xml.Serialization;
using System.Security;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;

namespace EduGradesPublisher.DataModel
{
    public class ModelHelper
    {
        public static bool IsValidSignature(GradesPublication publication, string signature) {
            byte[] dataBytes = null;

            XmlSerializerNamespaces ns = new XmlSerializerNamespaces();
            ns.Add("xsd", "http://edumaterialcertifcator.net/gradescertifier");
            XmlSerializer xs = new XmlSerializer(typeof(GradesPublication));

            using (MemoryStream memStream = new MemoryStream()) {
                //using (FileStream fs = new FileStream(HttpContext.Current.Request.PhysicalApplicationPath + DateTime.Now.Ticks + ".xml", FileMode.CreateNew)) {
                //    xs.Serialize(fs, publication, ns);
                //    fs.Flush();
                //}

                xs.Serialize(memStream, publication, ns);

                //get xml data representation in bytes
                dataBytes = memStream.ToArray();
            }

            byte[] sha1Hash = null;
            using (SHA1CryptoServiceProvider sha = new SHA1CryptoServiceProvider()) {
                sha1Hash = sha.ComputeHash(dataBytes);
            }

            //acquiring public key certificate from keystore
            X509Certificate2 publicKeyCert = LoadPublicKeyCert();

            //getting the pieces necessary to perform signature check
            byte[] signedHash = Convert.FromBase64String(signature);
            bool dataValid = false;

            using (RSACryptoServiceProvider rsa = (RSACryptoServiceProvider)publicKeyCert.PublicKey.Key) {
                dataValid = rsa.VerifyHash(sha1Hash, CryptoConfig.MapNameToOID("SHA-512"), signedHash);
            }

            return dataValid;
        }

        public static X509Certificate2 LoadPublicKeyCert() {
            string keyCertificateDN = Properties.Settings.Default.PublicKeyCertificateDN;

            X509Store store = new X509Store(StoreName.Root, StoreLocation.LocalMachine);
            store.Open(OpenFlags.ReadOnly);

            foreach (X509Certificate2 cert in store.Certificates)
                if (cert.IssuerName.Name.Equals(keyCertificateDN, StringComparison.InvariantCultureIgnoreCase))
                    return cert;

            store.Close();
            return null;
        }

        public static void Save(GradesPublication publication, string signature) {
            using (Entities model = new Entities()) {

                Publication newPub = model.Publication.Add(new Publication() {
                    Campus = publication.Campus,
                    Class = publication.Class,
                    Course = publication.Course,
                    EvaluationType = publication.EvaluationType,
                    ProfessorID = Convert.ToInt32(publication.ProfessorID),
                    Signature = signature,
                });

                foreach (GradesPublicationStudentEvaluation eval in publication.Evaluations)
                    model.StudentScore.Add(new StudentScore() {
                        Publication = newPub,
                        StudentID = Convert.ToInt32(eval.StudentID),
                        Score = eval.Score
                    });

                model.SaveChanges();
            }
        }
    }
}