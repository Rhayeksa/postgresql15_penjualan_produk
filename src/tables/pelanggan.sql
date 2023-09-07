create table if not exists pelanggan(
    id serial,
    nama varchar(255) not null,
    hp varchar(45) not null,
    gender varchar(45) not null check(gender in('Pria', 'Wanita')),
    alamat varchar(255) not null,
    primary key(id)
);