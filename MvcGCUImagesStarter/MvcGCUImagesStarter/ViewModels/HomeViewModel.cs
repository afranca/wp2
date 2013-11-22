using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MvcGCUImagesStarter.Models;

namespace MvcGCUImagesStarter.ViewModels
{
    public class HomeViewModel
    {
        public IEnumerable<Image> images { get; set; }
        public IEnumerable<Category> categories { get; set; }
    }
}