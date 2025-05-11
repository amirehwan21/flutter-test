import 'package:flutter/material.dart';
import 'package:myeg_flutter_test/model/productModel.dart';
import 'package:myeg_flutter_test/network/apiService.dart';
import 'package:myeg_flutter_test/ui/components/productListView.dart';
import 'package:myeg_flutter_test/ui/pages/cart.dart';
import 'package:myeg_flutter_test/ui/pages/productDetail.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  int _selectedFilterIndex = 0;
  List<ProductModel> _filteredProducts = [];
  List<ProductModel> _allProducts = [];

  late final Future<List<ProductModel>> _productsFuture;


  @override
  void initState() {
    super.initState();
    _productsFuture = ApiService.fetchProducts().then((products) {
      _allProducts = products;
      _filteredProducts = products;
      return products;
    });
  }

  void searchProducts(String query) {
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        final titleLower = product.title.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList();
    });
    print(_filteredProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            topDesign(),
            bottomDesign()
          ],
        ),
      )
    );
  }


  Widget topDesign() {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .35,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/appbanner.jpg',
              fit: BoxFit.fill,
              color: Colors.black38,
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 10, right: 10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartPage()),
                      );
                    }
                  )
                ),
              ],
            )
          ),
        ],
      ),
    );
  }

  Widget bottomDesign() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .25, bottom: 100),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          children: [
            search(),
            filter(),
            listView()
          ],
        ),
      ),
    );
  }

  Widget search() {
    return Container(
      margin: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search Product',
          hintStyle: TextStyle(color: Colors.grey.shade500),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Icon(Icons.search, color: Colors.grey.shade600),
        ),
        onChanged: (value) {
          searchProducts(value);
        }
      )
    );
  }

  Widget filter() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          _buildFilterButton(0, "All"),
          SizedBox(width: 8),
          _buildFilterButton(1, "Men"),
          SizedBox(width: 8),
          _buildFilterButton(2, "Women"),

        ],
      ),
    );
  }

  Widget _buildFilterButton(int index, String label) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedFilterIndex = index;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: _selectedFilterIndex == index 
                ? Colors.blue
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: _selectedFilterIndex == index 
                    ? Colors.white
                    : Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget listView() {
    return FutureBuilder<List<ProductModel>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No products available'));
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _filteredProducts.length,
          itemBuilder: (context, index) {
            final product = _filteredProducts[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ProductListView(
                name: product.title,
                price: product.price,
                rating: product.rating.rate,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductDetailPage(product: product)),
                  );
                },
              ),
            );
          },
        );
      }
    );
  }
}



