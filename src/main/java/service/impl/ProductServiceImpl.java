package service.impl;

import dao.IImageDAO;
import dao.IProducerDAO;
import dao.IProductDAO;
import dao.IProductTypeDAO;
import dao.impl.ImageDAOImpl;
import dao.impl.ProducerDAOImpl;
import dao.impl.ProductDAOImpl;
import dao.impl.ProductTypeDAOImpl;
import model.Image;
import model.Producer;
import model.Product;
import model.ProductType;
import service.IProductService;
import utils.CacheManager;

import java.util.List;

public class ProductServiceImpl implements IProductService {
    private IProductDAO productDAO = new ProductDAOImpl();
    private IImageDAO imageDAO = new ImageDAOImpl();
    private IProducerDAO producerDAO = new ProducerDAOImpl();
    private IProductTypeDAO productTypeDAO = new ProductTypeDAOImpl();

    private static final String CACHE_KEY_ALL_PRODUCTS = "all_products";
    private static final String CACHE_KEY_NEW_PRODUCTS = "new_products";
    private static final String CACHE_KEY_SALE_PRODUCTS = "sale_products";
    private static final String CACHE_KEY_SELLING_PRODUCTS = "selling_products";

    @Override
    public List<Product> findAll() {
        List<Product> products = (List<Product>) CacheManager.get(CACHE_KEY_ALL_PRODUCTS);
        if (products == null) {
            System.out.println("Cache khong co du lieu cho " + CACHE_KEY_ALL_PRODUCTS + " - Dang truy van tu database");
            products = productDAO.findAll();
            for (Product product : products) {
                List<Image> images = imageDAO.findByProductId(product.getId());
                ProductType productType = productTypeDAO.findById(product.getProductTypeID());
                Producer producer = producerDAO.findById(product.getProducerID());
                product.setImages(images);
                product.setProductType(productType);
                product.setProducer(producer);
            }
            CacheManager.put(CACHE_KEY_ALL_PRODUCTS, products);
        } else {
            System.out.println("Da lay du lieu tu cache cho " + CACHE_KEY_ALL_PRODUCTS);
        }
        return products;
    }

    @Override
    public List<Product> findNewProduct() {
        List<Product> products = (List<Product>) CacheManager.get(CACHE_KEY_NEW_PRODUCTS);
        if (products == null) {
            System.out.println("Cache khong co du lieu cho " + CACHE_KEY_NEW_PRODUCTS + " - Dang truy van tu database");
            products = productDAO.findNewProduct();
            for (Product product : products) {
                List<Image> images = imageDAO.findByProductId(product.getId());
                product.setImages(images);
            }
            CacheManager.put(CACHE_KEY_NEW_PRODUCTS, products);
        } else {
            System.out.println("Da lay du lieu tu cache cho " + CACHE_KEY_NEW_PRODUCTS);
        }
        return products;
    }

    @Override
    public List<Product> findSaleProduct() {
        List<Product> products = (List<Product>) CacheManager.get(CACHE_KEY_SALE_PRODUCTS);
        if (products == null) {
            System.out.println("Cache khong co du lieu cho " + CACHE_KEY_SALE_PRODUCTS + " - Dang truy van tu database");
            products = productDAO.findSaleProduct();
            for (Product product : products) {
                List<Image> images = imageDAO.findByProductId(product.getId());
                product.setImages(images);
            }
            CacheManager.put(CACHE_KEY_SALE_PRODUCTS, products);
        } else {
            System.out.println("Da lay du lieu tu cache cho " + CACHE_KEY_SALE_PRODUCTS);
        }
        return products;
    }

    @Override
    public List<Product> findSellingProduct() {
        List<Product> products = (List<Product>) CacheManager.get(CACHE_KEY_SELLING_PRODUCTS);
        if (products == null) {
            System.out.println("Cache khong co du lieu cho " + CACHE_KEY_SELLING_PRODUCTS + " - Dang truy van tu database");
            products = productDAO.findProductIsSelling();
            for (Product product : products) {
                List<Image> images = imageDAO.findByProductId(product.getId());
                product.setImages(images);
            }
            CacheManager.put(CACHE_KEY_SELLING_PRODUCTS, products);
        } else {
            System.out.println("Da lay du lieu tu cache cho " + CACHE_KEY_SELLING_PRODUCTS);
        }
        return products;
    }

    @Override
    public Product findProductById(int id) {
        Product product = productDAO.findById(id);
        if (product != null) {
            List<Image> images = imageDAO.findByProductId(id);
            ProductType productType = productTypeDAO.findById(product.getProductTypeID());
            Producer producer = producerDAO.findById(product.getProducerID());
            product.setProductType(productType);
            product.setProducer(producer);
            product.setImages(images);
        }
        return product;
    }

    public static void main(String[] args) {
        ProductServiceImpl productService = new ProductServiceImpl();
        Product product = productService.findProductById(1);

        System.out.println(productService.findNewProduct());
//        System.out.println("Product ID: " + product.getId());
//        System.out.println("Product Name: " + product.getName());
//        System.out.println("Product Price: " + product.getPrice());
//        System.out.println("Product Detail: " + product.getDetail());
//        if (product.getImages() != null && !product.getImages().isEmpty()) {
//            System.out.println("Images:");
//            for (Image image : product.getImages()) {
//                System.out.println("  Image ID: " + image.getId());
//                System.out.println("  Image Link: " + image.getLinkImage());
//            }
//        }
//        System.out.println("---------------------------");

    }

    @Override
    public List<Product> findByName(String productName) {
        List<Product> products = productDAO.findByName(productName);
        for (Product product : products) {
            List<Image> images = imageDAO.findByProductId(product.getId());
            product.setImages(images);
        }
        return products;
    }

    @Override
    public List<Product> findByProducer(Integer idProducer) {
        List<Product> products = productDAO.findByProducer(idProducer);
        for (Product product : products) {
            List<Image> images = imageDAO.findByProductId(product.getId());
            product.setImages(images);
        }
        return products;
    }

    @Override
    public List<Product> findByCategory(Integer idCategory) {
        List<Product> products = productDAO.findByCategory(idCategory);
        for (Product product : products) {
            List<Image> images = imageDAO.findByProductId(product.getId());
            product.setImages(images);
        }
        return products;
    }

    @Override
    public List<Product> getPaging(int index){
        List<Product> products = productDAO.getPaging(index);
        for (Product product : products) {
            List<Image> images = imageDAO.findByProductId(product.getId());
            ProductType productType = productTypeDAO.findById(product.getProductTypeID());
            Producer producer = producerDAO.findById(product.getProducerID());
            product.setImages(images);
            product.setProductType(productType);
            product.setProducer(producer);
        }
        return products;
    }

    @Override
    public boolean deleteById(Integer productId) {
        boolean result = productDAO.deleteById(productId);
        if (result) {
            clearProductCache();
        }
        return result;
    }

    @Override
    public List<Product> findProductToImport() {
        List<Product> products = productDAO.findProductToImport();
        for (Product product : products) {
            List<Image> images = imageDAO.findByProductId(product.getId());
            product.setImages(images);
            ProductType productType = productTypeDAO.findById(product.getProductTypeID());
            product.setProductType(productType);
            Producer producer = producerDAO.findById(product.getProducerID());
            product.setProducer(producer);
        }
        return products;
    }

    @Override
    public List<Product> findBestSeller() {
        List<Product> products = productDAO.findBestSeller();
        for (Product product : products) {
            List<Image> images = imageDAO.findByProductId(product.getId());
            product.setImages(images);
            ProductType productType = productTypeDAO.findById(product.getProductTypeID());
            product.setProductType(productType);
            Producer producer = producerDAO.findById(product.getProducerID());
            product.setProducer(producer);
        }
        return products;
    }

    @Override
    public List<Product> findProductInStock() {
        List<Product> products = productDAO.findProductInStock();
        for (Product product : products) {
            List<Image> images = imageDAO.findByProductId(product.getId());
            product.setImages(images);
            ProductType productType = productTypeDAO.findById(product.getProductTypeID());
            product.setProductType(productType);
            Producer producer = producerDAO.findById(product.getProducerID());
            product.setProducer(producer);
        }
        return products;
    }

    @Override
    public boolean updateProduct(Product product) {
        boolean result = productDAO.updateProduct(product);
        if (result) {
            clearProductCache();
        }
        return result;
    }
    @Override
    public boolean insert(Product product) {
        boolean result = productDAO.addProduct(product);
        if (result) {
            clearProductCache();
        }
        return result;
    }

    @Override
    public List<ProductType> getProductTypes() {
        return productTypeDAO.findAll();
    }

    @Override
    public List<Producer> getProducers() {
        return producerDAO.findAll(); // hoặc trả về danh sách Producer theo logic cụ thể
    }

    private void clearProductCache() {
        CacheManager.remove(CACHE_KEY_ALL_PRODUCTS);
        CacheManager.remove(CACHE_KEY_NEW_PRODUCTS);
        CacheManager.remove(CACHE_KEY_SALE_PRODUCTS);
        CacheManager.remove(CACHE_KEY_SELLING_PRODUCTS);
    }
}


