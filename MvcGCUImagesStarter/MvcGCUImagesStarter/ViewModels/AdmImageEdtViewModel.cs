using MvcGCUImagesStarter.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MvcGCUImagesStarter.ViewModels
{
    public class AdmImageEdtViewModel
    {
        public Image image { get; set; }
        public IEnumerable<Category> categories { get; set; }
    }
}