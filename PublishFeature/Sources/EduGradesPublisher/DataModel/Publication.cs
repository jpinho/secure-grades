//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EduGradesPublisher.DataModel
{
    using System;
    using System.Collections.Generic;
    
    public partial class Publication
    {
        public Publication()
        {
            this.StudentScore = new HashSet<StudentScore>();
        }
    
        public int ID { get; set; }
        public int ProfessorID { get; set; }
        public string Campus { get; set; }
        public string Course { get; set; }
        public string Class { get; set; }
        public string EvaluationType { get; set; }
        public string Signature { get; set; }
    
        public virtual ICollection<StudentScore> StudentScore { get; set; }
    }
}
