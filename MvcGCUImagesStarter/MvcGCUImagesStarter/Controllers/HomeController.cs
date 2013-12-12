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
            IEnumerable<Image> images = imagesRepository.GetAllImages();

            List<Image> list = new List<Image>(images);
            Random rnd = new Random(/* Eventually provide some random seed here. */);
            for (int i = list.Count - 1; i > 0; --i)
            {
                int j = rnd.Next(i + 1);
                Image tmp = list[i];
                list[i] = list[j];
                list[j] = tmp;
            }

            Image img = list[1];
            IEnumerable<Image> random = list.Take(12);


            var categories = imagesRepository.GetCategories();

            HomeViewModel homeViewModel = new HomeViewModel();
            homeViewModel.images = random;
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
