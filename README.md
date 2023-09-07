# Postgre15 penjualan product

## Setup

### With Doker Compose

- create container

```
docker-compose up -d
```

- create database and table

```
docker exec -t postgres15_penjualan_produk psql -U postgres -c "create database penjualan_produk" &&
docker exec -t postgres15_penjualan_produk psql -U postgres -d "penjualan_produk" -f ./code/tables/pelanggan.sql &&
docker exec -t postgres15_penjualan_produk psql -U postgres -d "penjualan_produk" -f ./code/tables/produk.sql &&
docker exec -t postgres15_penjualan_produk psql -U postgres -d "penjualan_produk" -f ./code/tables/order.sql &&
docker exec -t postgres15_penjualan_produk psql -U postgres -d "penjualan_produk" -f ./code/tables/produk_order.sql
```

- create functions

```
docker exec -t postgres15_penjualan_produk psql -U postgres -d "penjualan_produk" -f ./code/functions/pelanggan/pelanggan_add.sql &&
docker exec -t postgres15_penjualan_produk psql -U postgres -d "penjualan_produk" -f ./code/functions/pelanggan/pelanggan_edit_by_id.sql &&
docker exec -t postgres15_penjualan_produk psql -U postgres -d "penjualan_produk" -f ./code/functions/pelanggan/pelanggan_delete_by_id.sql &&
docker exec -t postgres15_penjualan_produk psql -U postgres -d "penjualan_produk" -f ./code/functions/produk/produk_add.sql &&
docker exec -t postgres15_penjualan_produk psql -U postgres -d "penjualan_produk" -f ./code/functions/produk/produk_edit_by_id.sql &&
docker exec -t postgres15_penjualan_produk psql -U postgres -d "penjualan_produk" -f ./code/functions/produk/produk_delete_by_id.sql &&
docker exec -t postgres15_penjualan_produk psql -U postgres -d "penjualan_produk" -f ./code/functions/order/order_add.sql
```

### With Local Environment

- create database and table

```
psql -U postgres -c "create database penjualan_produk" &&
psql -U postgres -d "penjualan_produk" -f ./code/tables/pelanggan.sql &&
psql -U postgres -d "penjualan_produk" -f ./code/tables/produk.sql &&
psql -U postgres -d "penjualan_produk" -f ./code/tables/order.sql &&
psql -U postgres -d "penjualan_produk" -f ./code/tables/produk_order.sql
```

- create functions

```
psql -U postgres -d "penjualan_produk" -f ./code/functions/pelanggan/pelanggan_add.sql &&
psql -U postgres -d "penjualan_produk" -f ./code/functions/pelanggan/pelanggan_edit_by_id.sql &&
psql -U postgres -d "penjualan_produk" -f ./code/functions/pelanggan/pelanggan_delete_by_id.sql &&
psql -U postgres -d "penjualan_produk" -f ./code/functions/produk/produk_add.sql &&
psql -U postgres -d "penjualan_produk" -f ./code/functions/produk/produk_edit_by_id.sql &&
psql -U postgres -d "penjualan_produk" -f ./code/functions/produk/produk_delete_by_id.sql &&
psql -U postgres -d "penjualan_produk" -f ./code/functions/order/order_add.sql
```

## Penggunaan

### Module Pelanggan

- pelanggan Add

```
select pelanggan_add(
    _nama => 'nama',
    _hp => 'nomor hp',
    _gender => 'Pria' atau 'Wanita',
    _alamat => 'alamat'
);
```

- pelanggan Find All (Building)

```
select pelanggan_find_all(
    _page_size => '5',
    _page_num => '1'
);
```

- pelanggan Find By Id (Building)

```
select pelanggan_find_by_id(
    _id => '1'
);
```

- pelanggan Edit

```
select pelanggan_edit(
    _id => '1',
    _nama => '',
    _hp => '',
    _gender => '',
    _alamat => ''
);
```

- pelanggan Delete By Id

```
select pelanggan_delete_by_id(
    _id => '1'
);
```

### Module Produk

- Produk Add

```
select pelanggan_add(
    _nama => 'nama',
    _hp => 'nomor hp',
    _gender => 'Pria' atau 'Wanita',
    _alamat => 'alamat'
);
```

- Produk Find All (Building)

```
select pelanggan_find_all(
    _page_size => '5',
    _page_num => '1'
);
```

- Produk Find By Id (Building)

```
select pelanggan_find_by_id(
    _id => '1'
);
```

- Produk Edit

```
select pelanggan_edit(
    _id => '1',
    _nama => '',
    _hp => '',
    _gender => '',
    _alamat => ''
);
```

- Produk Delete By Id

```
select pelanggan_delete_by_id(
    _id => '1'
);
```

### Module Order

- Order Add

```
select order_add(
    _kode_order => 'SO001',
    _id_pelanggan => 1,
    _id_produk => 1,
    _quantity => 5
);
```

- Order Find All (Building)

```
Building...
```

- Order Find By Kode Order (Building)

```
Building...
```

- Order Edit Produk Order By Kode Order (Building)

```
Building...
```

- Order Detele Produk Order By Kode Order (Building)

```
Building...
```
