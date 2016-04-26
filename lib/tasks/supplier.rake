namespace :supplier do
  desc "Add random supplier id"
  task populate_supplier: :environment do
    products = Product.all
    products.each do |product|
      product.supplier_id = Supplier.all.sample.id
      product.available = true
      product.save
    end
  end

end
