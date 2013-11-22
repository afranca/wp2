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

namespace MvcGCUImagesStarter.Controllers
{
    public class ImageController : Controller
    {
        private GCUImagesEntities db = new GCUImagesEntities();

        #region Private member variables ...
        private IGCUImagesRepository imagesRepository;
        #endregion

        #region Public constructor ...
        public ImageController()
        {
            this.imagesRepository = new GCUImagesRepository(new GCUImagesEntities());
        }
        #endregion

        //
        // GET: /Image/

        public ActionResult Index()
        {
            var images = imagesRepository.GetAllImages();
            var tags = imagesRepository.GetTags();

            ImagesViewModel imagesViewModel = new ImagesViewModel();
            imagesViewModel.images = images;
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
            return View("NotYetImplemented");
        }

        //
        // POST: /Image/Search/Blue

        [HttpPost]
        public ActionResult Search(FormCollection formValues)
        {
            return View("NotYetImplemented");
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