-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 05, 2013 at 07:45 PM
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
BEGIN

 SELECT image_contributor, round(sum(sum_ratings)/sum(no_ratings),0) as average_rating
  FROM image
	GROUP BY image_contributor
	ORDER BY average_rating desc limit 20;
END$$

DROP PROCEDURE IF EXISTS `collection_get_highest_rated_images`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `collection_get_highest_rated_images`()
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
  KEY `idx_ft_image_title_contributor` (`image_title`,`image_contributor`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=192 ;

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
