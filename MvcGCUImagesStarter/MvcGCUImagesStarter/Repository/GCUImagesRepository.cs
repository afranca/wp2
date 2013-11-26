using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MvcGCUImagesStarter.Models;

namespace MvcGCUImagesStarter.Repository
{
    public class GCUImagesRepository:IGCUImagesRepository
    {
        private GCUImagesEntities context;

        public GCUImagesRepository(GCUImagesEntities context)
        {
            this.context = context;
        }

        public IQueryable<Image> GetAllImages()
        {
            return context.Images;
        }

        public IQueryable<Image> GetLast12Images()
        {
            IQueryable<Image> result =
                (from a in context.Images
                 orderby a.ImageId descending
                 select a).Take(12);
            return result;
        }

        public Image GetImage(int albumId)
        {
            return context.Images.Find(albumId);
        }

        public IQueryable<Tag> GetTags(string search_string = null)
        {
            IQueryable<Tag> tags = context.Tags;
            if (search_string != null)
            {
                string searchterm = search_string.ToString().ToUpper();

                tags =
                    (from t in tags
                     where (from i in t.Images
                            where i.ImageTitle.ToUpper().Contains(searchterm) || i.ImageContributor.ToUpper().Contains(searchterm)
                                select i).Count() > 0
                     orderby (from i in t.Images
                              where i.ImageTitle.ToUpper().Contains(searchterm) || i.ImageContributor.ToUpper().Contains(searchterm)
                              select i).Count() descending, t.TagName ascending
                     select t);
                return tags;
            }
            else
            {
                tags =
                    (from t in tags
                     orderby t.Images.Count() descending, t.TagName ascending
                     select t);
                return tags;
            }
        }

        public IQueryable<Category> GetCategories(string search_string = null)
        {
            if (search_string != null)
            {
                string searchterm = search_string.ToString().ToUpper();
                IQueryable<Category> Result =
                    (from c in context.Images
                     where c.ImageTitle.ToUpper().Contains(searchterm) || c.ImageContributor.ToUpper().Contains(searchterm)
                     group c by c.Category into categorygroup
                     orderby categorygroup.Count() descending
                     select new Category() { category = categorygroup.Key, kount = categorygroup.Count() });
                return Result;
            }
            else
            {
                IQueryable<Category> Result =
                  (from c in context.Images
                   group c by c.Category into categorygroup
                   orderby categorygroup.Count() descending
                   select new Category() { category = categorygroup.Key, kount = categorygroup.Count() });
                return Result;
            }

        }

        public IQueryable<Image> GetContributorImages(string contributor)
        {
            IQueryable<Image> Result =
              (from c in context.Images
               where c.ImageContributor.Contains(contributor)
               orderby c.ImageId
               select c);
            return Result;
        }

        public IQueryable<Contributor> GetContributors()
        {
            IQueryable<Contributor> Result =
              (from c in context.Images
               group c by c.ImageContributor into contributorgroup
               select new Contributor() { contributorName = contributorgroup.Key, contributorImages = contributorgroup });
            return Result;
        }

        public IQueryable<Image> Search(string search_string)
        {
            IQueryable<Image> Result =
              (from c in context.Images
               where c.ImageTitle.Contains(search_string) || c.ImageContributor.Contains(search_string)
               orderby c.ImageId
               select c).Distinct();
            return Result;
        }

        public IQueryable<Image> Filter(string tag, string search_string = null)
        {
            if (search_string != null)
            {
                string searchterm = search_string.ToString().ToUpper();
                IQueryable<Image> Result =
                    (from c in context.Images
                     where c.Tags.Any(t => t.TagName == tag) && (c.ImageTitle.ToUpper().Contains(searchterm) || c.ImageContributor.ToUpper().Contains(searchterm))
                     orderby c.ImageId
                     select c).Distinct();
                return Result;
            }
            else
            {
                IQueryable<Image> Result =
                  (from c in context.Images
                   where c.Tags.Any(t => t.TagName == tag)
                   orderby c.ImageId
                   select c).Distinct();
                return Result;
            }
        }

        public void AddImage(Image image)
        {
            context.Images.Add(image);
        }

        public void DeleteImage(int imageId)
        {
            Image image = context.Images.Find(imageId);
            context.Images.Remove(image);
        }

        public void UpdateImage(Image image)
        {
            context.Entry(image).State = System.Data.EntityState.Modified;
        }

        public void Save()
        {
            context.SaveChanges();
        }

        private bool disposed = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposed)
            {
                if (disposing)
                {
                    context.Dispose();
                }
            }
            this.disposed = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }


        public IQueryable<Image> FilterByCategory(string cat, string search_string = null) {
            if (search_string != null){
                string searchterm = search_string.ToString().ToUpper();
                IQueryable<Image> Result =
                    (from c in context.Images
                     where c.Category.Contains(cat) && (c.ImageTitle.ToUpper().Contains(searchterm) || c.ImageContributor.ToUpper().Contains(searchterm))
                     orderby c.ImageId
                     select c).Distinct();
                return Result;
            } else {
                IQueryable<Image> Result =
                  (from c in context.Images
                   where c.Category.Contains(cat)
                   orderby c.ImageId
                   select c).Distinct();
                return Result;
            }
        }


    }
}