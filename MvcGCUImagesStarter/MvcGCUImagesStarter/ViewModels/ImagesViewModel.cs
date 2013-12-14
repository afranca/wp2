using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MvcGCUImagesStarter.Models;
using MvcGCUImagesStarter.Helpers;

namespace MvcGCUImagesStarter.ViewModels
{
    public class ImagesViewModel
    {
        public PaginatedList<Image> images { get; set; }
        public IEnumerable<Tag> tags { get; set; }
        public IEnumerable<Category> categories { get; set; }
        public IEnumerable<Contributor> contributors { get; set; }
    }
}