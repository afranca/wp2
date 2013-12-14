
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MvcGCUImagesStarter.Models;

namespace MvcGCUImagesStarter.Repository
{
    interface IGCUImagesRepository : IDisposable
    {
        IQueryable<Image> GetAllImages();
        IQueryable<Image> GetLast12Images();
        IQueryable<Category> GetCategories(string search_string=null);
        Image GetImage(int imageId);
        IQueryable<Image> GetContributorImages(string contributor);
        IQueryable<Tag> GetTags(string search_string = null);
        IQueryable<Contributor> GetContributors();
        IQueryable<Image> Search(string search_string);
        IQueryable<Image> FilterByTag(string tag, string search_string = null);

        IQueryable<Image> FilterByCategory(string cat, string search_string = null);
        void AddImage(Image image);
        void DeleteImage(int imageId);
        void UpdateImage(Image image);
        void Save();

        Tag GetTagByName(string tagName);
        IQueryable<Image> Filters(string tagName = null, string catName = null, string contName = null);
    }
}
