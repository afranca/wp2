using MvcGCUImagesStarter.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MvcGCUImagesStarter.ViewModels
{
    public class DetailsViewModel
    {
        public Image image { get; set; }
        public IEnumerable<Image> relatedImages { get; set; }  

    }
}