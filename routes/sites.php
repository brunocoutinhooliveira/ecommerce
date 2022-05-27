<?php

use Hcode\Model\Product;
use \Hcode\Page;

$app->get('/', function () {
    // $sql = new Hcode\DB\Sql();
    // $results = $sql->select("SELECT * FROM tb_users");
    // echo json_encode($results);
    // echo "OK";
    $products = Product::listAll();

    $page = new Page();

    $page->setTpl("index", [
        'products' => Product::checkList($products)
    ]);
});
