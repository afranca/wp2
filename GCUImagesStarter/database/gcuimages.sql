-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 06, 2013 at 09:56 AM
-- Server version: 5.6.11
-- PHP Version: 5.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `gcuimages`
--
CREATE DATABASE IF NOT EXISTS `gcuimages` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `gcuimages`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `collection_add_image`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_add_image`(IN `inImageTitle` TEXT, IN `inContributor` TEXT, IN `inDescription` TEXT, IN `inImageURL` TEXT, IN `inWidth` INT, IN `inHeight` INT, IN `inCategory` TEXT)
BEGIN
 INSERT INTO image (image_title, image_contributor, image_description, image_url, width, height, category)
        VALUES (inImageTitle, inContributor, inDescription, inImageURL, InWidth, InHeight, InCategory);
END$$

DROP PROCEDURE IF EXISTS `collection_add_image_tag`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_add_image_tag`(IN `inImageID` INT, IN `inTagID` INT)
    NO SQL
BEGIN
 INSERT INTO image_tag (image_id, tag_id)
        VALUES (inImageID, inTagID);
END$$

DROP PROCEDURE IF EXISTS `collection_add_tag`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_add_tag`(IN `inTagName` TEXT)
    NO SQL
BEGIN
 INSERT INTO tag (tag_name)
        VALUES (inTagName);
END$$

DROP PROCEDURE IF EXISTS `collection_count_images_in_collection`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_count_images_in_collection`()
BEGIN
  SELECT COUNT(*) AS images_in_collection_count
  FROM   image;
END$$

DROP PROCEDURE IF EXISTS `collection_count_images_in_collection_by_category`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_count_images_in_collection_by_category`(IN `inCategory` TEXT)
    NO SQL
BEGIN
  SELECT COUNT(*) AS categories_in_collection_count
  FROM   image
  WHERE category = inCategory;
END$$

DROP PROCEDURE IF EXISTS `collection_count_images_in_collection_by_tag`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_count_images_in_collection_by_tag`(IN inTag TEXT)
BEGIN
  SELECT COUNT(*) AS tags_in_collection_count
  FROM   image, image_tag, tag
  WHERE image.image_id = image_tag.image_id and image_tag.tag_id = tag.tag_id and tag.tag_name = inTag;
END$$

DROP PROCEDURE IF EXISTS `collection_count_search_category_result`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_count_search_category_result`(IN `inSearchString` TEXT, IN `inCategory` TEXT)
    NO SQL
BEGIN
    PREPARE statement FROM
      "SELECT   count(*)
       FROM     image
       WHERE    category = ?
	   AND 	MATCH (image_title, image_contributor) AGAINST (? IN BOOLEAN MODE)";
	SET @p1 = inCategory;
	SET @p2 = inSearchString;
	EXECUTE statement USING @p1, @p2;
END$$

DROP PROCEDURE IF EXISTS `collection_count_search_result`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_count_search_result`(
  IN inSearchString TEXT)
BEGIN
    PREPARE statement FROM
      "SELECT   count(*)
       FROM     image
       WHERE    MATCH (image_title, image_contributor) AGAINST (? IN BOOLEAN MODE)";
	SET @p1 = inSearchString;
	EXECUTE statement USING @p1;
END$$

DROP PROCEDURE IF EXISTS `collection_count_search_tag_result`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_count_search_tag_result`(
  IN inSearchString TEXT, IN inTag TEXT)
BEGIN
    PREPARE statement FROM
      "SELECT   count(*)
       FROM     image, image_tag, tag
       WHERE    image.image_id = image_tag.image_id and image_tag.tag_id = tag.tag_id and tag.tag_name = ?
	   AND 	MATCH (image_title, image_contributor) AGAINST (? IN BOOLEAN MODE)";
	SET @p1 = inTag;
	SET @p2 = inSearchString;
	EXECUTE statement USING @p1, @p2;
END$$

DROP PROCEDURE IF EXISTS `collection_get_categories_list`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_get_categories_list`()
    NO SQL
Begin
	Select category, count(*) as kount from image
	Group BY category
	Order by kount desc, category;
End$$

DROP PROCEDURE IF EXISTS `collection_get_categories_list_search`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_get_categories_list_search`(IN `inSearchString` TEXT)
    NO SQL
BEGIN
    PREPARE statement FROM
      "SELECT   category, count(*) as kount
       FROM     image
       WHERE   MATCH (image_title, image_contributor) AGAINST (? IN BOOLEAN MODE)
		group by category order by kount desc, category";
	SET @p1 = inSearchString;
	EXECUTE statement USING @p1;
END$$

DROP PROCEDURE IF EXISTS `collection_get_contributors_list`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_get_contributors_list`()
BEGIN
 SELECT image_contributor, count(*) as contributorimages FROM image Group By image_contributor Order by contributorimages desc, image_contributor;
END$$

DROP PROCEDURE IF EXISTS `collection_get_contributor_images`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_get_contributor_images`(IN `inContributor` TEXT)
BEGIN
SET @pattern = CONCAT('%',inContributor,'%');
PREPARE statement FROM
      "SELECT   image_id, image_title,
                   image_contributor,
                image_description, image_url
       FROM     image
       WHERE    image_contributor LIKE ?
       ORDER BY image_id";
SET @p1 = inContributor;
EXECUTE statement USING @p1;
END$$

DROP PROCEDURE IF EXISTS `collection_get_highest_rated_contributors`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_get_highest_rated_contributors`()
    COMMENT 'NEW PROCEDURE By ALEXANDRE'
BEGIN

 SELECT image_contributor, round(sum(sum_ratings)/sum(no_ratings),0) as average_rating
  FROM image
	GROUP BY image_contributor
	ORDER BY average_rating desc limit 20;
END$$

DROP PROCEDURE IF EXISTS `collection_get_highest_rated_images`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_get_highest_rated_images`()
    COMMENT 'NEW PROCEDURE By ALEXANDRE'
BEGIN

 SELECT image_id, image_title, image_contributor, image_description, image_url, width,height,category, round(sum_ratings/no_ratings, 0) as average_rating, no_ratings FROM image ORDER BY average_rating desc limit 10;
END$$

DROP PROCEDURE IF EXISTS `collection_get_images_by_category`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_get_images_by_category`(IN `inCategory` TEXT, IN `inImagesPerPage` INT, IN `inStartItem` INT)
    NO SQL
BEGIN
    SET @p1 = inCategory;
SET @p2 = inStartItem;
SET @p3 = inImagesPerPage;
PREPARE statement FROM
      "SELECT   image.image_id, image_title,
                image_contributor,
                image_description, image_url, width, height, category
       FROM     image
       WHERE  category = ? 
       ORDER BY image.image_id
       LIMIT    ?, ?";
EXECUTE statement USING @p1, @p2, @p3;
END$$

DROP PROCEDURE IF EXISTS `collection_get_images_by_tag`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_get_images_by_tag`(IN `inTag` TEXT, IN `inImagesPerPage` INT, IN `inStartItem` INT)
BEGIN
    SET @p1 = inTag;
SET @p2 = inStartItem;
SET @p3 = inImagesPerPage;
PREPARE statement FROM
      "SELECT   image.image_id, image_title,
                image_contributor,
                image_description, image_url, width, height, category
       FROM     image, image_tag, tag
       WHERE  image.image_id = image_tag.image_id and image_tag.tag_id = tag.tag_id and tag.tag_name = ? 
       ORDER BY image.image_id
       LIMIT    ?, ?";
EXECUTE statement USING @p1, @p2, @p3;
END$$

DROP PROCEDURE IF EXISTS `collection_get_images_latest`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_get_images_latest`()
BEGIN
 SELECT image_id, image_title, image_contributor, image_description, image_url, width, height, category FROM image ORDER BY image_id desc limit 12;
END$$

DROP PROCEDURE IF EXISTS `collection_get_images_list`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_get_images_list`()
BEGIN
 SELECT image_id, image_title, image_contributor, image_description, image_url, width, height, category FROM image ORDER BY image_id;
END$$

DROP PROCEDURE IF EXISTS `collection_get_images_on_collection`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_get_images_on_collection`(IN `inImagesPerPage` INT, IN `inStartItem` INT)
BEGIN
  PREPARE statement FROM
    "SELECT   image_id, image_title, image_contributor, image_description, image_url, width, height, category
     FROM     image
     LIMIT    ?, ?";
SET @p1 = inStartItem;
SET @p2 = inImagesPerPage;
EXECUTE statement USING @p1, @p2;
END$$

DROP PROCEDURE IF EXISTS `collection_get_image_contributor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_get_image_contributor`(IN inImageId INT)
BEGIN
 SELECT image_contributor
 FROM   image
 WHERE  image_id = inImageId;
END$$

DROP PROCEDURE IF EXISTS `collection_get_image_details`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_get_image_details`(IN `inImageId` INT)
BEGIN
 SELECT image_id, image_title, image_contributor, image_description, image_url, width, height, category, round(sum_ratings/no_ratings,0) as average_rating, no_ratings
 FROM   image
 WHERE  image_id = inImageId;
END$$

DROP PROCEDURE IF EXISTS `collection_get_image_tags`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_get_image_tags`(IN inImageId INT)
BEGIN
 SELECT *
 FROM   tag, image_tag
 WHERE  tag.tag_id = image_tag.tag_id and image_tag.image_id = inImageId 
 ORDER BY tag.tag_name;
END$$

DROP PROCEDURE IF EXISTS `collection_get_tags_list`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_get_tags_list`()
BEGIN
SELECT tag_name, count(*) as kount FROM tag, image_tag where tag.tag_id = image_tag.tag_id group by tag_name order by kount desc, tag_name;
END$$

DROP PROCEDURE IF EXISTS `collection_get_tags_list_search`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_get_tags_list_search`(IN `inSearchString` TEXT)
BEGIN
    PREPARE statement FROM
      "SELECT   tag_name, count(*) as kount
       FROM     image, image_tag, tag
       WHERE   MATCH (image_title, image_contributor) AGAINST (? IN BOOLEAN MODE)
		AND image.image_id = image_tag.image_id and tag.tag_id = image_tag.tag_id
		 group by tag_name order by kount desc, tag_name";
	SET @p1 = inSearchString;
	EXECUTE statement USING @p1;
END$$

DROP PROCEDURE IF EXISTS `collection_rate_image`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_rate_image`(IN `inImageId` INT, IN `inRating` INT)
    COMMENT 'new procedure by alex'
BEGIN
    PREPARE statement FROM
      "UPDATE image
       SET    sum_ratings = sum_ratings + ?, no_ratings = no_ratings + ?
       WHERE  image_id = ?;";
    SET @p1 = inRating;
    SET @p2 = 1;
    SET @p3 = inImageId;
    EXECUTE statement USING @p1, @p2, @p3;
END$$

DROP PROCEDURE IF EXISTS `collection_search`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_search`(IN `inSearchString` TEXT, IN `inImagesPerPage` INT, IN `inStartItem` INT)
BEGIN
    PREPARE statement FROM
      "SELECT   image_id, image_title,
                image_contributor,
                image_description, image_url, width, height, category
       FROM     image
       WHERE    MATCH (image_title, image_contributor) AGAINST (? IN BOOLEAN MODE)
       ORDER BY MATCH (image_title, image_contributor) AGAINST (? IN BOOLEAN MODE) DESC
       LIMIT    ?, ?";
	SET @p1 = inSearchString;
	SET @p2 = inStartItem;
	SET @p3 = inImagesPerPage;
	EXECUTE statement USING @p1, @p1, @p2, @p3;
END$$

DROP PROCEDURE IF EXISTS `collection_search_category`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_search_category`(IN `inSearchString` TEXT, IN `inCategory` TEXT, IN `inImagesPerPage` INT, IN `inStartItem` INT)
    NO SQL
BEGIN
    PREPARE statement FROM
      "SELECT   image_id, image_title,
                image_contributor,
                image_description, image_url, width, height, category
       FROM     image
       WHERE    category = ?
		AND	MATCH (image_title, image_contributor) AGAINST (? IN BOOLEAN MODE)  
       ORDER BY MATCH (image_title, image_contributor) AGAINST (? IN BOOLEAN MODE) DESC       
       LIMIT    ?, ?";
	SET @p1 = inCategory;
	SET @p2 = inSearchString;
	SET @p3 = inStartItem;
	SET @p4 = inImagesPerPage;
	EXECUTE statement USING @p1, @p2, @p2, @p3, @p4;
END$$

DROP PROCEDURE IF EXISTS `collection_search_tag`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_search_tag`(IN `inSearchString` TEXT, IN `inTag` TEXT, IN `inImagesPerPage` INT, IN `inStartItem` INT)
BEGIN
    PREPARE statement FROM
      "SELECT   image.image_id, image_title,
                image_contributor,
                image_description, image_url, width, height, category
       FROM     image, image_tag, tag
       WHERE    tag.tag_name = ?
		AND	MATCH (image_title, image_contributor) AGAINST (? IN BOOLEAN MODE)  
       AND	image.image_id = image_tag.image_id and image_tag.tag_id = tag.tag_id
       ORDER BY MATCH (image_title, image_contributor) AGAINST (? IN BOOLEAN MODE) DESC       
       LIMIT    ?, ?";
	SET @p1 = inTag;
	SET @p2 = inSearchString;
	SET @p3 = inStartItem;
	SET @p4 = inImagesPerPage;
	EXECUTE statement USING @p1, @p2, @p2, @p3, @p4;
END$$

DROP PROCEDURE IF EXISTS `collection_update_image`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_update_image`(IN `inImageId` INT, IN `inImageTitle` TEXT, IN `inContributor` TEXT, IN `inImageDescription` TEXT, IN `inImageURL` TEXT, IN `inWidth` INT, IN `inHeight` INT, IN `inCategory` TEXT)
BEGIN
 UPDATE image
 SET    image_title = inImageTitle,
        image_contributor = inContributor,
		image_description = inImageDescription, 
		image_url = inImageURL, width = inWidth, 
		height = inHeight, category = inCategory
 WHERE  image_id = inImageId;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
CREATE TABLE IF NOT EXISTS `image` (
  `image_id` int(11) NOT NULL AUTO_INCREMENT,
  `image_title` varchar(50) NOT NULL,
  `image_description` text NOT NULL,
  `image_contributor` varchar(50) NOT NULL,
  `image_url` varchar(250) NOT NULL DEFAULT 'image_missing.png',
  `width` smallint(6) NOT NULL,
  `height` smallint(6) NOT NULL,
  `category` varchar(15) NOT NULL,
  `sum_ratings` int(10) NOT NULL DEFAULT '0',
  `no_ratings` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`image_id`),
  FULLTEXT KEY `idx_ft_image_title_contributor` (`image_title`,`image_contributor`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=192 ;

--
-- Dumping data for table `image`
--

INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(3, 'Nigerian Grave Diggers, 6 Feet', 'The men standing in the picture are all hired grave diggers, that''s what they are called in western part of Africa and they are mostly hired whenever someone is dead and needs to be buried. They are professionally trained in digging down 6ft the ground whenever someone is been pronounced dead, though this style ought to have been improved as we ought to have taken a lot of steps after our colonial masters (British) but that isn''t happening yet, I just look at the picture most times and think it is not an interesting experience at all and I intend to keep it just for the memories and also for the fact that I may end up being buried like this one day, God knows the best.', 'Adedamola Oladebo', 'ao_nigeriangravediggers.jpg', 300, 300, 'Culture', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(4, 'One World Trade Centre, New York', 'The new Trade Centre/Memorial being built in down town New York last year. This is being built as a memorial for the 9/11 terrorist attacks that took so many lives years ago.', 'Alex Jarvie', 'aj_oneworldtradecentreNY.jpg', 300, 300, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(5, 'View From Central Park, New York', 'A walk through Central Park in New York Last summer thought I would take a picture to show the contrast between the park and all these massive sky scrapers that surrounded it.', 'Alex Jarvie', 'aj_viewfromcentralparkNY.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(7, 'New York City From The Empire State Building', 'A wonderful overview of New York City from the top of the Empire State Building. A staggering view and can see for miles around and see many different landmarks around the city', 'Alex Murray', 'am_nycfromempirestatebuilding.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(8, 'Statue Of Liberty', 'The famous Statue of Liberty in New York City. Built in 1875 it is a symbol of freedom in the USA. It is certainly one of the most iconic landmarks in the world.', 'Alex Murray', 'am_statueofliberty.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(9, 'City Hall, Marienplatz, Munich', 'This is the wonderfully constructed city hall in Munich''s main square, the Marienplatz. It draws millions of tourists a year and can be seen for miles around the city. It was built to celebrate the end of Swedish occupation.', 'Alex Murray', 'am_cityhallmarienplatzmunich.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(10, 'Chamonix, France', 'This photo was taken in 2009 during my ski trip to Chamonix, in the French Alps.  It was taken at dusk that''s the reason the snow is reflecting reddish light, giving us a very colourful and interesting view of the summit.', 'Alexandre Franca', 'af_chamonixfrance.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(11, 'Kalymnos, Greece', 'This photo was taken in August 2013, during my rock climbing trip in Kalymnos, Greece. The cave in the photo is called Grande Grotta (Great Cave) and it is a popular climbing spot among climbers.', 'Alexandre Franca', 'af_kalymnosgreece.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(12, 'Bamboo Island,Thailand', 'This photo was taken in February 2012, while a boat trip to Bamboo Island in Thailand. Most of small islands in Thailand have this strange formation due to their volcanic origin. They are basically solid lava pushed up by underwater volcanoes, which have about 20m high walls and mostly no beaches. Perfect for Solo Rock Climbers as no partner or rope is necessary, if they fall, they fall straight into the water.', 'Alexandre Franca', 'af_bambooislandthailand.jpg', 640, 480, 'Travel', 4, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(13, 'Tiger', 'This is one of the few white tigers that still survive. This species is in danger of extinction and the \r\nremaining few are in captivity. In this picture we can imagine would be the natural habitat of the \r\ntiger taking a bath on a cool river.\r\nThese animals are mammals and distant relatives of current domestic cats.\r\nCertainly are some beautiful cats.', 'Andres Guevara', 'ag_tiger.jpg', 640, 480, 'Nature', 3, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(14, 'Ferrari', 'This is a Ferrari 658 f1 is a race car.\r\nThese cars can reach speeds of about 370 km / h.\r\nThis car is designed to get a great acceleration in a few seconds and to reduce its speed in a \r\nfew meters.\r\nIt takes many years of training to learn to control these cars\r\nand obtain their full potential without suffering any danger.\r\nDrive a F1 is one of the most exciting experiences in the world.', 'Andres Guevara', 'ag_ferrari.jpg', 640, 480, 'Sports', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(15, 'Mountains, Colombia', 'This is a quiet area in the mountains of Colombia.\r\nWhich probably were grown potatoes or some vegetables.\r\nColombia offers many amazing landscapes to go walking and hiking\r\nIn its mountains lies a diverse wildlife and beautiful flora.\r\nIf you are ever in Colombia must take advantage and enjoy beautiful places', 'Andres Guevara', 'ag_mountainscolombia.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(16, 'River Clyde From Gourock', 'Sun setting behind the hills taken from One Ashton Road in Gourock. Originally the Firth Hotel the outside seating overlooks the River Clyde. Members of the Gourock Yacht club berth their yachts & boats in this surrounding area. To the left in the background you can see Dunoon, directly in front is Blairmore & Strone and to the far right is Kilcreggan.', 'Andrew McIndoe', 'amci_riverclydefromgourock.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(17, 'Ross Priory Golf Club', 'Ross Priory Golf Club and House overlooking the south-east of Loch Lomond. Picture taken in July during a Golfing trip, the golf course features 9 holes most of which are played uphill. When teeing off from the top of the hill you can clearly see a large area of Loch Lomond and the adjacent landscape. The House itself also include a bar, reception & dining room and extensive garden in the 200 acre surroundings.', 'Andrew McIndoe', 'amci_rosspriorygolfclub.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(18, 'Houston House', 'Houston House is situated in the Village of Houston in Renfrewshire. The building resides on the same foundations and contains some of the same structures where originally Houston Castle situated and was built in 1400''s.  To the back of the house there is a horse jumping arena and its own private woods. The lands include a Parish Church to the right of the House just out of shot. Picture was taken when attending a party at the house in July.', 'Andrew McIndoe', 'amci_houstonhouse.jpg', 480, 640, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(19, 'Calm', 'One of those "calm before the storm" moments, literally. Interestingly enough, at that exact moment all wind turbines were standing still-there was no wind, no sound and no movement in miles; almost as if time had stopped.', 'Angel Paunchev', 'ap_calm.jpg', 640, 480, 'Weather', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(20, 'Edge, Kaliakra, Bulgaria', 'A breathtaking view from Kaliakra, a headland on the northern Bulgarian Black Sea Coast. There is nothing but water ahead and it feels as if you are standing on the edge of the world. And a steep edge it is-reaching 70 metres down to the sea.', 'Angel Paunchev', 'ap_edgekaliakrabulgaria.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(21, 'Sunset', 'The obligatory sunset photo. The colours and composition catch almost perfectly the calmness of a nice walk down a yacht port just after a beautiful sunset.', 'Angel Paunchev', 'ap_sunset.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(22, 'Tian Tian, Edinburgh Zoo', 'This is a picture of Tian Tian, one of the giant pandas in Edinburgh Zoo.', 'Anne-Marie Docherty', 'amd_tiantianedinburghzoo.jpg', 640, 480, 'Nature', 2, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(23, 'Tibor, Edinburgh Zoo', 'This is a picture of Tibor, a sumatran tiger in Edinburgh Zoo', 'Anne-Marie Docherty', 'amd_tiboredinburghzoo.jpg', 640, 480, 'Nature', 3, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(24, 'Chimpanzee, Edinburgh Zoo', 'This is picture of one of the chimpanzees within the Bugondo Trail situated within Edinburgh Zoo.', 'Anne-Marie Docherty', 'amd_chimpanzeeedinburghzoo.jpg', 640, 480, 'Nature', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(25, 'Ben Nevis', 'Foothill of Ben Nevis - highest peak in Britain. It is located close to Fort William in Highlands.', 'Aurelijus Vedrickas', 'av_bennevis.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(26, 'Conic Hill', 'Track to Conic Hill. Conic Hill rises above Balmaha village on the eastern shore of Loch Lomond.', 'Aurelijus Vedrickas', 'av_conichill.jpg', 480, 640, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(27, 'Oban', 'View of Oban bay from Douglas castle. On the left Scotland''s west coast, Oban town. Island of Kerrera on the right.', 'Aurelijus Vedrickas', 'av_oban.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(28, 'Central Park, New York', 'This is the view from our hotel that overlooks Central Park. The Park is located in Manhattan, New York. It officially opened in 1874 and is open for the public all year round. It was also designated a National Historic Landmark in 1962.', 'Ben McManus', 'bmcm_centralparknewyork.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(29, 'Sagrada Familia', 'Arguably Barcelona''s most famous building. La Sagrada Familia is a Catholic church designed by the late architect Antoni Gaudi. Construction of the building started in 1882 but has yet to be completed due to the death of Gaudi, Finances and also the Spanish Civil war interrupted progress. It is hoped to be completed by 2026.', 'Ben McManus', 'bmcm_sagradafamilia.jpg', 640, 480, 'Travel', 1, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(30, 'Statue Of Liberty', 'The Statue of Liberty is an enormous sculpture located on Liberty Island, which is in the middle of New York Harbour. It is an icon of freedom for the United States and their people. Much renovation has been done to the sculpture to ensure its longevity. It stands at 93 metres tall (ground to torch).', 'Ben McManus', 'bmcm_statueofliberty.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(31, 'Luss', 'This photo was taken at Luss, a village located at the surroundings of Loch Lomond. It''s a really beautiful place, with old dwellings - some of them built on the 18th and 19th centuries. Most of them have a similar appearance, mixing the greys of their structure with vivid nature colours from the encircling gardens.', 'Bruno Dias', 'bd_luss.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(32, 'Kelvingrove Park', 'The above photo shows a small part of the University of Glasgow in the background, right behind the trees.  It was taken during a walk with friends in the Kelvingrove Park, located in the West End of Glasgow.', 'Bruno Dias', 'bd_kelvingrovepark.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(33, 'Pollok Country Park', 'This photo was taken during a walk on Pollok Country Park, an amazing countryside park that contains walled gardens and extensive woodland. In the background, it''s possible to see the Pollok House, built on the 18th century.', 'Bruno Dias', 'bd_pollokcountrypark.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(34, 'UK Coins', 'It has been 5 years since I came to study in the UK. Throughout these years I have travelled to different parts of this country and the first thing that came into my mind is to collect coins. I was pretty lonely when I first came to Glasgow and hardly spoke a proper sentence in English. One day I realised the UK coins are engraved with different pictures and these pictures represent famous places, historical characters as well as special events. As a result, I spent my time walking around this foreign place to explore the places shown on the coins and to learn more about the history of UK. This has gradually become my first hobby in UK and yet I am still in the process of collecting them today.', 'Chin Pok Wong Codly', 'cpwc_ukcoins.jpg', 640, 480, 'Collectibles', 3, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(35, 'Violet', 'This is my plant, violet which I bought it in Tesco during my second year in Glasgow. I have been taking care of it for over the 4 years. Growing the plant from just two pieces of leaves until it grew into plenty of flowers. It withered last summer when I went back to Hong Kong as no one was taking care of it. However, I did not give up on it and continue watering violet for almost a year. Finally, the flowers grew again in June and the plant is getting healthier up until today. This has given me a feeling of self-accomplishment.', 'Chin Pok Wong Codly', 'cpcw_violet.jpg', 640, 480, 'Nature', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(36, 'Alohan', 'This is my little marionette I called it Alohan. It was handmade by me when I was 8 years old. I have been keeping it for 23 years and bringing it with me everywhere I go. Today it is hanging on my bedroom door handle in my student accommodation. Every time when I am looking at it, it reminds me of my childhood. I was an extremely naughty boy doing lots of ridiculous things to my teachers and friends. I got bullied by classmates very often because I was too small in size and couldn''t fight back. The most unforgettable silly thing that I have done to defence myself was biting others butt. Anyway, I enjoyed my art class very much and that was the only section that I really behaved myself.', 'Chin Pok Wong Codly', 'cpcw_alohan.jpg', 480, 640, 'Collectibles', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(37, 'Labrador', 'My Labrador Biskit, enjoying a long walk around the countryside surrounding my village, Neilston, on a clear summers day.', 'Christopher Collins', 'cc_labrador.jpg', 640, 480, 'Nature', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(38, 'Thistle', 'I took this image with my phone while testing the macro mode. I was surprised to see how well it turned out. It shows the bee looking like a predator when actually it isn''t. ', 'Christopher Collins', 'cc_thistle.jpg', 640, 480, 'Nature', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(39, 'Statue Of Liberty', 'This was taken while in New York in September 2010. I was slightly disappointed in the statue as it actually isn''t as big as I thought it would be. Although it does stand dominant on it''s own island.', 'Christopher Collins', 'cc_statueofliberty.jpg', 480, 640, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(40, 'Glasgow Clouston Street 1985', 'Glasgow Clouston Street 1985 on a snowy day - picture taken from Flickr and under rights it says this image can be shared.', 'Christopher MacKinnon', 'cmack_glasgowcloustonstreet1985.jpg', 640, 480, 'Weather', 1, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(41, 'Royal Staircase', 'A royal staircase leading upwards,hanging above is a chandelier and in the middle are some paintings', 'Christopher MacKinnon', 'cmack_royalstaircase.jpg', 4288, 2848, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(42, 'Ngon Ping Memorial', 'The Ngon Ping Memorial in Hong Kong - found in stockvault and had no copyright issues contained.', 'Christopher MacKinnon', 'cmack_ngonpingmemorial.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(43, 'Citizen M Hotel', 'A street view of Citizen M Hotel; a modern hotel located in Glasgow city centre.', 'Christopher Weir', 'cw_citizenmhotelglasgow.jpg', 640, 480, 'Travel', 2, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(44, 'Kelvingrove Skatepark', 'Kelvingrove skatepark situated in Glasgow''s West End with Kelvingrove Art Gallery and Museum visible in the background.', 'Christopher Weir', 'cw_kelvingroveskatepark.jpg', 640, 480, 'Sports', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(45, 'Bearded Dragon', 'A young, female central bearded dragon perched on a small log inside its vivarium.', 'Christopher Weir', 'cw_beardeddragon.jpg', 640, 480, 'Nature', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(46, 'Broadwood-Fireworks', 'This is an image I took last year at my local fireworks display on Guy Fawkes night. It''s the Broadwood fireworks display, mirrored by the water of a small reservoir below. The night is lit by the fireworks and lights of my hometown, Cumbernauld.', 'Dale Carslaw', 'dc_broadwoodfireworks.jpg', 640, 480, 'Celebration', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(47, 'Heteroscodra-Maculata', 'This is a particularly fearsome species of tarantula, infamous for its speed and debilitating venom. It''s commonly known as the ''Togo Starburst Baboon'' and found in Togo, West Africa. This is a male shown in the photograph, brownish in colour and quite small for an adult tarantula measuring only four inches in leg span. Females are sexually dimorphic and appear snow white with strongly contrasted black markings. Females are also slightly larger, reaching sizes from five to six inches.', 'Dale Carslaw', 'dc_heteroscodramaculata.jpg', 640, 480, 'Nature', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(48, 'Plumed Basilisk', 'Commonly known as the Plumed basilisk, this is a very unique species of lizard. This species lives near river beds in rainforest areas with a range from Mexico to Ecuador.  This species became infamously known as the ''Jesus Christ Lizard''. It was named this because it has the ability to run across the surface of water at great speed.  This is achieved with its uniquely shaped feet and light body.', 'Dale Carslaw', 'dc_plumedbasilisk.jpg', 640, 480, 'Nature', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(49, 'Brandenburg Gate', 'Brandenburg Gate, located in Berlin. One of the most well -known landmarks in Germany.', 'Dane McLaren', 'dmcl_brandenburggate.jpg', 640, 480, 'Travel', 2, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(50, 'Olympiastadion', 'The Olympic Stadium was originally built and opened in 1936 for the Olympic games. It has since went on to have several renovations throughout the years, most recently 2006 for the World Cup.\r\nIt has been the host of various sports events, such as being one of the venues during the 2006 world cup and it will also host the 2015 Champions League final.', 'Dane McLaren', 'dmcl_olympiastadion.jpg', 640, 480, 'Sports', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(51, 'Berlin Cathedral', 'The Berlin Cathedral is located in the tourist area "Museum Island" and is a popular tourist attraction. Although referred to as a cathedral, it has never been used as a traditional cathedral as a it has never been the seat of a bishop.', 'Dane McLaren', 'dmcl_berlincathedral.jpg', 640, 480, 'Travel', 1, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(52, 'Angel Of The North', 'The angel of the north is a sculpture, created by Antony Gormley and is found in Gateshead England.', 'Daniel Watson', 'dw_angelofthenorth.jpg', 631, 375, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(53, 'Beach, Scarborough', 'Picture of the beach at Scarborough, north Yorkshire, England', 'Daniel Watson', 'dw_beachscarborough.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(54, 'Tyne Bridge', 'Tyne bridge in Newcastle it connects new castle and Gateshead', 'Daniel Watson', 'dw_tynebridge.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(55, 'The Rogers Centre', 'The Toronto Blue Jays taking on the Kansas City Royals, the Blue Jays are batting whilst the Royals are pitching. The shot is taken inside the home of the Toronto Blue Jays, The Rogers Centre.', 'Daryn Ballantine', 'db_therogerscentre.jpg', 300, 300, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(56, 'CN Tower', 'Looking up at "the world''s tallest free-standing tower" which is the CN Tower, from the ground on a sunny afternoon.', 'Daryn Ballantine', 'db_cntower.jpg', 480, 640, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(57, 'Niagara Falls', 'Ascending on a lift looking over Niagara Falls one of the biggest tourist attractions in the whole of Canada.', 'Daryn Ballantine', 'db_niagarafalls.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(58, 'Rollercoaster, Blackpool Pleasure Beach', 'People upside down on the rollercoaster, Infusion, at the Blackpool Pleasure Beach.', 'David Stevenson', 'ds_rollercoasterblackpoolpleasurebeach.png', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(59, 'Three Wheeled Motorbike', 'Three wheeled motorbike with three seats at a motorbike show in Blackpool.', 'David Stevenson', 'ds_threewheeledmotorbike.png', 640, 480, 'Transport', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(60, 'Blackpool Tower', 'The Blackpool Tower in Blackpool also in the process of being renovated.', 'David Stevenson', 'ds_blackpooltower.png', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(61, 'Sunset, Largs', 'Sunset in Largs.', 'Dawn Stoddart', 'decs_sunsetlargs.jpg', 416, 308, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(62, 'Blizzard, Largs', 'Blizzard in Largs', 'Dawn Stoddart', 'decs_blizzardlargs.jpg', 416, 312, 'Weather', 2, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(63, 'Holiday in Bulgaria', 'Holiday in Bulgaria', 'Dawn Stoddart', 'decs_holidayinbulgaria.jpg', 555, 312, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(64, 'SSE Hydro', 'This is an image of the newly built SSE Hydro which has just been opened beside the SECC. This is Scotland''s largest venue and seats 12,000. This image is from opening night where Rod Stewart was playing. The building is lit up on the outside with the colours of blue and green and has spot lights shooting out it and can be seen in the sky.', 'Fiona Lucas', 'fl_ssehydro.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(65, 'Goat Fell', 'This is an image taken from the mountain of Goat Fell which is located in Arran and is the highest peak of the island. The image shows the mountains ridges and clouds are visible due to the height. In the background you are able to see Mull of Kintyre and behind that you can see the outline of the coast of Ireland.', 'Fiona Lucas', 'fl_goatfell.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(66, 'Tobermory', 'This is an image of part of the main street of Tobermory. This area would also be seen in the television show Balamory. The image shows a few houses which are coloured which is what attracts tourists to the area and what Tobermory is famous for.', 'Fiona Lucas', 'fl_tobermory.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(67, 'Pinawalla Elephant Sanctuary, Sri Lanka', 'Bathing elephants in a river at Pinawalla Elephant Sanctuary, Sri Lanka', 'Gary Arbuckle', 'ga_pinawallaelephantsanctuarysrilanka.jpg', 640, 480, 'Nature', 4, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(69, 'Forth Rail Bridge', 'Forth Rail Bridge over the river Forth,Scotland in winter', 'Gary Arbuckle', 'ga_forthrailbridge.jpg', 640, 480, 'Travel', 1, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(70, 'Prayer Candles, Buddhist Temple', 'Prayer candles at the Wat Phra That Doi Suthep Buddhist temple in Chiang Mai Province, Thailand.  The temple is located on top of the Doi Suthep Mountain and is located 15km from the city of Chiang Mai.', 'Geraldine Steele', 'gems_prayercandlesbuddhisttemple.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(71, 'Beach, Koh Samui, Thailand', 'A beautiful beach just behind the Samui Natien Resort in Koh Samui, Thailand. Looking out you can see the local fisherman boats sitting in the shallow water of the beach.', 'Geraldine Steele', 'gems_beachkohsamuithailand.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(72, 'Beach, Ang Thong National Marine Park', 'A beautiful beach at the Ang Thong National Marine Park in Koh Samui, Thailand. It looks out onto several islands in the park and offers many activities for tourists, such as canoeing and snorkelling. ', 'Geraldine Steele', 'gems_beachangthongnationalmarinepark.jpg', 640, 480, 'Travel', 2, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(73, 'Canal, Amsterdam', 'This is an image of a Canal in Amsterdam Centre. The canals link together most of the streets and are populated with many pedal boats, boat tours, and houseboats you can rent to stay in on your holiday.', 'Gillian Cameron', 'gc_canalamsterdam.jpg', 480, 640, 'Travel', 2, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(74, 'Jim Morrison''s Grave', 'Jim Morrison''s Grave in Pere Lachaise Cemetery, in Paris. This is the largest graveyard in Paris, and Oscar Wilde is also buried here.', 'Gillian Cameron', 'gc_jimmorrisonsgrave.jpg', 480, 640, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(75, 'Eiffel Tower', 'This is the Eiffel Tower in the centre of Paris. From the top platform the view stretches for 50 metres.', 'Gillian Cameron', 'gc_eiffeltower.jpg', 480, 640, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(76, 'Great Wall Of China', 'This picture shows an ancient wall in China known as the Great Wall of China. The wall is 8,851.5 kilometre long which begins at the Jiayuguan Pass of Gansu Province which is in the west and ends at the Shanhaiguan Pass of Hebei Province which is in the east. The Great wall  of China is also one of the seven wonders of the world, a strong symbol of the Chinese nation and its culture. There are a number of myths involving the builder of the wall, some say emperor Qin Shihuang built the wall while others say it was built by slaves.', 'Henna Mohammed', 'hm_greatwallofchina.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(77, 'Tower Bridge, London', 'The Tower Bridge is both a bascule bridge and a suspension bridge in London which crosses the Rover Thames. The plans for the bridge were taking place during 1876 when the east of London was becoming extremely crowded which meant that the bridge was necessary. Eighteen years later, the construction of the bridge had finished. It took five contractors and 450 workers to construct the bridge. Each deck of the bridge can be opened to an angle of 83 degrees. It has been in use since its completion in 1894.', 'Henna Mohammed', 'hm_towerbridgelondon.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(78, 'Victoria Falls', 'Victoria Falls is a waterfall in Southern Africa at the border of Zambia and Zimbabwe. It has often been referred to as one of the most remarkable natural wonders of the world. It is locally referred to as Mosi-oa-Tunya which is translated to "the smoke that thunders". Victoria falls is 1,708 meters wide which makes it the largest curtain of water in the world. An average of 550,000 cubic metres of water drops over the edge every minute. David Livingstone who was a Scottish missionary and explorer is said to have been the very first European to view Victoria Falls in 1855 from an Island which is now known as Livingstone Island. David Livingston gave the name of his discovery in honour of Queen Victoria.', 'Henna Mohammed', 'hm_victoriafalls.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(79, 'London''s Apple Market', 'London''s Apple Market is located right within the centre of London''s famous Covent Garden. It contains a range of stalls and shops for people to buy top quality goods from. Apple market specializes in shops and stalls such as Antiques, Artwork, Jewellery & Accessories, Fashion and Homeware.', 'Iain Murray', 'im_londonsapplemarket.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(80, 'Aerial View From London Eye', 'The London Eye is a large scale Ferris wheel which overlooks the River Thames and the Houses of Parliament. Then entire structure is approximately 135 metres tall and has a diameter of 120 metres. The structure was formally opened by prime Minister Tony Blair on December 31st 1999. Since opening it has become a major tourist attraction and is one of the best known attractions in London for tourists.', 'Iain Murray', 'im_aerialviewfromlondoneye.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(81, 'Houses Of Parliament', 'The Palace of Westminster is the meeting place of the House of Commons and the House of Lords. Commonly known as the Houses of Parliament named after its tenants, the Palace lies on the Middlesex bank of the River Thames in central London. One of the houses of Parliament most well-known and interesting features is that part of its structure namely the ''Victoria Tower'' when built was the tallest secular structure in the world. ', 'Iain Murray', 'im_housesofparliament.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(82, 'Hogwarts Castle', 'I took this photo when i was on my summer holiday in Orlando, Florida. The castle is a replica of the castle in the Harry Potter films and is in the Universal Studios Islands of Adventure in the new Harry Potter section of the theme park.', 'Iain Sweeney', 'is_hogwartscastle.png', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(83, 'Overview Of Edinburgh', 'I took this photo when i visited edinburgh for a weekend last year when i was in a building there was the fantastic view over edinburgh. From the photo you can see the national gallery of scotland and other historic buildings.', 'Iain Sweeney', 'is_overviewofedinburgh.jpg', 672, 507, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(84, 'By The Water', 'This photo was taken by my mother who gave me permission to use this. She cannot remember exactly where it was taken but it was taken up north in Scotland in June this year on the edge of a lake on a summers day.', 'Iain Sweeney', 'is_bythewater.jpg', 672, 507, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(85, 'Bell''s Bridge', 'Bell''s Bridge is a footbridge spanning the River Clyde in Glasgow connecting SECC with the Science Centre.', 'Jamie Couperwhite', 'jc_bellsbridge.jpg', 680, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(86, 'Saltire Centre', 'The Saltire Centre a modern and stylish library and study area for Glasgow Caledonian University students.', 'Jamie Couperwhite', 'jc_saltirecentre.jpg', 640, 480, 'Travel', 1, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(87, 'Piggy', 'A wee piggybank enjoying his natural habitat.', 'Jamie Couperwhite', 'jc_piggy.jpg', 640, 480, 'Nature', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(88, 'Safari, Kenya', 'This image is of Elephants in the wild which I seen whilst taking a safari trip in Kenya. The safari took place in the Tsavo East National Park, which is located in the city of Mombasa, Kenya. It''s one of the oldest and largest parks in Kenya. It''s home to many wild animals and most famously the big five, which include Elephants, Lions, Buffalos, leopard, rhinoceros. ', 'Kevin Githwe', 'kg_safarikenya.jpg', 640, 480, 'Travel', 3, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(89, 'Mayan Ruins, Mexico', 'This image was taken at the Tulum Mayan ruins in Mexico. This was a pre-Colombian Maya walled city that served as a major port for Coba. It''s located on tall cliffs along the east coast of the Caribbean sea in Mexico. It was one of the cities that was build and occupied by the Mayans around the 13th century. Now it remains as a tourist attraction. ', 'Kevin Githwe', 'kg_mayanruinsmexico.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(90, 'London Eye, UK', 'This image is of the London Eye, which is one of the most iconic tourist attractions in London. It''s best described as a giant Ferris wheel and it''s in fact the tallest Ferris wheel in Europe. It''s visited by over 3.5 million people annually and is the most popular paid tourist attraction in the UK. ', 'Kevin Githwe', 'kg_londoneye.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(91, 'Temple Bar Dragon Boundary Mark', 'A photo of one of the dragon boundary marks of the City of London taken from a bus on a tour of London. This particular mark is the Temple Bar dragon and he differs from the other boundary marks as he is black (the others are silver) and he is gripping his shield with both front legs rather than one. He is standing on a tall patterned pillar on his two back legs and has his mouth open in a snarl which makes him fiercer looking than his silver counterparts.', 'Leanne Waton', 'lw_templebardragonboundarymark.jpg', 480, 640, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(92, 'Gherkin, London', 'A picture of the financial district of London taken from across the Thames. The main purpose of the photo was to get The Gherkin (otherwise known as 30 St Mary Axe) in but, as I was on a tour bus at the time, I got a good photo of the differing shapes, sizes and ages of the surrounding buildings as well.', 'Leanne Waton', 'lw_gherkinlondon.jpg', 480, 640, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(93, 'Blacktip Reef Shark, London Aquarium', 'A picture of a Blacktip Reef shark taken in his tank at London Aquarium. I was taking pictures of the various fish and sharks in the tank when I noticed he was swimming directly towards me and snapped the photo. The tone of the image is dark and gives the picture an almost eerie feel\r\nwhich is added to by the fact that the shark has no other fish around him and has the glass panel at the other side of the tank framing him.', 'Leanne Waton', 'lw_blacktipreefsharklondonaquarium.jpg', 480, 640, 'Travel', 3, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(94, 'River Leukback, Saarburg, Germany', 'The river Leukback is a branch of river running to the West of the greater river, Saar. The Saar crosses through both Germany and France covering a length of 235km. Saarburg is a town of Germany where the Leukback runs through and this image was taken.', 'Louis Cuthbert', 'lc_riverleukbacksaarburggermany.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(95, 'Piazza della Repubblica, Florence', 'Dating from when Florence was under Roman control, the Piazza della Repubblica is situated on the same site as the Roman forum, the exact centre of the city. The present appearance of the square was a result of city planning, which was sparked by the capital city of Italy changing for six years in 1865 (till 1871) to Florence.', 'Louis Cuthbert', 'lc_piazzadellarepubblicaflorence.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(96, 'Trencin, Slovakia', 'As one of the oldest Slovak towns, Trencin was built in a strategic position to allow a castle to be created on the hill top. Today it is an important centre of trade and economy, along with a rich culture.', 'Louis Cuthbert', 'lc_trencinslovakia.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(97, 'New York City Skyline', 'This image is a high point view of the famous New York city skyline with the main focus on the Empire State building. The image is taken on a cloudy afternoon in mid July 2013 from the Rockefeller centre. There are many skyscraper buildings in the image showing that New York is a vibrant busy city with millions of people living and working here. There is also the Hudson river in the far top right corner. The main focus of the image the Empire State building is located in the Manhattan area of New York. You can also see in the distance the nearly completed Freedom Tower.', 'Louise Dunn', 'ld_newyorkcityskyline.jpg', 480, 640, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(98, 'Scott Monument, Edinburgh', 'This image portrays the beautiful Scott monument in Edinburgh. It is taken upon a bridge for the slight upward angle. It shows the monument on a beautiful blue sky day with dark Gray rain clouds appearing in the sky. The monument is on princes street in Edinburgh with a scenic park right on its doorstep with the busy Waverley train station just slightly appearing in the bottom left hand corner of the photograph. There is a lovely contrast of greens from the parks trees and grass and blue from the bright sky.', 'Louise Dunn', 'ld_scottmonumentedinburgh.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(99, 'Universal Logo, Orlando, Florida', 'This is the famous Universal logo seen in all there movies and all over the world. It is a very recognised brand. This is outside there theme park in Orlando, Florida. There logo is the world with "Universal" across it as the world turns in 360 degrees and in this image you can see that they mean universal as in all over the world. There is palm trees in the background. In this image the water is spraying at a wonderful angle when the image was captured. It is a cloudy day and you can see this in the image.', 'Louise Dunn', 'ld_universallogoorlandoflorida.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(100, 'Victoria Square, Birmingham', 'Victoria Square in Birmingham, during the evening includes The River fountain, otherwise known as The Floozie in the Jacuzzi and the Council House.', 'Lucy Hadley', 'lh_victoriasquarebirmingham.jpg', 480, 640, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(101, 'Selfridges, Birmingham', 'Selfridges Department Store in Birmingham and part of the Bullring shopping centre at night.', 'Lucy Hadley', 'lh_selfridgesbirmingham.jpg', 480, 640, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(102, 'Birmingham Shopping Centre', 'Birmingham Shopping Centre, at night. The Bull symbolises the entrance to the city''s two main commercial areas known as The Bullring.', 'Lucy Hadley', 'lh_birminghamshoppingcentre.jpg', 480, 640, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(103, 'Siargao Island,  Surigao Del Norte, Philippines', '21st September, 2012\r\nI went surfing with my uncle for the very first time. I took this spectacular photo just outside our beach villa as soon as we''ve arrived mid-afternoon. The calming breeze of the wind and the warm ocean water would not let me sit around sipping my juice. In fact, after taking this photo I immediately jumped in the water with my shorts on. \r\n\r\nThe object in the left is a coconut tree (which grows around the country due to tropical nature) and object on the right are 2 fishing boats (used by local fishermen in the area). \r\n', 'Mario Garcia', 'mg_siargaoislandphilippines.jpg', 480, 640, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(104, 'Panglao Island Nature Resort, Bohol, Philippines', '3rd June, 2011\r\nOur family trip to Bohol, A once in a lifetime trip. This was taken early morning after heavy rain. The place creates an aroma of relaxation, the swimming pool sits on top of a platform of rocks which gives the illusion of endless overflowing sea water and there is a stairway going down to access the beach. \r\n\r\nThe highlight of my trip is the kayaking offered by the resort. Additionally, the far away hut on the background is accessible by foot during the low tide.', 'Mario Garcia', 'mg_panglaoislandphilippines.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(105, 'White Beach, Boracay Aklan, Philippines', '21st May, 2011\r\nOn our way to white Beach Boracay island and came across another tour boat. The funny thing about this is that both tour boats which we are in are of the same company and that the name of our tour boat is Luigi.\r\n\r\nThe tour boats'' main duties are to pick-up tourists from mainland Aklan and transport them to Boracay beach. It''s a fun 15mins journey wearing our life vests while channelling the calm waters of Aklan.', 'Mario Garcia', 'mg_whitebeachboracayaklanphilippines.jpg', 640, 475, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(106, 'Dor Beetle', 'On holiday I went hillwalking near Charleston, Scotland. Along my travels I came across a "Dor Beetle", these types of beetle are very common, but the striking colour of blue/purple had me captivated the moment I saw it.', 'Martyn Gillett', 'mg_dorbeetle.jpg', 640, 480, 'Nature', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(107, 'Crayola Canvas', 'I bought a large canvas, 2 packets of crayons and a hot glue gun from an Arts & Crafts store in Glasgow. I began gluing the crayons to the canvas with the "Crayola" brand facing upwards; then, with the hot glue gun began blowing hot air downwards at a low speed. The wax from the crayons began to melt, and the gravity allowed the streams of wax to form an appealing pattern. This is the finished product.', 'Martyn Gillett', 'mg_crayolacanvas.jpg', 640, 480, 'Art', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(108, 'Gairloch Holiday', 'My partner and I were planning a holiday up at Gairloch, Scotland. The journey took around 4 hours from East Kilbride; stopping off at Inverness and Dingwall. When we finally reached our destination; I was blown away by the view at our house we were staying. We were fortunate enough to view the once-a-year event... .Summer.', 'Martyn Gillett', 'mg_gairlochholiday.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(109, 'Big Ben', 'This was completed in 1858 and the nickname for this clock tower is called Big Ben and the official name was called the Clock Tower until 2012, it was renamed as Elizabeth Tower to celebrate the Diamond Jubilee.   It is one of the tallest freestanding clock towers and it is located at the Palace of Westminster. Big Ben uses its main bell to chime for every hour and it also uses other bells for every quarter of an hour.', 'Nicholas Tsang', 'nt_bigben.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(110, 'Dunure Castle', 'Dunure Castle was built in the 13th century by Clan Kennedy.  It is located in Scotland, South Ayrshire.  The castle has been rebuilt and strengthened allowing the public to visit. It has been rumored there is a secret passage that connects Dunure Castle to Greenan Castle.', 'Nicholas Tsang', 'nt_dunurecastle.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(111, 'Tower Bridge', 'Tower Bridge is a bascule/suspension bridge completed in 1894 with a total length of 244 metres. It is located in London and it crosses the River Thames.  The bridge is crossed over 35,000 by the public and if the bascule needs to be raised, there must be a 24 hour notice. Taken during the Paralympics as you can see the Logo in the middle of the bridge.', 'Nicholas Tsang', 'nt_towerbridge.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(112, 'Ayr Beach', 'This is an image of Ayr Beach with Arran in the background. It was taken on a rare sunny day in my home town at the beginning of the holidays this year. It shows the sun hitting off the water with a misty Arran. It also shows people playing in the water in the middle of the picture. In front of Arran there is also a boat sailing in the sea.', 'Rachel Queen', 'rq_ayrbeach.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(113, 'London', 'I took this image on a trip to London to visit a friend. It was on a summer''s day when we were walking through a park next to the Palace of Westminister. It shows the British flag flying on the top with trees covering the foreground.', 'Rachel Queen', 'rq_london.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(114, 'Romania', 'This picture was taken up a mountain in Romania during the summer holidays. It shows a river running through the other mountains out of sight of the picture. There are trees in the foreground of the picture which are on the very edge of a ridge on the mountain, above a very steep slope down!', 'Rachel Queen', 'rq_romania.jpg', 640, 480, 'Travel', 1, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(115, 'Blackpool Beach', 'An image of the recently completed improvement of Blackpool beach at tide in. Improvements began in early 2006 and finished November 2011, a 5 year project.', 'Robert Stevenson', 'rs_blackpoolbeach.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(116, 'Coral Island, Blackpool', 'This image is of Coral Island, an amusement arcade in Blackpool. Contains various attractions, slot machines, and holds regular prize bingo sessions.', 'Robert Stevenson', 'rs_coralislandblackpool.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(117, 'View From Blackpool Tower', 'This image was taken from the top of the Blackpool tower. It shows the promenade and south pier.', 'Robert Stevenson', 'rs_viewfromblackpooltower.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(119, 'West Highland Way', 'The West Highland Way is a stretch of long-distance footpaths that begin in Milgavnie, North Glasgow and ends in Fort William, Highlands. Spanning 96 miles, it offers beautiful scenic countryside and culturally historic places of interest.', 'Ross Stewart', 'rs_westhighlandway.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(120, 'Arran', 'Arran (Scots Gaelic: Eilean Arainn) is the largest island off the west coast of Scotland and the seventh largest. A rugged, mountainous paradise, it is home to nearly 5,000 residents and serves many travellers throughout the year, connecting from the mainland.', 'Ross Stewart', 'rs_arran.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(121, 'Philadelphia', 'The first image is a picture taken in 2010 when I went to New York, Washington and Philadelphia with my secondary school for an educational trip. In the image, we are running up the steps in which ''Rocky'' runs up -in the movies- and shadow boxes at the top!', 'Scott Crum', 'sc_philadelphia.jpg', 720, 540, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(122, 'Ibiza', 'The second image is a picture that shows the view from our hotel when me and my friends went to Ibiza in 2012. Unlike Ibiza''s party reputation, this image depicts a tranquil surrounding and a beautiful landscape.', 'Scott Crum', 'sc_ibiza.jpg', 416, 555, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(123, 'Celtic', 'The third image is a picture of the pre-match display, celebrating the 125th anniversary of Celtic Football Club - which the Green Brigade had organised -  at the Celtic v Barcelona match in the UEFA Champions League group stage. This was the 2012/2013 season, which saw Celtic win 2-1. The goals were scored by Victor Wanyama, Tony Watt and Lionel Messi.', 'Scott Crum', 'sc_celtic.jpg', 480, 640, 'Sports', 2, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(124, 'Trevi Fountain', 'A photo looking onto the Trevi Fountain in Rome, Italy at night', 'Shawnee Henry', 'sh_trevifountain.jpeg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(125, 'Colosseum', 'A photo taken from inside the Colosseum looking into the main arena on a summers day', 'Shawnee Henry', 'sh_colosseum.jpeg', 640, 480, 'Travel', 3, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(126, 'River Tiber', 'A photo taken from on a bridge looking onto the River Tiber and the surrounding area.', 'Shawnee Henry', 'sh_rivertiber.jpeg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(127, 'Budapest', 'During a wander around the city of Budapest, on the Buda side, my friend and I found a street filled with colourful homes leading to a grand building with a decorative roof. This picture was taken mid May 2013.', 'Sophie Bannerman', 'sb_budapest.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(128, 'Vienna', 'This image is a view over the Danube River in Vienna. At this point of the Danube, there''s an island in the middle that has a beach, a number of cafes and is a popular area to sunbathe. The modern buildings making up the background are part of the Donaustadt area.', 'Sophie Bannerman', 'sb_vienna.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(129, 'Durness', 'This was taken a few miles away from Durness on a secluded beach, Balnakeil Bay. The image focuses on the rock formation and untouched sand.', 'Sophie Bannerman', 'sb_durness.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(130, 'Monkeys, India', 'This photo was taken on a university trip to India, this trip was not only memorable it was also life changing.', 'Stacey Docherty', 'sd_monkeysindia.jpg', 640, 480, 'Nature', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(131, 'Dragonfly, India', 'This photo was also taken on a trip to India; this dragonfly was extremely beautiful.', 'Stacey Docherty', 'sd_dragonflyindia.jpg', 640, 480, 'Nature', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(132, 'Bird, India', 'This photo was also taken on a trip to India with the university. This bird was extremely inquisitive and this was a great photo opportunity.', 'Stacey Docherty', 'sd_birdindia.jpg', 640, 480, 'Nature', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(133, 'Haul Road Reservoir', 'This is a photo I took myself last summer. It is of a reservoir which is located just off Haul Road, near Garelochhead which is close by to where I live. This is my favourite photo that I have taken and use it for my desktop background. I feel the photo captures the beautiful scenery of the Scottish countryside in summer.', 'Stephen Mauchan', 'sm_haulroadreservoir.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(134, 'Celtic vs Barcelona', 'Again this is another I photo I took before Celtic beat Barcelona 2-1 on 7th November 2012. This was probably Celtic second most famous victory in their 125th year of existent which was coincidentally celebrated the night before.', 'Stephen Mauchan', 'sm_celticvsbarcelona.jpg', 640, 480, 'Sports', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(135, 'Can Of Irn Bru', 'This is simply just a photo that I took which I really admire. It is of a can of Irn Bru which is manufactured by A.G. Barr. It was first created in 1901 in Falkirk and since then it has expanded to become the most successful soft drink in Scotland and the 3rd most successful in the UK, behind Coca-Cola and Pepsi.', 'Stephen Mauchan', 'sm_canofirnbru.jpg', 640, 480, 'Food', 3, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(136, 'The Capitol building, Washington DC', 'The Capitol building, Washington DC', 'Thomas McCarthy', 'tmcc_capitolbuildingwashingtondc.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(137, 'V1 Doodlebug, Smithsonian, Washington DC', 'This is a picture of a V1 "doodlebug" flying bomb from the Smithsonian Air and Space museum in Washington DC.', 'Thomas McCarthy', 'tmcc_v1doodlebugsmithsonianwashingtondc.jpg', 640, 480, 'Transport', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(138, 'International Docking Unit, Smithsonian', 'The International Docking Unit test, allowing American Apollo and Russian Soyuz capsules to dock in preparation for the International Space Station in the Smithsonian Air and Space museum in Washington DC.', 'Thomas McCarthy', 'tmcc_internationaldockingunitsmithsonianwashingtondc.jpg', 640, 480, 'Transport', 2, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(139, 'Dunure Beach', 'This is an image taken at Dunure beach on a summer evening. Dunure beach is situated on the coast and at certain points of the beach, if the weather is clear enough, you can see Ireland in the distance.  The beach is also situated along from the electric brae.', 'Stuart Milne', 'sm_dunurebeach.png', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(141, 'Ben Nevis', 'This is an image taken about three quarters of the way up Ben Nevis. There was a lake just towards the bottom left of the image above, there were a few boats in the lake that looked like they were used for fishing. Cloudy weather and very windy at the time made the last quarter of climbing feel like eternity to reach the top.', 'Stuart Milne', 'sm_bennevis.png', 640, 480, 'Travel', 2, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(142, 'George & The Dragon', 'Statue of George and the Dragon', 'Ross Cook', 'rc_georgeandthedragon.jpg', 480, 640, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(143, 'Peacock Metalwork', 'Metalwork shaped to be a peacock', 'Ross Cook', 'rc_peacockmetalwork.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(144, 'Artistic Bridge, Glasgow', 'Artistic bridge in Glasgow', 'Ross Cook', 'rc_artisticbridgeglasgow.jpg', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(145, 'Iraq At A Glance', 'Iraq is one of the Arabic states which located in the west south of the Asian continent, to the north of Kuwait & Saudi Arabia, to the south of Turkey, to the east of Syria and Jordan and to the west of Iran. Iraq has more than one seaport on the Arabian Gulf but the most important is Umm Qasr. The two rivers "Tigris" and "Euphrates" passes from the north of country to the south where the merge together to form Shatt al-Arab.', 'Shatha Hameed', 'sh_iraqataglance.gif', 480, 526, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(146, 'Baghdad', 'Baghdad is the capital of Iraq, with an estimated population between 7 and 7.5 million, it is the largest city in Iraq. \r\nThe name of Baghdad used to evoke images of Arabian Nights. The fairytale city it once was, capital of the Abbasid Caliphate, was destroyed by the Mongol invaders in 1258. Baghdad did recover and has always played an important role in Arab cultural life and has been the home of noted writers, musicians and visual artists.\r\nThere are still a lot of impressive monuments in Baghdad are worth a visit.', 'Shatha Hameed', 'sh_baghdad.gif', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(147, 'Mosul', 'Mosul, 400 km north of Baghdad, is Iraq''s 2nd largest city, a center for the tourist resorts of northern Iraq. It is called Um Al-Rabi''ain (The City of Two Springs), because autumn and spring are very much alike there.\r\nThe original city stands on the west bank of the Tigris River, opposite the ancient Assyrian city of Nineveh on the east bank, but it has now grown to encompass substantial areas on both banks, with five bridges linking the two sides', 'Shatha Hameed', 'sh_mosul.gif', 640, 480, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(176, 'Nikola Telsa', 'Celebration of rthe 157th birthday of Nikola Tesla, Serbian American inventor, electrical engineer, mechanical engineer, physicist, and futurist best known for his contributions to the design of the modern alternating current electricity supply system.', 'Alexandre Franca', 'Nikola-Tesla-2.jpg', 300, 300, 'Celebration', 4, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(179, 'Gremio Football  Club', 'Gremio was founded by English and German immigrants on September 15, 1903. Major titles captured by Gremio include one Intercontinental Cup, two Copa Libertadores de America, two national championships and four national cups. Gremio plays in a tricolor (blue, white and black) striped shirt, black shorts and white socks (first kit).', 'Alexandre Franca', 'Gremio.png', 300, 300, 'Travel', 5, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(180, 'Solo Climbing', 'Alexander J. Honnold (born August 17, 1985) is an American rock climber best known for his free solo ascents of big walls. He has broken a number of speed records, most notably the only known solo climb (95% free climbing with a few points of aid) of the Yosemite Triple crown, an 18 hour 50 minute link up of Mount Watkins, The Nose, and the Regular Northwest Face of Half Dome.[1]', 'Alexander Honnold', 'alex_honnold.jpg', 300, 300, 'Sports', 4, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(181, 'Snowboarding', 'Snowboarding is a winter sport that involves descending a slope that is covered with snow while standing on a board attached to a riders feet, using a special boot set onto a mounted binding.', 'Travis Rice', 'snowboard-1.jpg', 300, 300, 'Sports', 5, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(182, 'Nazca Lines', 'The Nazca Lines are a series of ancient geoglyphs located in the Nazca Desert in southern Peru. They were designated as a UNESCO World Heritage Site in 199', 'Cinthya Ventocilla', 'nascar_lines.jpg', 300, 300, 'Travel', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(183, 'Icelandic Horse', 'The Icelandic horse is a breed of horse developed in Iceland. Although the horses are small, at times pony-sized, most registries for the Icelandic refer to it as a horse. Icelandic horses are long-lived and hardy. ', 'Wikipedia', 'Icelandic_Horse.jpg', 300, 300, 'Travel', 4, 1);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(184, 'Pampa horse', 'The Pampa horse is a breed of horses from Brazil. It is an extremely obedient horse which is suitable for all uses. The Associacao de Cavalo Pampa (Association of the Pampa horse) is located in Belo Horizonte. The minimum height is 1.50m for males and 1.45m for females', 'Wikipedia', 'pampa_horse.jpg', 300, 300, 'Travel', 15, 4);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(185, 'Aurora Borealis', 'An aurora is a natural light display in the sky particularly in the high latitude regions, caused by the collision of energetic charged particles with atoms in the high altitude atmosphere', 'Wikipedia', 'aurora_borealis.jpg', 300, 300, 'Nature', 0, 0);
INSERT INTO `image` (`image_id`, `image_title`, `image_description`, `image_contributor`, `image_url`, `width`, `height`, `category`, `sum_ratings`, `no_ratings`) VALUES(186, 'Helicoter Jump', 'Helicopter jump performed by Travis Rice in a documentary in Alaska', 'Travis Rice', 'helicopter.jpg', 300, 300, 'Sports', 12, 3);

-- --------------------------------------------------------

--
-- Table structure for table `image_tag`
--

DROP TABLE IF EXISTS `image_tag`;
CREATE TABLE IF NOT EXISTS `image_tag` (
  `image_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`image_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `image_tag`
--

INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(3, 3);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(3, 64);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(3, 653);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(3, 654);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(3, 655);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(4, 4);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(4, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(4, 6);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(4, 7);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(4, 8);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(4, 9);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(4, 10);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(4, 11);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(4, 12);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(5, 4);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(5, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(5, 8);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(5, 9);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(5, 13);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(5, 14);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(5, 15);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(5, 16);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(5, 17);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(5, 18);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(7, 4);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(7, 9);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(7, 28);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(7, 29);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(7, 30);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(8, 31);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(8, 32);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(8, 33);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(8, 34);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(8, 35);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(9, 3);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(9, 36);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(9, 37);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(9, 38);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(9, 39);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(10, 40);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(10, 41);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(10, 42);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(10, 43);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(10, 44);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(10, 45);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(10, 46);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(10, 47);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(10, 48);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(11, 42);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(11, 47);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(11, 49);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(11, 50);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(11, 51);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(11, 52);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(11, 53);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(11, 54);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(11, 55);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(12, 47);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(12, 51);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(12, 52);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(12, 56);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(12, 57);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(12, 58);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(13, 53);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(13, 59);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(13, 60);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(13, 61);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(13, 62);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(13, 63);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(14, 64);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(14, 65);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(14, 66);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(14, 67);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(14, 68);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(14, 69);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(14, 70);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(15, 29);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(15, 42);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(15, 71);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(15, 72);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(15, 73);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(16, 29);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(16, 74);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(16, 75);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(16, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(16, 77);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(16, 78);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(16, 79);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(17, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(17, 14);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(17, 29);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(17, 38);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(17, 80);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(17, 81);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(18, 38);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(18, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(18, 82);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(18, 83);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(18, 84);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(19, 29);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(19, 85);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(19, 86);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(19, 87);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(20, 86);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(20, 88);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(20, 89);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(20, 90);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(21, 75);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(21, 90);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(21, 91);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(21, 92);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(22, 93);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(22, 94);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(22, 95);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(22, 96);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(22, 97);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(22, 98);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(23, 99);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(23, 100);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(23, 101);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(24, 102);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(24, 103);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(24, 104);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(25, 42);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(25, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(25, 86);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(25, 533);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(25, 534);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(25, 535);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(25, 536);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(25, 537);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(25, 538);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(26, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(26, 80);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(26, 86);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(26, 154);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(26, 377);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(26, 493);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(26, 535);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(26, 538);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(26, 539);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(26, 540);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(26, 541);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(27, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(27, 83);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(27, 86);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(27, 226);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(27, 264);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(27, 538);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(27, 542);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(27, 543);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(27, 544);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(27, 545);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(27, 546);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(27, 547);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(28, 3);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(28, 4);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(28, 35);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(28, 53);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(28, 154);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(28, 158);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(29, 35);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(29, 38);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(29, 192);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(29, 196);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(29, 460);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(29, 461);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(29, 548);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(30, 28);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(30, 32);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(30, 38);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(30, 152);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(30, 432);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(30, 549);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(31, 38);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(31, 80);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(31, 105);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(31, 106);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(31, 107);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(31, 108);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(32, 16);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(32, 109);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(32, 110);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(32, 111);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(32, 112);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(33, 53);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(33, 107);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(33, 108);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(33, 113);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(33, 114);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(34, 115);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(35, 116);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(36, 117);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(37, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(37, 17);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(37, 118);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(37, 119);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(37, 120);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(37, 121);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(38, 53);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(38, 122);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(38, 123);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(38, 124);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(38, 125);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(39, 4);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(39, 32);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(39, 126);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(39, 127);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(39, 128);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(39, 129);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(40, 45);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(40, 130);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(40, 131);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(40, 132);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(40, 133);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(40, 134);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(40, 135);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(41, 12);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(41, 132);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(41, 133);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(41, 134);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(41, 135);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(41, 136);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(41, 137);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(41, 138);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(41, 139);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(42, 7);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(42, 140);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(42, 141);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(42, 142);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(42, 143);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(43, 30);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(43, 38);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(43, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(43, 129);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(43, 130);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(43, 144);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(43, 145);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(43, 146);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(43, 147);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(43, 148);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(43, 149);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(43, 150);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(43, 151);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(43, 152);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(43, 153);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(44, 38);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(44, 47);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(44, 53);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(44, 109);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(44, 130);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(44, 154);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(44, 155);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(44, 156);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(44, 157);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(44, 158);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(44, 159);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(44, 160);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(44, 161);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(44, 162);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(44, 163);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(45, 53);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(45, 121);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(45, 164);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(45, 165);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(45, 166);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(45, 167);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(45, 168);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(45, 169);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(45, 170);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(45, 171);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(45, 172);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(45, 173);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(45, 174);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(45, 175);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(45, 176);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(46, 250);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(46, 477);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(46, 516);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(46, 517);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(46, 518);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(46, 519);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(46, 520);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(47, 521);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(47, 522);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(47, 523);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(47, 524);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(47, 525);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(47, 526);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(47, 527);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(47, 528);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(48, 166);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(48, 529);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(48, 530);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(48, 531);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(48, 532);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(49, 35);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(49, 37);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(49, 127);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(49, 129);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(49, 177);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(49, 178);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(49, 179);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(49, 180);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(49, 181);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(49, 182);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(50, 37);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(50, 129);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(50, 177);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(50, 183);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(50, 184);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(50, 185);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(50, 186);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(50, 187);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(50, 188);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(50, 189);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(50, 190);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(50, 191);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(51, 127);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(51, 129);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(51, 177);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(51, 192);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(51, 193);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(51, 194);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(51, 195);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(51, 196);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(51, 197);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(51, 198);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(52, 32);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(52, 199);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(52, 200);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(52, 201);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(52, 202);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(52, 203);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(52, 204);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(52, 205);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(52, 206);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(52, 207);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(53, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(53, 90);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(53, 207);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(53, 208);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(53, 209);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(53, 210);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(53, 211);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(53, 212);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(54, 206);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(54, 207);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(54, 213);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(54, 214);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(55, 215);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(55, 216);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(55, 217);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(55, 218);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(55, 219);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(55, 220);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(55, 221);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(56, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(56, 221);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(56, 222);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(56, 223);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(56, 224);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(56, 225);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(57, 129);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(57, 223);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(57, 224);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(57, 226);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(57, 227);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(57, 228);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(58, 69);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(58, 229);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(58, 230);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(58, 231);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(58, 232);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(58, 233);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(59, 234);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(59, 235);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(59, 236);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(59, 237);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(59, 238);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(60, 208);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(60, 239);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(60, 240);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(60, 241);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(60, 242);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(60, 243);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(60, 244);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(60, 245);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(61, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(61, 75);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(61, 86);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(61, 90);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(61, 208);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(61, 224);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(61, 228);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(61, 246);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(61, 247);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(61, 248);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(61, 249);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(61, 250);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(62, 45);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(62, 131);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(62, 154);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(62, 201);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(62, 251);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(62, 252);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(63, 9);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(63, 90);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(63, 148);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(63, 208);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(63, 224);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(63, 228);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(63, 246);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(63, 253);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(63, 254);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(63, 255);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(63, 256);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(63, 257);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(64, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(64, 130);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(64, 258);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(64, 259);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(64, 260);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(64, 261);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(64, 262);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(64, 263);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(65, 42);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(65, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(65, 122);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(65, 249);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(65, 264);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(65, 265);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(65, 266);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(65, 267);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(66, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(66, 226);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(66, 250);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(66, 268);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(66, 269);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(66, 270);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(66, 271);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(67, 62);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(67, 175);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(67, 226);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(67, 272);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(67, 273);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(67, 274);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(67, 275);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(67, 276);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(69, 62);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(69, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(69, 131);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(69, 245);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(69, 282);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(69, 283);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(69, 284);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(69, 285);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(69, 286);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(69, 287);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(69, 288);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(69, 289);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(70, 56);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(70, 290);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(70, 291);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(70, 292);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(70, 293);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(70, 294);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(71, 56);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(71, 208);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(71, 226);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(71, 246);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(71, 295);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(71, 296);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(72, 56);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(72, 208);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(72, 226);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(72, 246);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(72, 264);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(72, 295);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(72, 296);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(72, 297);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(73, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(73, 9);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(73, 30);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(73, 295);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(73, 298);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(73, 299);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(73, 300);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(73, 301);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(73, 302);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(73, 303);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(74, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(74, 40);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(74, 259);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(74, 304);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(74, 305);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(74, 306);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(74, 307);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(74, 308);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(74, 309);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(74, 310);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(74, 311);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(75, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(75, 35);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(75, 40);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(75, 129);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(75, 310);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(75, 312);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(75, 313);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(76, 3);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(76, 29);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(76, 33);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(76, 38);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(76, 127);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(76, 143);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(76, 226);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(76, 303);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(76, 550);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(76, 551);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(76, 552);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(76, 553);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(76, 554);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(77, 38);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(77, 393);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(77, 446);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(77, 447);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(77, 458);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(77, 555);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(77, 556);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(77, 557);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(78, 33);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(78, 53);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(78, 63);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(78, 127);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(78, 226);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(78, 558);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(78, 559);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(78, 560);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(78, 561);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(78, 562);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(78, 563);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(78, 564);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(78, 565);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(78, 566);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(78, 567);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(78, 568);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(79, 3);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(79, 84);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(79, 314);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(79, 315);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(79, 316);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(80, 19);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(80, 127);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(80, 314);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(80, 317);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(80, 318);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(80, 319);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(80, 320);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(81, 321);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(81, 322);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(81, 323);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(81, 324);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(81, 325);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(82, 326);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(82, 327);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(82, 328);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(82, 329);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(82, 330);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(82, 331);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(83, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(83, 84);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(83, 95);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(83, 162);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(83, 280);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(83, 332);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(84, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(84, 12);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(84, 226);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(84, 333);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(84, 334);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(84, 335);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(85, 62);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(85, 78);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(85, 86);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(85, 393);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(85, 569);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(86, 150);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(86, 570);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(86, 571);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(86, 572);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(86, 573);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(87, 574);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(87, 575);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(87, 576);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(87, 577);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(87, 578);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(88, 125);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(88, 175);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(88, 272);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(88, 297);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(88, 336);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(88, 337);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(88, 338);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(88, 339);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(88, 340);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(88, 341);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(89, 127);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(89, 129);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(89, 342);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(89, 343);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(89, 344);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(89, 345);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(90, 129);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(90, 207);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(90, 313);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(90, 314);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(90, 317);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(90, 346);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(90, 347);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(91, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(91, 9);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(91, 32);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(91, 35);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(91, 129);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(91, 207);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(91, 314);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(91, 348);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(91, 349);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(91, 350);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(91, 351);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(92, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(92, 9);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(92, 35);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(92, 38);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(92, 129);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(92, 207);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(92, 314);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(92, 351);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(92, 352);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(92, 353);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(92, 354);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(92, 355);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(93, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(93, 9);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(93, 129);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(93, 207);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(93, 226);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(93, 314);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(93, 351);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(93, 356);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(93, 357);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(93, 358);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(93, 359);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(93, 360);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 37);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 62);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 126);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 155);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 212);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 226);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 250);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 255);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 302);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 361);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 362);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 363);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 364);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 365);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 366);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 367);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 368);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 369);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 370);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(94, 371);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(95, 40);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(95, 126);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(95, 129);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(95, 363);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(95, 365);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(95, 372);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(95, 373);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(95, 374);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(95, 375);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(96, 20);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(96, 23);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(96, 45);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(96, 83);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(96, 126);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(96, 128);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(96, 149);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(96, 250);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(96, 362);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(96, 363);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(96, 376);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(96, 377);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(96, 378);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(96, 379);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 4);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 8);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 28);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 30);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 34);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 35);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 62);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 145);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 380);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 381);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 382);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 383);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 384);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 385);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 386);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 387);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 388);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 389);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 390);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(97, 391);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 14);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 29);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 84);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 85);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 95);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 127);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 129);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 154);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 158);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 196);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 255);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 322);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 392);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 393);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 394);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 395);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 396);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(98, 397);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(99, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(99, 8);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(99, 28);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(99, 85);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(99, 226);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(99, 328);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(99, 329);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(99, 398);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(99, 399);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(99, 400);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(99, 401);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(99, 402);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(99, 403);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(99, 404);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(99, 405);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(99, 406);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(99, 407);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(100, 207);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(100, 408);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(100, 409);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(100, 410);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(100, 411);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(100, 412);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(100, 413);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(101, 26);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(101, 35);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(101, 38);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(101, 207);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(101, 414);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(101, 415);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(101, 416);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(101, 417);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(102, 26);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(102, 204);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(102, 207);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(102, 410);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(102, 417);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(102, 418);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(102, 419);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(102, 420);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(103, 208);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(103, 421);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(103, 422);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(103, 423);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(103, 424);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(103, 425);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(103, 426);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(103, 427);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(104, 9);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(104, 421);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(104, 422);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(104, 428);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(104, 429);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(104, 430);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(104, 431);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(104, 432);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(105, 9);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(105, 421);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(105, 422);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(105, 433);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(105, 434);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(105, 435);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(105, 436);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(105, 437);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(105, 438);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(106, 53);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(106, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(106, 126);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(106, 237);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(106, 569);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(106, 579);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(106, 580);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(106, 581);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(106, 582);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(106, 583);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(106, 584);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(107, 19);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(107, 203);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(107, 237);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(107, 245);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(107, 569);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(107, 577);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(107, 585);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(107, 586);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(107, 587);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(107, 588);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(107, 589);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(107, 590);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(107, 591);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(107, 592);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(108, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(108, 9);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(108, 16);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(108, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(108, 152);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(108, 208);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(108, 281);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(108, 377);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(108, 590);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(108, 593);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(108, 594);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(108, 595);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(108, 596);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(108, 597);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(109, 207);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(109, 314);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(109, 346);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(109, 439);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(109, 440);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(109, 441);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(110, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(110, 83);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(110, 84);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(110, 90);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(110, 346);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(110, 442);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(110, 443);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(111, 207);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(111, 314);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(111, 346);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(111, 393);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(111, 444);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(111, 445);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(111, 446);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(111, 447);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(112, 29);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(112, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(112, 90);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(112, 208);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(112, 246);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(112, 249);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(112, 295);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(112, 448);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(113, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(113, 30);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(113, 207);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(113, 314);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(113, 325);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(113, 449);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(113, 450);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(113, 451);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(114, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(114, 9);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(114, 42);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(114, 62);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(114, 154);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(114, 303);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(114, 452);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(115, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(115, 30);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(115, 90);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(115, 126);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(115, 207);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(115, 208);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(115, 226);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(115, 240);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(115, 437);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(115, 453);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(116, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(116, 38);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(116, 126);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(116, 207);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(116, 233);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(116, 240);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(116, 454);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(116, 455);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(116, 456);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(116, 457);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(117, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(117, 90);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(117, 126);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(117, 207);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(117, 226);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(117, 240);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(117, 395);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(117, 437);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(117, 458);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(117, 459);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(119, 29);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(119, 42);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(119, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(119, 303);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(119, 462);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(119, 463);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(119, 464);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(120, 29);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(120, 42);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(120, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(120, 125);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(120, 264);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(120, 465);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(121, 16);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(121, 28);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(121, 466);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(121, 467);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(121, 468);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(121, 469);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(121, 470);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(122, 29);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(122, 208);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(122, 224);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(122, 377);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(122, 404);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(122, 437);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(122, 471);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(122, 472);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(122, 473);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(123, 191);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(123, 460);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(123, 474);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(123, 475);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(123, 476);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(123, 477);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(123, 478);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(123, 479);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(123, 480);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(124, 9);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(124, 23);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(124, 128);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(124, 302);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(124, 481);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(124, 482);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(124, 483);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(124, 484);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(124, 485);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(125, 9);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(125, 35);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(125, 38);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(125, 84);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(125, 128);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(125, 302);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(125, 481);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(125, 484);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(125, 485);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(126, 9);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(126, 62);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(126, 226);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(126, 302);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(126, 393);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(126, 481);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(126, 484);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(126, 485);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(127, 38);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(127, 126);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(127, 302);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(127, 486);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(127, 487);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(127, 488);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(128, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(128, 9);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(128, 29);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(128, 62);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(128, 489);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(128, 490);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(128, 491);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(129, 29);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(129, 53);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(129, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(129, 193);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(129, 208);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(129, 492);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(129, 494);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(130, 175);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(130, 495);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(130, 496);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(130, 497);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(130, 498);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(131, 494);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(131, 499);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(131, 500);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(131, 501);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(132, 126);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(132, 494);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(132, 502);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(133, 5);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(133, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(133, 303);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(133, 503);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(134, 191);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(134, 460);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(134, 475);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(135, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(135, 504);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(135, 505);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(136, 33);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(136, 145);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(136, 506);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(136, 507);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(137, 33);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(137, 508);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(137, 509);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(137, 510);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(137, 511);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(138, 33);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(138, 512);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(138, 513);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(138, 514);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(138, 515);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(139, 16);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(139, 75);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(139, 90);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(139, 208);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(139, 226);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(139, 493);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(139, 598);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(139, 599);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(139, 600);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(139, 601);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(139, 602);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(139, 603);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(141, 42);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(141, 51);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(141, 226);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(141, 252);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(141, 377);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(141, 382);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(141, 395);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(141, 463);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(141, 493);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(141, 605);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(141, 614);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(141, 615);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(141, 616);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(141, 617);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(142, 32);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(142, 33);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(142, 619);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(143, 175);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(143, 203);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(143, 620);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(144, 38);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(144, 76);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(144, 203);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(144, 393);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(176, 8);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(176, 650);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(176, 651);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(176, 652);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(176, 656);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(176, 657);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(176, 658);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(176, 659);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(176, 660);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(176, 661);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(176, 662);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(176, 663);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(176, 664);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(176, 665);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(176, 666);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(176, 667);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(176, 668);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(179, 183);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(179, 669);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(179, 670);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(179, 671);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(180, 8);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(180, 51);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(180, 58);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(180, 672);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(181, 44);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(181, 45);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(181, 673);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(182, 674);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(182, 675);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(183, 676);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(183, 677);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(184, 175);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(184, 676);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(184, 678);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(185, 20);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(185, 53);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(185, 302);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(185, 679);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(185, 680);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(186, 28);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(186, 44);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(186, 537);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(186, 681);
INSERT INTO `image_tag` (`image_id`, `tag_id`) VALUES(186, 682);

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
CREATE TABLE IF NOT EXISTS `tag` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(30) NOT NULL,
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=683 ;

--
-- Dumping data for table `tag`
--

INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(1, 'Rice');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(2, 'Railway');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(3, 'Culture');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(4, 'New York');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(5, 'Summer');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(6, '9/11');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(7, 'Memorial');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(8, 'America');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(9, 'Holidays');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(10, 'Construction');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(11, 'Huge');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(12, 'Beautiful');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(13, 'Central Park ');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(14, 'Scenic ');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(15, 'Incredible');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(16, 'Sunny');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(17, 'Walks');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(18, 'Breathtaking');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(19, 'Bright');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(20, 'Lights');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(21, 'Shows');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(22, 'People');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(23, 'Night');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(24, 'Rushing');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(25, 'Adverts');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(26, 'Shops');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(27, 'Food');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(28, 'USA');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(29, 'Landscape');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(30, 'City');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(31, 'Freedom');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(32, 'Statue');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(33, 'History');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(34, 'NYC');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(35, 'Landmark');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(36, 'Munich');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(37, 'Germany');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(38, 'Architecture');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(39, 'Main Square');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(40, 'France');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(41, 'Alps');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(42, 'Mountains');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(43, 'Ski');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(44, 'Snowboard');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(45, 'Snow');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(46, 'Apres-ski');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(47, 'Outdoors');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(48, 'Chamonix');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(49, 'Greece');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(50, 'Greek Islands');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(51, 'Climbing');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(52, 'Rock Climbing');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(53, 'Nature');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(54, 'Grande Grotta');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(55, 'Kalymnos');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(56, 'Thailand');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(57, 'Bamboo Island');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(58, 'Solo Climbing');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(59, 'Tiger');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(60, 'Savage');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(61, 'Cat');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(62, 'River');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(63, 'Waterfall');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(64, 'F1');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(65, 'Ferrari');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(66, 'Race Car');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(67, 'Red Car');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(68, 'Speed');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(69, 'Fast');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(70, 'Danger');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(71, 'Colombia');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(72, 'Hiking');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(73, 'Beautiful Places');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(74, 'Panoramic');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(75, 'Sunset');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(76, 'Scotland');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(77, 'Gourock');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(78, 'River Clyde');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(79, 'OneAshtonRoad');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(80, 'Loch Lomond');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(81, 'Golf');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(82, 'Houston');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(83, 'Castle');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(84, 'Historic');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(85, 'Clouds');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(86, 'Sky');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(87, 'Windfarm');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(88, 'Coast');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(89, 'Edge');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(90, 'Sea');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(91, 'Yachts');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(92, 'Port');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(93, 'TianTian');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(94, 'Giant Panda');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(95, 'Edinburgh');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(96, 'Sleeping Panda');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(97, 'Panda Claws');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(98, 'Cuddly');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(99, 'Sumatran Tiger');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(100, 'Zoo');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(101, 'Tibor');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(102, 'Bugonda Trail');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(103, 'Chimpanzee');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(104, 'Evolution');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(105, 'Luss');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(106, 'Village');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(107, 'Garden');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(108, 'House');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(109, 'Kelvingrove Park');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(110, 'University of Glasgow');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(111, 'Gothic Architecture');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(112, 'Behind Tree');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(113, 'Pollok Park');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(114, 'Woodland');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(115, 'UK Coins');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(116, 'Flower');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(117, 'Marionette');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(118, 'Dog');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(119, 'Labrador');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(120, 'Still Life');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(121, 'Pets');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(122, 'Scottish');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(123, 'Thistle');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(124, 'Plants');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(125, 'Wildlife');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(126, 'Photography');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(127, 'Attraction');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(128, 'Monument');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(129, 'Tourism');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(130, 'Glasgow');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(131, 'Winter');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(132, 'Royal');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(133, 'Suite');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(134, 'Stairs');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(135, 'Lighting');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(136, 'Paintings');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(137, 'Expensive');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(138, 'Chandelier');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(139, 'Facing');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(140, 'Oriental');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(141, 'Hong Kong');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(142, 'Respect');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(143, 'China');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(144, 'City Centre');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(145, 'Building');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(146, 'Structure');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(147, 'Windows');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(148, 'Hotel');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(149, 'Street');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(150, 'Modern');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(151, 'Accommodation');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(152, 'Travel');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(153, 'Citizen M');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(154, 'Trees');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(155, 'Autumn');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(156, 'West End');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(157, 'Kelvingrove');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(158, 'Park');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(159, 'Skatepark');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(160, 'Ramp');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(161, 'Skateboarding');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(162, 'Art Gallery');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(163, 'Museum');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(164, 'Pogona');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(165, 'Reptile');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(166, 'Lizard');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(167, 'Bearded Dragon');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(168, 'Central Bearded Dragon');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(169, 'Scales');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(170, 'Perch');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(171, 'Vivarium');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(172, 'Captivity');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(173, 'Enclosure');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(174, 'Life');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(175, 'Animal');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(176, 'Cold Blooded');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(177, 'Berlin');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(178, 'Brandenburg Gate');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(179, 'Neoclassical');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(180, 'European');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(181, 'Berlin Wall');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(182, 'Pariser Platz');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(183, 'Football');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(184, 'Stadium');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(185, 'Olympic');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(186, 'Olympiastadion');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(187, 'World Cup');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(188, 'Olympic Games');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(189, 'World War');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(190, 'Hertha Berlin');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(191, 'Champions League');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(192, 'Cathedral');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(193, 'Bishop');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(194, 'Museum Island');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(195, 'Evangelical');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(196, 'Church');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(197, 'Roman Catholic');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(198, 'Mitte');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(199, 'Angel Of The North');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(200, 'Black');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(201, 'White');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(202, 'Man');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(203, 'Art');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(204, 'Sculpture');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(205, 'Antony Gormley');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(206, 'Gateshead');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(207, 'England');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(208, 'Beach');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(209, 'Scarborough');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(210, 'North Yorkshire');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(211, 'Waves');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(212, 'Town');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(213, 'Tyne Bridge');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(214, 'Newcastle');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(215, 'Bluejays');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(216, 'Baseball');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(217, 'Roger Centre');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(218, 'Kansas City Royals');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(219, 'MLB');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(220, 'Major League Baseball');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(221, 'Toronto');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(222, 'CN Tower');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(223, 'Canada');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(224, 'Sun');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(225, 'Heights');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(226, 'Water');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(227, 'Niagara Falls');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(228, 'View');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(229, 'Infusion');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(230, 'Blackpool Pleasure Beach');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(231, 'Rollercoaster');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(232, 'Upside Down');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(233, 'Fun');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(234, 'Three Wheels');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(235, 'Three Seats');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(236, 'Motorbike');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(237, 'Purple');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(238, 'Awesome Ride');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(239, 'Blackpool Tower');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(240, 'Blackpool');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(241, 'Tall');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(242, 'Very Old');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(243, 'Town Centre');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(244, 'Promenade');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(245, 'Red');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(246, 'Sand');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(247, 'Largs');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(248, 'Millport');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(249, 'Arran');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(250, 'Reflection');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(251, 'Blizzard');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(252, 'Freezing');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(253, 'Bulgaria');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(254, 'Sunbathing');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(255, 'Blue Sky');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(256, 'Mini Golf');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(257, 'Arch');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(258, 'Hydro');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(259, 'Music');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(260, 'SSE');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(261, 'SECC');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(262, 'Clyde');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(263, 'Centre');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(264, 'Island');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(265, 'Highest Peak');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(266, 'Mountain Of Wind');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(267, 'Viewpoint');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(268, 'Main Street');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(269, 'Balamory');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(270, 'Isle Of Mull');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(271, 'Houses');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(272, 'Elephant');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(273, 'Sri Lanka');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(274, 'Sanctuary');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(275, 'Wash');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(276, 'Bathing');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(277, 'Linlithgow');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(278, 'Cross');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(279, 'Spire');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(280, 'Steeple');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(281, 'Sunshine');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(282, 'Grey');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(283, 'Forth');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(284, 'Forth Road Bridge');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(285, 'Fife');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(286, 'Industrial');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(287, 'Rail');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(288, 'Forth Rail Bridge');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(289, 'Iron ');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(290, 'Candles');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(291, 'Chiang Mai');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(292, 'Fire');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(293, 'Temple');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(294, 'Buddhism');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(295, 'Boats');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(296, 'Koh Samui');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(297, 'National Park');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(298, 'Amsterdam');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(299, 'Canals');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(300, 'Bikes');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(301, 'Holland');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(302, 'Europe');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(303, 'Scenery');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(304, 'Jim Morrison');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(305, 'The Doors');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(306, 'Rock');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(307, 'Rock Legend');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(308, 'Singer');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(309, 'Pére Lachaise');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(310, 'Paris');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(311, 'Grave');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(312, 'Eiffel Tower');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(313, 'City Break');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(314, 'London');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(315, 'Apple Market');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(316, 'Covent Garden');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(317, 'London Eye');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(318, 'Great View');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(319, 'Blue Building');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(320, 'Scary High');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(321, 'Parliament');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(322, 'River Thames');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(323, 'Victoria Tower');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(324, 'Big Clock');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(325, 'Westminster ');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(326, 'Hogwarts');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(327, 'Harry Potter');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(328, 'Florida');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(329, 'Universal Studios');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(330, 'Islands Of Adventure');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(331, 'Summer Holiday');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(332, 'Capital');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(333, 'Sunny Day');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(334, 'Quiet');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(335, 'Peaceful');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(336, 'Safari');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(337, 'Mombasa');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(338, 'Kenya');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(339, 'Tsavo');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(340, 'Big Five');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(341, 'Lion');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(342, 'Mexico');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(343, 'Mayan');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(344, 'Tulum');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(345, 'Caribbean');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(346, 'UK');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(347, 'Ferris Wheel');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(348, 'Dragon');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(349, 'City Of London');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(350, 'Temple Bar');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(351, 'Sightseeing');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(352, 'Gherkin');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(353, 'Thames');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(354, 'Financial District');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(355, 'Riverbank');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(356, 'Aquarium');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(357, 'Shark');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(358, 'London Aquarium');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(359, 'Spooky');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(360, 'Scary');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(361, 'Leukback');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(362, 'HDR');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(363, 'High Dynamic Range');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(364, 'Saar');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(365, 'Common License');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(366, 'Perl');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(367, 'Mettlach');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(368, 'Kollesleuken');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(369, 'Trassem');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(370, 'Saarburg');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(371, 'Square');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(372, 'Public');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(373, 'Piazza della Repubblica');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(374, 'Market');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(375, 'Cold');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(376, 'Slovakia');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(377, 'Hill');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(378, 'Majestic');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(379, 'Old');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(380, 'Skyline');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(381, 'Empire State');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(382, 'Cloudy');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(383, 'Skyscraper');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(384, 'Hudson');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(385, 'Freedom Tower');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(386, 'Vibrant');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(387, 'Manhattan');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(388, 'Rockefeller');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(389, 'High Rise');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(390, 'Staten Island');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(391, 'NY');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(392, 'Scott Monument');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(393, 'Bridge');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(394, 'Waverley Train Station');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(395, 'Rain');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(396, 'Grass');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(397, 'Princes Street');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(398, 'Orlando');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(399, 'US');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(400, 'Universal');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(401, 'Theme Park');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(402, 'World');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(403, 'Resort');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(404, 'Palm Trees');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(405, 'Globe');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(406, 'July');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(407, 'City Walk');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(408, 'Victoria Square Birmingham');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(409, 'Floozie In The Jacuzzi');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(410, 'Second City');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(411, 'The River');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(412, 'Birmingham Council House');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(413, 'Centre Of Birmingham');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(414, 'Selfridges Birmingham');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(415, 'City Centre Birmingham');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(416, 'Places To Visit');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(417, 'West Midlands');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(418, 'Birmingham');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(419, 'The Bull');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(420, 'The Bullring');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(421, 'Philippines');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(422, 'Pilipinas');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(423, 'Isla Siargao');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(424, 'Siargao Island');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(425, 'Philippine Islands');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(426, 'Surfing Capital');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(427, 'Surigao');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(428, 'Bohol');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(429, 'Panglao Island Nature Resort');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(430, 'Panglao');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(431, 'Bohol Experience');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(432, 'Vacation');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(433, 'Boracay');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(434, 'White Beach');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(435, 'Aklan');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(436, 'Party Beach');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(437, 'Ocean');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(438, 'Tour Boat Operator');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(439, 'Big Ben');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(440, 'Clock Tower');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(441, 'ElizabethTower');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(442, 'Dunure Castle');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(443, 'South Ayrshire');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(444, 'Tower Bridge');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(445, 'Paralympics 2012');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(446, 'Bascule');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(447, 'Suspension');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(448, 'Ayr');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(449, 'Houses Of Parliament');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(450, 'Palace Of Westminister');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(451, 'Britain');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(452, 'Romania');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(453, 'Photo');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(454, 'Money');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(455, 'Gambling');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(456, 'Family');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(457, 'Arcade');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(458, 'Tower');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(459, 'Pier');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(460, 'Barcelona');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(461, 'Gaudi');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(462, 'Footpath');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(463, 'Walking');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(464, 'Countryside');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(465, 'Coastline');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(466, 'Philadelphia');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(467, 'Rocky');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(468, 'Teachers');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(469, 'Pupils');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(470, 'Boxing');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(471, 'Ibiza');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(472, 'Tennis');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(473, 'Ruins');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(474, 'UEFA');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(475, 'Celtic');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(476, 'Amazing Atmosphere');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(477, 'Display');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(478, 'Footballers');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(479, 'Paradise');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(480, '125th Anniversary');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(481, 'Italy');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(482, 'Trevi Fountain');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(483, 'Fountain');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(484, 'Rome');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(485, 'Sights');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(486, 'Budapest');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(487, 'Travelling');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(488, 'Hungary');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(489, 'Vienna');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(490, 'Austria');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(491, 'Danube');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(492, 'Durness');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(493, 'Rocks');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(494, 'Road Trip');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(495, 'India');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(496, 'Monkeys');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(497, 'Animals');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(498, 'Trip');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(499, 'Dragonfly');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(500, 'Insect');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(501, 'Small');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(502, 'Bird');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(503, 'Reservoir');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(504, 'Irn Bru');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(505, 'Other National Drink');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(506, 'DC');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(507, 'Capitol');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(508, 'Flying');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(509, 'Military');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(510, 'WWII');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(511, 'V1');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(512, 'Space');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(513, 'ISS');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(514, 'Apollo');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(515, 'Soyuz');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(516, 'Fireworks');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(517, 'Cumbernauld');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(518, 'Guy Fawkes');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(519, 'Long Exposure');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(520, 'Broadwood');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(521, 'Tarantula');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(522, 'Spider');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(523, 'Togo');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(524, 'Starburst Baboon');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(525, 'Heteroscodra Maculata');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(526, 'Male');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(527, 'West Africa');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(528, 'Arachnid');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(529, 'Basiliscus Plumifrons');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(530, 'Plumed Basilisk');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(531, 'Jesus Christ Lizard');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(532, 'Rainforest');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(533, 'Ben Nevis');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(534, 'Fort William');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(535, 'Highlands');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(536, 'Foothill');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(537, 'Helicopter');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(538, 'Panasonic DMC-FZ20');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(539, 'Conic Hill');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(540, 'Balmaha');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(541, 'Track');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(542, 'Oban');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(543, 'Bay');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(544, 'Kerrera');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(545, 'West Coast');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(546, 'Douglas');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(547, 'Firth Of Lorn');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(548, 'Catalan');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(549, 'Liberty');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(550, 'Wall');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(551, 'Stone');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(552, 'Greenery');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(553, 'Ancient');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(554, 'Wonders');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(555, 'Victorian');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(556, 'Gothic');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(557, 'Symbolic');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(558, 'Largest');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(559, 'Africa');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(560, 'Zimbabwe');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(561, 'Zambia');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(562, 'Current');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(563, 'Smoke');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(564, 'Wonder');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(565, 'Natural');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(566, 'Discovery');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(567, 'Victoria');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(568, 'Livingstone');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(569, 'Blue');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(570, 'Saltire Centre');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(571, 'University');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(572, 'Students');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(573, 'Library');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(574, 'Pig');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(575, 'Piggybank');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(576, 'Mud');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(577, 'Pink');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(578, 'Nose');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(579, 'Beetle');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(580, 'Hillwalking');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(581, 'Charleston');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(582, 'Bugs');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(583, 'Macro');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(584, 'Close-up');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(585, 'Crayons');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(586, 'Canvas');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(587, 'Crayola');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(588, 'Colourful');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(589, 'Rainbow');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(590, 'Green');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(591, 'Orange');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(592, 'Yellow');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(593, 'Gairloch');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(594, 'B&B');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(595, 'Seaside');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(596, 'Inverness');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(597, 'Dingwall');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(598, 'Windy');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(599, 'Peebles');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(600, 'Fish');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(601, 'Crabs');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(602, 'Ayrshire');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(603, 'X-Pro II Filter');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(604, 'Hot');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(605, 'Lake');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(606, 'Bunkers');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(607, 'Greens');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(608, 'Tricky');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(609, 'Nearest The Pin');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(610, 'Duck');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(611, 'Goose');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(612, 'Sprinkler');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(613, 'Rake');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(614, 'Hudson Filter');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(615, 'Waterproofs');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(616, 'Under Armour');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(617, 'Zig Zag Path');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(618, 'Stream');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(619, 'Heritage');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(620, 'Animal');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(650, 'Tesla');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(651, 'Physics');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(652, 'Eletricity');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(653, 'New Tag');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(654, 'I Created this tag');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(655, 'Celitcs');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(656, 'Einstein');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(657, 'Science');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(658, 'Bohr');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(659, 'Fermi');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(660, 'Galilei');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(661, 'Newton');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(662, 'Heinsenberg');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(663, 'Astronomy');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(664, 'Astrophysics');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(665, 'Planets');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(666, 'Moon');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(667, 'XYZ');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(668, 'Gallacher');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(669, 'Gremio');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(670, 'Porto Alegre');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(671, 'Brazil');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(672, 'honnold');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(673, 'Travis');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(674, 'Nazca ');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(675, 'Peru');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(676, 'Horse');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(677, 'Iceland');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(678, 'Pampa');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(679, 'finland');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(680, 'northern lights');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(681, 'Alaska');
INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES(682, 'Crazy');

Grant All on gcuimages.* to 'imagesadmin'@'localhost' identified by 'imagesadmin';

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
