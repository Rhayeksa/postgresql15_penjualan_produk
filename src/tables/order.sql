create table if not exists orders(
    id serial,
    id_pelanggan int not null,
    kode_order varchar(45) not null,
    grand_total_harga int not null,
    primary key(id),
    foreign key(id_pelanggan) references pelanggan(id)
);