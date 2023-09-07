create table if not exists produk_order(
    id serial,
    id_order int not null,
    id_produk int not null,
    quantity int not null,
    harga int not null,
    total_harga int not null,
    primary key(id),
    foreign key(id_order) references orders(id),
    foreign key(id_produk) references produk(id)
);