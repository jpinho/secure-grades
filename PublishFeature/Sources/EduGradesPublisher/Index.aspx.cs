using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EduGradesPublisher
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) {

        }

        protected void lbSearch_Click(object sender, EventArgs e) {
            sdsPublications.DataBind();
            gvPublications.DataBind();
        }
    }
}