using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace EduMaterialCertificator
{
    [Serializable]
    [XmlRoot(ElementName = "StudentEvaluation")]
    public class StudentEvaluation
    {
        [XmlElement(ElementName = "StudentID")]
        public int StudentID { get; set; }

        [XmlIgnore]
        public string Name { get; set; }

        [XmlElement(ElementName = "Score")]
        public double Score { get; set; }
    }
}