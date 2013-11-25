using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcGCUImagesStarter.Models;
using MvcGCUImagesStarter.Repository;
using MvcGCUImagesStarter.ViewModels;
using MvcGCUImagesStarter.Helpers;

namespace MvcGCUImagesStarter.Controllers
{
    public class ImageController : Controller
    {
        


        private IGCUImagesRepository imagesRepository;
        private GCUImagesEntities db = new GCUImagesEntities();
 
        public ImageController() {
            this.imagesRepository = new GCUImagesRepository(db);
        }
        

        //
        // GET: /Image/

        public ActionResult Index(int? page){

            const int pageSize = 12;

            ImagesViewModel imagesViewModel = new ImagesViewModel();
            IQueryable<Tag> tags = imagesRepository.GetTags();
            IQueryable<Image> images = imagesRepository.GetAllImages();

            Func<Image, IComparable> func = null;
            func = (Image a) => a.ImageId;

            var paginatedList = new PaginatedList<Image>(images, page ?? 0, func, pageSize);
            
            imagesViewModel.images = paginatedList;
            imagesViewModel.tags = tags;

            return View(imagesViewModel);
        }

        //
        // GET: /Image/Details/5

        public ActionResult Details(int id = 0)
        {
            Image image = imagesRepository.GetImage(id);
            if (image == null)
                return View("NotFound");
            else
            {
                return View(image);
            }
        }

        //
        // GET: /Image/Contributors

        public ActionResult Contributors()
        {
            IEnumerable<Contributor> contributors = imagesRepository.GetContributors();
            return View(contributors);
        }

        //
        // GET: /Image/Search/Blue

        public ActionResult Search(int? page, string search_string)
        {
            const int pageSize = 12;
        
            ImagesViewModel imagesViewModel = new ImagesViewModel();
            IQueryable<Tag> tags = imagesRepository.GetTags(search_string);
            imagesViewModel.tags = tags;

            IQueryable<Image> images = imagesRepository.Search(search_string);

            Func<Image, IComparable> func = null;
            func = (Image a) => a.ImageId;

            var paginateList = new PaginatedList<Image>(images, page ?? 0, func, pageSize);
            imagesViewModel.images = paginateList;
            ViewBag.search_string = search_string;
            return View(imagesViewModel);
        }

        //
        // POST: /Image/Search/Blue

        [HttpPost]
        public ActionResult Search(FormCollection formValues)
        {
            const int pageSize = 12;
            int page = 0;
            string search_string = Request.Form["searchText"];
            ViewBag.category = null;
            ImagesViewModel imagesViewModel = new ImagesViewModel();
            IQueryable<Tag> tags =  imagesRepository.GetTags(search_string);
            imagesViewModel.tags = tags;

            IQueryable<Image> images = imagesRepository.Search(search_string);

            Func<Image, IComparable> func = null;
            func = (Image a) => a.ImageId;

            var paginateList = new PaginatedList<Image>(images, page, func,pageSize);
            imagesViewModel.images = paginateList;
            ViewBag.search_string = search_string;
            return View(imagesViewModel);

        }

        //
        // GET: /Image/Filter/1

        public ActionResult Filter(int? page, string tag, string search_string = null)
        {
            return View("NotYetImplemented");
        }

        public ActionResult Admin()
        {
            return View("NotYetImplemented");
        }

        //
        // GET: /Image/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Image/Create

        [HttpPost]
        public ActionResult Create(Image image)
        {
            if (ModelState.IsValid)
            {
                db.Images.Add(image);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(image);
        }

        //
        // GET: /Image/Edit/5

        public ActionResult Edit(int id = 0)
        {
            Image image = db.Images.Find(id);
            if (image == null)
            {
                return HttpNotFound();
            }
            return View(image);
        }

        //
        // POST: /Image/Edit/5

        [HttpPost]
        public ActionResult Edit(Image image)
        {
            if (ModelState.IsValid)
            {
                db.Entry(image).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(image);
        }

        //
        // GET: /Image/Delete/5

        public ActionResult Delete(int id = 0)
        {
            Image image = db.Images.Find(id);
            if (image == null)
            {
                return HttpNotFound();
            }
            return View(image);
        }

        //
        // POST: /Image/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            Image image = db.Images.Find(id);
            db.Images.Remove(image);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}