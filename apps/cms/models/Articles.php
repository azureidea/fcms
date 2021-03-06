<?php

namespace apps\cms\models;

!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

/**
 * 文章表模型
 * @author Carey
 *
 */
class Articles extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     */
    public $id;

    /**
     *
     * @var string
     */
    public $addtime;

    /**
     *
     * @var string
     */
    public $uptime;

    /**
     *
     * @var integer
     */
    public $delsign;

    /**
     *
     * @var string
     */
    public $descr;

    /**
     *
     * @var string
     */
    public $title;

    /**
     *
     * @var string
     */
    public $description;

    /**
     *
     * @var integer
     */
    public $cat_id;

    /**
     *
     * @var string
     */
    public $content;

    /**
     *
     * @var integer
     */
    public $status;

    /**
     *
     * @var string
     */
    public $begin_time;

    /**
     *
     * @var string
     */
    public $end_time;

    /**
     *
     * @var integer
     */
    public $top;

    /**
     *
     * @var string
     */
    public $author;

    /**
     *
     * @var string
     */
    public $keywords;
    
    /**
     * @var string
     */
    public $face;
    
    /**
     * @var string
     */
    public $pubtime;
    

    /**
     * Independent Column Mapping.
     * Keys are the real names in the table and the values their names in the application
     *
     * @return array
     */
    public function columnMap()
    {
        return array(
            'id'          => 'id',
            'addtime'     => 'addtime',
            'uptime'      => 'uptime',
            'delsign'     => 'delsign',
            'descr'       => 'descr',
            'title'       => 'title',
            'description' => 'description',
            'cat_id'      => 'cat_id',
            'content'     => 'content',
            'status'      => 'status',
            'begin_time'  => 'begin_time',
            'end_time'    => 'end_time',
            'top'         => 'top',
            'author'      => 'author',
            'keywords'    => 'keywords',
        	'face'		  => 'face',
        	'pubtime'	  => 'pubtime',
        );
    }

    public function initialize()
    {
        $this->useDynamicUpdate( true );
        
        $this->hasMany( 'id' , '\apps\cms\models\ArticleTags' , 'aid' , array( 'alias' => 'arttags' ) );
        $this->belongsTo( 'cat_id' , '\apps\cms\models\ArticleCats' , 'id' , array( 'alias' => 'catinfo' ) );
        $this->setSource( 'xuxu_articles' );
    }
}
