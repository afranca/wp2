using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MvcGCUImagesStarter.Models
{
    public class Contributor
    {
        public string contributorName;
        public IEnumerable<Image> contributorImages;

        public Contributor(string p_1)
        {
            this.contributorName = p_1;
        }

        public Contributor() { }
    }
}