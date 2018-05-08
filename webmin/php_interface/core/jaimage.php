<?php 
/**
 * # ------------------------------------------------------------------------
# JA Teline III - Stable - Version 1.4 - Licence Owner JA49652
# ------------------------------------------------------------------------
# Copyright (C) 2004-2009 J.O.O.M Solutions Co., Ltd. All Rights Reserved.
# @license - Copyrighted Commercial Software
# Author: J.O.O.M Solutions Co., Ltd
# Websites:  http://www.joomlart.com -  http://www.joomlancers.com
# This file may not be redistributed in whole or significant part.
# ------------------------------------------------------------------------
 */
 // no direct access
 // Add round corner by Ngocub
define(JPATH_SITE,$_SERVER["DOCUMENT_ROOT"]);
define(DS,"/");

	class JAImage {
		
		/**
		 * Identifier of the cache path.
		 *
		 * @access private
		 * @param string $__cachePath
		 */
		var $__cachePath;
		
		/**
		 * Identifier of the path of source.
		 *
		 * @access private
		 * @param string $__imageBase
		 */
		var $__imageBase;
		
		/**
		 * Identifier of the image's extensions
		 *
		 * @access public
		 * @param array $types
		 */
		var $types = array();
	
		/**
		 * Identifier of the quantity of thumnail image.
		 *
		 * @access public
		 * @param string $__quality
		 */
		var $__quality = 90;
		
		/**
		 * Identifier of the url of folder cache.
		 *
		 * @access public
		 * @param string $__cacheURL
		 */
		var $__cacheURL;
		
		/**
		 * constructor 
		 */
		function __construct(){
			$this->types = array( 1 => "gif", "jpeg", "png", "swf", "psd", "wbmp" );	
			$this->__imageBase = JPATH_SITE.DS.'images'.DS;
			$this->__cachePath = $this->__imageBase.'resized'.DS;
			$this->__cacheURL = '/images/resized';
		}
		/**
		 * constructor 
		 */
		function JAImage(){
			$this->__construct();
		}
		/**
		 * get a instance of JAImage object.
		 *
		 * This method must be invoked as:
		 * 		<pre>  $jaimage = &JAImage::getInstace();</pre>
		 *
		 * @static.
		 * @access public,
		 */
		function &getInstance(){
			static $instance = null;
			if( !$instance ){
				$instance = new JAImage();
			}
			return $instance;
		}
		

		/**
		 * round_corners
		 *
		 * Round the corners of an image. Transparency and anti-aliasing are supported.
		 *
		 * @version 0.1
		 * @author Contributors at eXorithm
		 * @link http://www.exorithm.com/algorithm/view/round_corners Listing at eXorithm
		 * @link http://www.exorithm.com/algorithm/history/round_corners History at eXorithm
		 * @license http://www.exorithm.com/home/show/license
		 *
		 * @param resource $image (GD image) 
		 * @param number $radius Radius of the rounded corners.
		 * @param string $color (hex color code) Color of the background.
		 * @param mixed $transparency Level of transparency. 0 is no transparency, 127 is full transparency.
		 * @return resource GD image
		 */
		function round_corners($image=null,$radius=20,$color='ffffff',$transparency='127',$tl=true,$tr=true,$bl=true,$br=true)
		{
//			$width = imagesx($image);
//			$height = imagesy($image);
			$size = getimagesize($image);
			$extension = $this->types[$size[2]];
			$width = $size[0];
			$height = $size[1];

			$image2 = imagecreatetruecolor($width, $height);
			$source_image = call_user_func( "imagecreatefrom".$extension, $image );
			imagecopy($image2, $source_image, 0, 0, 0, 0, $width, $height);
			
			imagesavealpha($image2, true);
			imagealphablending($image2, false);
			
			$full_color = $this->allocate_color($image2, $color, $transparency);

			// loop 4 times, for each corner...
			if($tl){
				$left = 0;
				$top = 0;
				
				$start_x = $left * ($width-$radius);
				$start_y = $top * ($height-$radius);
				$end_x = $start_x+$radius;
				$end_y = $start_y+$radius;
				
				$radius_origin_x = $left * ($start_x-1) + (!$left) * $end_x;
				$radius_origin_y = $top * ($start_y-1) + (!$top) * $end_y;
				
				for ($x=$start_x;$x<$end_x;$x++) {
					for ($y=$start_y;$y<$end_y;$y++) {
						$dist = sqrt(pow($x-$radius_origin_x,2)+pow($y-$radius_origin_y,2));
						
						if ($dist>($radius+1)) {
							imagesetpixel($image2, $x, $y, $full_color);
						} else {
							if ($dist>$radius) {
							  $pct = 1-($dist-$radius);
							  $color2 = $this->antialias_pixel($image2, $x, $y, $full_color, $pct);
							  imagesetpixel($image2, $x, $y, $color2);
							}
						}
					}
				}

			}
			if($tr){
				$left = 1;
				$top = 0;
				
				$start_x = $left * ($width-$radius);
				$start_y = $top * ($height-$radius);
				$end_x = $start_x+$radius;
				$end_y = $start_y+$radius;
				
				$radius_origin_x = $left * ($start_x-1) + (!$left) * $end_x;
				$radius_origin_y = $top * ($start_y-1) + (!$top) * $end_y;
				
				for ($x=$start_x;$x<$end_x;$x++) {
					for ($y=$start_y;$y<$end_y;$y++) {
						$dist = sqrt(pow($x-$radius_origin_x,2)+pow($y-$radius_origin_y,2));
						
						if ($dist>($radius+1)) {
							imagesetpixel($image2, $x, $y, $full_color);
						} else {
							if ($dist>$radius) {
							  $pct = 1-($dist-$radius);
							  $color2 = $this->antialias_pixel($image2, $x, $y, $full_color, $pct);
							  imagesetpixel($image2, $x, $y, $color2);
							}
						}
					}
				}

			}
			if($bl){
				$left = 0;
				$top = 1;
				
				$start_x = $left * ($width-$radius);
				$start_y = $top * ($height-$radius);
				$end_x = $start_x+$radius;
				$end_y = $start_y+$radius;
				
				$radius_origin_x = $left * ($start_x-1) + (!$left) * $end_x;
				$radius_origin_y = $top * ($start_y-1) + (!$top) * $end_y;
				
				for ($x=$start_x;$x<$end_x;$x++) {
					for ($y=$start_y;$y<$end_y;$y++) {
						$dist = sqrt(pow($x-$radius_origin_x,2)+pow($y-$radius_origin_y,2));
						
						if ($dist>($radius+1)) {
							imagesetpixel($image2, $x, $y, $full_color);
						} else {
							if ($dist>$radius) {
							  $pct = 1-($dist-$radius);
							  $color2 = $this->antialias_pixel($image2, $x, $y, $full_color, $pct);
							  imagesetpixel($image2, $x, $y, $color2);
							}
						}
					}
				}

			}
			if($br){
				$left = 1;
				$top = 1;
				
				$start_x = $left * ($width-$radius);
				$start_y = $top * ($height-$radius);
				$end_x = $start_x+$radius;
				$end_y = $start_y+$radius;
				
				$radius_origin_x = $left * ($start_x-1) + (!$left) * $end_x;
				$radius_origin_y = $top * ($start_y-1) + (!$top) * $end_y;
				
				for ($x=$start_x;$x<$end_x;$x++) {
					for ($y=$start_y;$y<$end_y;$y++) {
						$dist = sqrt(pow($x-$radius_origin_x,2)+pow($y-$radius_origin_y,2));
						
						if ($dist>($radius+1)) {
							imagesetpixel($image2, $x, $y, $full_color);
						} else {
							if ($dist>$radius) {
							  $pct = 1-($dist-$radius);
							  $color2 = $this->antialias_pixel($image2, $x, $y, $full_color, $pct);
							  imagesetpixel($image2, $x, $y, $color2);
							}
						}
					}
				}

			}
			//return $image2;
			switch( $extension ){
				case 'jpeg' :
					call_user_func( 'image'.$extension, $image2, $image, $this->__quality );	
					break;
				default:
					call_user_func( 'image'.$extension,$image2, $image );
					break;	
			}
			return 
//			imagecopy($image, $image2, 0, 0, 0, 0, $width, $height);
			imagedestroy($image2);  
		}
		
		/**
		 * allocate_color
		 *
		 * Helper function to allocate a color to an image. Color should be a 6-character hex string.
		 *
		 * @version 0.2
		 * @author Contributors at eXorithm
		 * @link http://www.exorithm.com/algorithm/view/allocate_color Listing at eXorithm
		 * @link http://www.exorithm.com/algorithm/history/allocate_color History at eXorithm
		 * @license http://www.exorithm.com/home/show/license
		 *
		 * @param resource $image (GD image) The image that will have the color allocated to it.
		 * @param string $color (hex color code) The color to allocate to the image.
		 * @param mixed $transparency The level of transparency from 0 to 127.
		 * @return mixed
		 */
		function allocate_color($image=null,$color='268597',$transparency='0')
		{

			if (preg_match('/[0-9ABCDEF]{6}/i', $color)==0) {
				throw new Exception("Invalid color code.");
			}
			if ($transparency<0 || $transparency>127) {
				throw new Exception("Invalid transparency.");
			}
			
			$r  = hexdec(substr($color, 0, 2));
			$g  = hexdec(substr($color, 2, 2));
			$b  = hexdec(substr($color, 4, 2));
			if ($transparency>127) $transparency = 127;
			
			if ($transparency<=0)
				return imagecolorallocate($image, $r, $g, $b);
			else
				return imagecolorallocatealpha($image, $r, $g, $b, $transparency);
		}
		
		/**
		 * antialias_pixel
		 *
		 * Helper function to apply a certain weight of a certain color to a pixel in an image. The index of the resulting color is returned. 
		 *
		 * @version 0.1
		 * @author Contributors at eXorithm
		 * @link http://www.exorithm.com/algorithm/view/antialias_pixel Listing at eXorithm
		 * @link http://www.exorithm.com/algorithm/history/antialias_pixel History at eXorithm
		 * @license http://www.exorithm.com/home/show/license
		 *
		 * @param resource $image (GD image) The image containing the pixel.
		 * @param number $x X-axis position of the pixel.
		 * @param number $y Y-axis position of the pixel.
		 * @param number $color The index of the color to be applied to the pixel.
		 * @param number $weight Should be between 0 and 1,  higher being more of the original pixel color, and 0.5 being an even mixture.
		 * @return mixed
		 */
		function antialias_pixel($image=null,$x=0,$y=0,$color=0,$weight=0.5)
		{
			$c = imagecolorsforindex($image, $color);
			$r1 = $c['red'];
			$g1 = $c['green'];
			$b1 = $c['blue'];
			$t1 = $c['alpha'];
			
			$color2 = imagecolorat($image, $x, $y);
			$c = imagecolorsforindex($image, $color2);
			$r2 = $c['red'];
			$g2 = $c['green'];
			$b2 = $c['blue'];
			$t2 = $c['alpha'];
			
			$cweight = $weight+($t1/127)*(1-$weight)-($t2/127)*(1-$weight);
			
			$r = round($r2*$cweight + $r1*(1-$cweight));
			$g = round($g2*$cweight + $g1*(1-$cweight));
			$b = round($b2*$cweight + $b1*(1-$cweight));
			
			$t = round($t2*$weight + $t1*(1-$weight));
			
			return imagecolorallocatealpha($image, $r, $g, $b, $t);
		}

		function round_corner2 ($source,$imageCache,$colour="FFFFFF",$radius=10,$angle=0,$topleft=true,$bottomleft=true,$bottomright=true,$topright=true){
				//----------------------------------------------------------------
				// Apply Round Corner PHP-GD
				// Revision 2 [2009-07-01]
				// Corrected inconsistent corner problem caused by PHP bug 42685
				//----------------------------------------------------------------
				
				//
				// source: path or url of a gif/jpeg/png image -- php fopen url wrapper must be enabled if using url
				// radius: corner radius in pixels -- default value is 10
				// colour: corner colour in rgb hex format -- default value is FFFFFF
				//
				
				//
				// 1) open source image and calculate properties
				//
//				list( $source_width, $source_height, $source_type ) = getimagesize( $source );
				$size = getimagesize($source);
				$extension = $this->types[$size[2]];
				$source_width = $size[0];
				$source_height = $size[1];

				$source_image = call_user_func( "imagecreatefrom".$extension, $source );
//				switch ( $source_type )
//				{
//					case IMAGETYPE_GIF:
//						$source_image = imagecreatefromgif( $source );
//						break;
//					case IMAGETYPE_JPEG:
//						$source_image = imagecreatefromjpeg( $source );
//						break;
//					case IMAGETYPE_PNG:
//						$source_image = imagecreatefrompng( $source );
//						break;
//				}
			
			  //
			  // 2) create mask for top-left corner in memory
			  //
			
			  $corner_image = imagecreatetruecolor(
				$radius,
				$radius
			  );
			
			  $clear_colour = imagecolorallocate(
				$corner_image,
				0,
				0,
				0
			  );
			
			  $solid_colour = imagecolorallocate(
				$corner_image,
				hexdec( substr( $colour, 0, 2 ) ),
				hexdec( substr( $colour, 2, 2 ) ),
				hexdec( substr( $colour, 4, 2 ) )
			  );
			
			  imagecolortransparent(
				$corner_image,
				$clear_colour
			  );
			
			  imagefill(
				$corner_image,
				0,
				0,
				$solid_colour
			  );
			
			  imagefilledellipse(
				$corner_image,
				$radius,
				$radius,
				$radius * 2,
				$radius * 2,
				$clear_colour
			  );
			
			  //
			  // 3) render the top-left, bottom-left, bottom-right, top-right corners by rotating and copying the mask
			  //
			if ($topleft == true) {
				imagecopymerge($source_image,$corner_image,0,0,0,0,$radius,$radius,100);
			}
			if ($bottomleft == true) {
				$corner_image = imagerotate( $corner_image, 90, 0 );
				imagecopymerge($source_image,$corner_image,0,$source_height - $radius,0,0,$radius,$radius,100);
			}
			if ($bottomright == true) {
				$corner_image = imagerotate( $corner_image, 90, 0 );
				imagecopymerge($source_image,$corner_image,$source_width - $radius,$source_height - $radius,0,0,$radius,$radius,100);
			}
			if ($topright == true) {
				$corner_image = imagerotate( $corner_image, 90, 0 );
				imagecopymerge($source_image,$corner_image,$source_width - $radius,0,0,0,$radius,$radius,100);
			}
			  //
			  // 4) output the image -- revise this step according to your needs
			  //
			if($angle){
			// Rotate image
				$image = imagerotate($image, $angle, $solid_colour);
			}
			
//				header( "Content-type: image/png" );
//				imagepng( $source_image,$imageCache);
//				imagejpeg( $corner_image,$imageCache,90);
			switch( $extension ){
				case 'jpeg' :
					call_user_func( 'image'.$extension, $source_image, $imageCache, $this->__quality );	
					break;
				default:
					call_user_func( 'image'.$extension,$source_image, $imageCache );
					break;	
			}
				
			//imagejpeg($image);
				
			imagedestroy($source_image);  
			imagedestroy($corner_image);
		}
		function round_corner($image_file,$imageCache,$corner_radius=20,$angle=0,$topleft=true,$bottomleft=true,$bottomright=true,$topright=true){
			
			$images_dir = $this->__cacheURL;
			$corner_source = imagecreatefrompng(JPATH_SITE. str_replace( '/', DS,  '/images/rounded_corner.png' ));
			$corner_width = imagesx($corner_source);  
			$corner_height = imagesy($corner_source);  
			$corner_resized = ImageCreateTrueColor($corner_radius, $corner_radius);
			ImageCopyResampled($corner_resized, $corner_source, 0, 0, 0, 0, $corner_radius, $corner_radius, $corner_width, $corner_height);
			
			$corner_width = imagesx($corner_resized);  
			$corner_height = imagesy($corner_resized);  
			$image = imagecreatetruecolor($corner_width, $corner_height);
			
			$size = getimagesize($image_file);
			$extension = $this->types[$size[2]];
			$image = call_user_func( "imagecreatefrom".$extension, $image_file );
			//$image = imagecreatefromjpeg($images_dir . $image_file); // replace filename with $_GET['src'] 
			//$size = getimagesize($images_dir . $image_file); // replace filename with $_GET['src'] 
			$white = ImageColorAllocate($image,255,255,255);
			$black = ImageColorAllocate($image,0,0,0);
			
			// Top-left corner
			if ($topleft == true) {
				$dest_x = 0;  
				$dest_y = 0;  
				imagecolortransparent($corner_resized, $black); 
				imagecopymerge($image, $corner_resized, $dest_x, $dest_y, 0, 0, $corner_width, $corner_height, 100);
			} 
			
			// Bottom-left corner
			if ($bottomleft == true) {
				$dest_x = 0;  
				$dest_y = $size[1] - $corner_height; 
				$rotated = imagerotate($corner_resized, 90, 0);
				imagecolortransparent($rotated, $black); 
				imagecopymerge($image, $rotated, $dest_x, $dest_y, 0, 0, $corner_width, $corner_height, 100);  
			}
			
			// Bottom-right corner
			if ($bottomright == true) {
				$dest_x = $size[0] - $corner_width;  
				$dest_y = $size[1] - $corner_height;  
				$rotated = imagerotate($corner_resized, 180, 0);
				imagecolortransparent($rotated, $black); 
				imagecopymerge($image, $rotated, $dest_x, $dest_y, 0, 0, $corner_width, $corner_height, 100);  
			}
			
			// Top-right corner
			if ($topright == true) {
				$dest_x = $size[0] - $corner_width;  
				$dest_y = 0;  
				$rotated = imagerotate($corner_resized, 270, 0);
				imagecolortransparent($rotated, $black); 
				imagecopymerge($image, $rotated, $dest_x, $dest_y, 0, 0, $corner_width, $corner_height, 100);  
			}
			if($angle){
			// Rotate image
				$image = imagerotate($image, $angle, $white);
			}
			// Output final image
			switch( $extension ){
				case 'jpeg' :
					call_user_func( 'image'.$extension, $image, $imageCache, $this->__quality );	
					break;
				default:
					call_user_func( 'image'.$extension,$image, $imageCache );
					break;	
			}

			//imagejpeg($image);
			
			imagedestroy($image);  
			imagedestroy($corner_source);
		}
		/**
		 * crop or resize image
		 * 	
		 *
		 * @param string $image path of source.
		 * @param integer $width width of thumnail
		 * @param integer $height height of thumnail
		 * @param boolean $aspect whether to render thumnail base on the ratio
		 * @param boolean $crop whether to use crop image to render thumnail.
		 * @access public,
		 */

		function resize( $image, $width, $height, $crop=true,  $aspect=true ,$round = false,$color = 'FFFFFF',$transparency='127',$topleft=true,$topright=true,$botleft=true,$botright=true){
			// get image information

			if( !$width || !$height ) return '';
		
			$imagSource = JPATH_SITE. str_replace( '/', DS,  $image );

			if( !file_exists($imagSource) || !is_file($imagSource) ){ return ''; }
			$size = getimagesize( $imagSource );
			// if it's not a image.
			if( !$size ){ return ''; }
			 // case 1: render image base on the ratio of source.
		 	$x_ratio = $width / $size[0];
			$y_ratio = $height / $size[1];
			
			// set dst, src
			$dst = new stdClass(); 
			$src = new stdClass();
			$src->y = $src->x = 0;
			$dst->y = $dst->x = 0;
//			if ($width > $size[0])
//				$width = $size[0];
//			if ($height > $height)
//				$height = $size[1];
		
			if ( $crop ) {	// processing crop image 	
				$dst->w = $width;
				$dst->h = $height;
				if ( ($size[0] <= $width) && ($size[1] <= $height) ) {
					$src->w = $width;
					$src->h = $height;
				} else {
					if ($x_ratio < $y_ratio) {
						$src->w = ceil ( $width / $y_ratio );
						$src->h = $size[1];
					} else {
						$src->w = $size[0];
						$src->h = ceil ( $height / $x_ratio );
					}
				}
				$src->x = floor ( ($size[0] - $src->w) / 2 );
				$src->y = floor ( ($size[1] - $src->h) / 2 );
			} else { // processing resize image.
				$src->w = $size[0];
				$src->h = $size[1];
				if( $aspect ) { // using ratio
					if ( ($size[0] <= $width) && ($size[1] <= $height) ) {
						$dst->w = $size[0];
						$dst->h = $size[1];
					} else if ( ($size[0] <= $width) && ($size[1] <= $height) ) {
						$dst->w = $size[0];
						$dst->h = $size[1];
					} else if ( ($x_ratio * $size[1]) < $height ) {
						$dst->h = ceil ( $x_ratio * $size[1] );
						$dst->w = $width;
					} else {
						$dst->w = ceil ( $y_ratio * $size[0] );
						$dst->h = $height;
					}
				} else { // resize image without the ratio of source.
					$dst->w = $width;
					$dst->h = $height;
				}
			}
			//
			$ext =	substr ( strrchr ( $image, '.' ), 1 ); 
			$thumnail =  substr ( $image, 0, strpos ( $image, '.' )) . "_{$width}_{$height}.";
			if($crop && $aspect){
				$thumnail =  substr ( $image, 0, strpos ( $image, '.' )) . "_{$width}_{$height}_CA";
			}elseif(!$crop && $aspect){
				$thumnail =  substr ( $image, 0, strpos ( $image, '.' )) . "_{$width}_{$height}_A";
			}elseif(!$crop && !$aspect){
				$thumnail =  substr ( $image, 0, strpos ( $image, '.' )) . "_{$width}_{$height}";
			}elseif($crop && !$aspect){
				$thumnail =  substr ( $image, 0, strpos ( $image, '.' )) . "_{$width}_{$height}_CA";
			}
			if($round){
				$thumnail .=  "_{$round}";
			}
			if($color!=="FFFFFF"){
				$thumnail .=  "_{$round}_{$color}";
			}
			if($transparency!=='127'){
				$thumnail .=  "_{$round}_{$color}_{$transparency}";
			}
			if(!$topleft || !$topright || !$botleft || !$botright){
				$tl = $topleft?1:0;
				$tr = $topright?1:0;
				$bl = $botleft?1:0;
				$br = $botright?1:0;
				$cornername = $tl.$tr.$bl.$br;
				$thumnail .=  "_{$round}_{$color}_{$transparency}_{$cornername}";
			}
			$thumnail .=  ".".$ext;
			$imageCache   = $this->__cachePath .  str_replace( '/', DS, $thumnail );
			if( file_exists($imageCache) ){
				$smallImg = getimagesize ( $imageCache );
				if ( ($smallImg [0] == $dst->w && $smallImg [1] == $dst->h)  ) {
					return  $this->__cacheURL. $thumnail;
				}
			} 
		
			if( !file_exists($this->__cachePath) && !mkdir($this->__cachePath) ) {
				return '';
			}
			
			if( !$this->makeDir( $image ) ) {
				return '';
			}
			
			// resize image
			$this->_resizeImage( $imagSource, $src, $dst, $size, $imageCache );
			
			if($round){
				//$this->round_corner( $imageCache, $imageCache,$round);
				//$this->round_corner2( $imageCache, $imageCache,"F8F8FA",$round);
				$this->round_corners($imageCache,$round,$color,$transparency,$topleft,$topright,$botleft,$botright);
			}
	//		function round_corners($image=null,$radius=20,$color='ffffff',$transparency='127')
	//		function round_corner2 ($source,$imageCache,$colour="FFFFFF",$radius=10,$angle=0,$topleft=true,$bottomleft=true,$bottomright=true,$topright=true){
	//		function round_conner($image_file,$imageCache,$corner_radius=20,$angle=0,$topleft=false,$bottomleft=false,$bottomright=false,$topright=false){
			return  $this->__cacheURL. $thumnail;
		}
		
		/**
		 * render image from other server. // this is pending.
		 *
		 * @param string $url the url of image.
		 * @param array $host contain server information ( using parse_url() function to return this value )
		 * @access public,
		 */
		function resizeLinkedImage( $url, $host ){
			
			if( !is_dir($this->__imageBase . DS . 'linked_images' . DS) ){
				if( !mkdir($this->__imageBase . DS . 'linked_images' . DS, 0755) ){
					return '';
				}
			}
		//	mkdir($this->__imageBase . DS . 'linked_images'.DS . $host['host'] . DS, 0755);
			//
			$filePath = $this->__imageBase. 'linked_images/'.$host['host'].'/' .'testthu.jpg';
			JFile::exists( $filePath );
				$source = file_get_contents( $url ); 
			JFile::write( $filePath, $source );
			$files = 'images/linked_images/'.$host['host'].'/testthu.jpg';
			
			$output = $this->resize( $files, 160, 80 );
			
		//	if( $this->_storeImage ){
			//	JFile::delete( $filePath  );
		//	}
			
			return $output;	
		}
		
		/**
		 *  check the folder is existed, if not make a directory and set permission is 755
		 *
		 *
		 * @param array $path
		 * @access public,
		 * @return boolean.
		 */
		function makeDir( $path ){
			$folders = explode ( '/',  ( $path ) );
			$tmppath = $this->__cachePath;	
			for( $i = 0; $i < count ( $folders ) - 1; $i ++) {
				if (! file_exists ( $tmppath . $folders [$i] ) && ! mkdir ( $tmppath . $folders [$i], 0755) ) {
					return false;
				}	
				$tmppath = $tmppath . $folders [$i] . DS;
			}		
			return true;
		}
				
		/**
		 *  process render image 
		 *
		 * @param string $imageSource is path of the image source.
		 * @param stdClass $src the setting of image source
		 * @param stdClass $dst the setting of image dts 
		 * @param string $imageCache path of image cache ( it's thumnail).
		 * @access public,
		 */
		function _resizeImage( $imageSource, $src, $dst, $size, $imageCache ){
			// create image from source.
			$extension = $this->types[$size[2]];
			$image = call_user_func( "imagecreatefrom".$extension, $imageSource );
			
			if( function_exists("imagecreatetruecolor") && ($newimage = imagecreatetruecolor($dst->w, $dst->h)) ){
				
				if( $extension == 'gif' || $extension == 'png' ){
					imagealphablending ( $newimage, false );
					imagesavealpha ( $newimage, true );
					$transparent = imagecolorallocatealpha ( $newimage, 255, 255, 255, 127 );
					imagefilledrectangle ( $newimage, 0, 0, $dst->w, $dst->h, $transparent );
				}
				
				imagecopyresampled ( $newimage, $image, $dst->x, $dst->y, $src->x, $src->y, $dst->w, $dst->h, $src->w, $src->h );
			} else {
				$newimage = imagecreate ( $width, $height );
				imagecopyresized ( $newimage, $image, $dst->x, $dst->y, $src->x, $src->y, $dst->w, $dst->h, $size[0], $size[1] );
			}
	 	
			switch( $extension ){
				case 'jpeg' :
					call_user_func( 'image'.$extension, $newimage, $imageCache, $this->__quality );	
					break;
				default:
					call_user_func( 'image'.$extension,$newimage, $imageCache );
					break;	
			}
			// free memory
			imagedestroy ( $image );
			imagedestroy ( $newimage );
		}
		
		/**
		 * set quality image will render.
		 */
		function setQuality( $number = 9 ){
			$this->__quality = $number;
		}
		
		/**
		 * check the image is a linked image from other server.
		 *
		 *
		 * @param string the url of image.
		 * @access public,
		 * @return array if it' linked image, return false if not
		 */
		function isLinkedImage( $imageURL ){
			$parser = parse_url($imageURL);
			return  strpos( JURI::base (), $parser['host'] ) ?false:$parser;
		}
		
		/**
		 * check the file is a image type ?
	 	 *
	 	 * @param string $ext
	 	 * @return boolean.
		 */
		function isImage( $ext = '' ){
			return in_array($ext, $this->types);
		}
		
		/**
		 * check the image source is existed ?
		 *
		 * @param string $imageSource the path of image source.
		 * @access public,
		 * @return boolean,
		 */
		function sourceExited( $imageSource ) {
			
			if( $imageSource == '' || $imageSource == '..' || $imageSource == '.' ){
				return false;
			}
			$imageSource = str_replace ( JURI::base (), '', $imageSource );
			$imageSource = rawurldecode ( $imageSource );
			return ( file_exists ( JPATH_SITE . '/' . $imageSource ) );	
		}
		
		/**
		 * check the image source is existed ?
		 *
		 * @param string $imageSource the path of image source.
		 * @access public,
		 * @return boolean,
		 */
		function parseImage( $text ) {
			$regex = "/\<img.+src\s*=\s*\"([^\"]*)\"[^\>]*\>/";
			preg_match ( $regex, $text, $matches );
			$images = (count ( $matches )) ? $matches : array ();
			$image = count ( $images ) > 1 ? $images [1] : '';
			return $image;
		}
	}
?>