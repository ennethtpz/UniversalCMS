/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
    // config.uiColor = '#AADC6E';

    // Integrate roxyfileman to ckeditor 
    //config.filebrowserBrowseUrl = '/fileman/index.html?integration=ckeditor';
    //config.filebrowserImageBrowseUrl = '/fileman/index.html?integration=ckeditor&type=image';
    config.filebrowserBrowseUrl = '/fileman/default.aspx?integration=ckeditor';
    config.filebrowserImageBrowseUrl = '/fileman/default.aspx?integration=ckeditor&type=image';
    config.disallowedContent = 'img{height};';
};
