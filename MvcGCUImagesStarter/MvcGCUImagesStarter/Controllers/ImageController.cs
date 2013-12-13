﻿using System;
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

            ViewBag.noPages = calculateNumberOfPages(pageSize, images);

            return View(imagesViewModel);
        }


        private double calculateNumberOfPages(int itemsPerPage, IEnumerable<Image> source)
        {

            int listSize = source.Count();
            double result = (double)listSize / (double)itemsPerPage;
            return Math.Ceiling(result);

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
            ViewBag.noPages = calculateNumberOfPages(pageSize, images);
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
            ViewBag.noPages = calculateNumberOfPages(pageSize, images);
            return View(imagesViewModel);

        }

        //
        // GET: /Image/Filter/1

        public ActionResult FilterByCategory(int? page, string category, string search_string = null)  {

            const int pageSize = 12;
            IQueryable<Image> images;

            HomeViewModel homeViewModel = new HomeViewModel();
            if (search_string != null) {
                IQueryable<Category> categories = imagesRepository.GetCategories(search_string);
                homeViewModel.categories = categories;
                images = imagesRepository.FilterByCategory(category, search_string);
                ViewBag.search_string = search_string;
            } else  {
                IQueryable<Category> categories = imagesRepository.GetCategories();
                homeViewModel.categories = categories;
                images = imagesRepository.FilterByCategory(category);
            }

            Func<Image, IComparable> func = null;
            func = (Image a) => a.ImageId;

            var paginatedList = new PaginatedList<Image>(images, page ?? 0, func, pageSize);
            homeViewModel.images = paginatedList;
            ViewBag.category = category;

            ViewBag.noPages = calculateNumberOfPages(pageSize, images);
            return View(homeViewModel);
        }


        public ActionResult FilterByTag(int? page, string tag, string search_string = null) {

            const int pageSize = 12;
            IQueryable<Image> images;

            ImagesViewModel imagesViewModel = new ImagesViewModel();
            if (search_string != null)  {
                IQueryable<Tag> tags = imagesRepository.GetTags(search_string);
                imagesViewModel.tags = tags;
                images = imagesRepository.FilterByTag(tag, search_string);
                ViewBag.search_string = search_string;
            } else {
                IQueryable<Tag> tags = imagesRepository.GetTags();
                imagesViewModel.tags = tags;
                images = imagesRepository.FilterByTag(tag);
            }

            Func<Image, IComparable> func = null;
            func = (Image a) => a.ImageId;

            var paginatedList = new PaginatedList<Image>(images, page ?? 0, func, pageSize);
            imagesViewModel.images = paginatedList;
            ViewBag.tag = tag;
            ViewBag.noPages = calculateNumberOfPages(pageSize, images);
            return View(imagesViewModel);
        }
        public ActionResult Admin(int? page, string op = null, int image_id = 0)
        {
            const int pageSize = 12;
            IQueryable<Image> images = imagesRepository.GetAllImages();

            Func<Image, IComparable> func = null;
            func = (Image a) => a.ImageId;

            var paginatedList = new PaginatedList<Image>(images, page ?? 0, func, pageSize);

            ViewBag.noPages = calculateNumberOfPages(pageSize, images);

            return View(paginatedList);
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
            IQueryable<Category> categories = imagesRepository.GetCategories();

            Image image = db.Images.Find(id);
            if (image == null)
            {
                return HttpNotFound();
            }
            AdmImageEdtViewModel wrappingView = new AdmImageEdtViewModel();
            wrappingView.image = image;
            wrappingView.categories = categories;

            return View(wrappingView);
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

            /*
            Image image = db.Images.Find(id);
            if (image == null)
            {
                return HttpNotFound();
            }
            return View(image);
             */
            Image image = db.Images.Find(id);
            image.Tags = null;
            imagesRepository.UpdateImage(image);
            //db.SaveChanges();
            db.Images.Remove(image);
            db.SaveChanges();
            return RedirectToAction("Admin");
        }

        //
        // POST: /Image/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
        // not being used

         //   Image image = db.Images.Find(id);
         //   db.Images.Remove(image);
        //    db.SaveChanges();
            return RedirectToAction("Admin");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }


    }
}