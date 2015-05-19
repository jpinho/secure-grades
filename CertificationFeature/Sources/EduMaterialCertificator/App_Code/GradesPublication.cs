using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace EduMaterialCertificator
{
    [Serializable]
    [XmlRoot(ElementName = "GradesPublication")]
    public class GradesPublication
    {
        [XmlElement(ElementName = "ProfessorID")]
        public int ProfessorID { get; set; }

        [XmlElement(ElementName = "Campus")]
        public string Campus { get; set; }

        [XmlElement(ElementName = "Course")]
        public string Course { get; set; }

        [XmlElement(ElementName = "Class")]
        public string Class { get; set; }

        [XmlElement(ElementName = "EvaluationType")]
        public string EvaluationType { get; set; }

        [XmlArray(ElementName = "Evaluations")]
        public List<StudentEvaluation> Evaluations { get; set; }
    }
}