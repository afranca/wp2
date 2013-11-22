using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcGCUImagesStarter.Models;
using MvcGCUImagesStarter.Repository;
using MvcGCUImagesStarter.ViewModels;

namespace MvcGCUImagesStarter.Controllers
{
    public class HomeController : Controller
    {

        #region Private member variables ...
        private IGCUImagesRepository imagesRepository;
        #endregion

        #region Public constructor ...
        public HomeController()
        {
            this.imagesRepository = new GCUImagesRepository(new GCUImagesEntities());
        }
        #endregion

        public ActionResult Index()
        {
            var images = imagesRepository.GetLast12Images();
            var categories = imagesRepository.GetCategories();

            HomeViewModel homeViewModel = new HomeViewModel();
            homeViewModel.images = images;
            homeViewModel.categories = categories;

            return View(homeViewModel);
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your app description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}
