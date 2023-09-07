create table if not exists produk(
    id serial,
    nama varchar(255) not null,
    harga int not null,
    stok int not null,
    primary key(id)
);