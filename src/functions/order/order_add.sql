create or replace function order_add(
    _kode_order varchar(45),
    _id_pelanggan int,
    _id_produk int,
    _quantity int,
    out code int,
    out msg varchar(255)
)
as $$
declare
    err_context text;
    v_order_id int;
    v_produk_harga int;
    v_total_harga int;
    v_grend_total_harga int;
    v_produk_stok int;
begin

    code := 201;
    msg := 'Berhasil';

    if (select count(id) from pelanggan where id = _id_pelanggan) < 1 then
        msg := 'Pelanggan tidak ditemukan';
        raise no_data_found;
    end if;

    if (select count(id) from produk where id = _id_produk) < 1 then
        msg := 'Produk tidak ditemukan';
        raise no_data_found;
    end if;

    if (select stok from produk where id =_id_produk) < _quantity then
        code := 400;
        msg := 'Stok produk tidak cukup';
        raise raise_exception;
    end if;

    if (select count(id) from orders where kode_order = _kode_order) < 1 then
        insert into orders(kode_order, id_pelanggan, grand_total_harga)
        values(_kode_order, _id_pelanggan, 0);
    end if;

    select id into v_order_id from orders where kode_order = _kode_order;
    select harga, stok into v_produk_harga, v_produk_stok from produk where id = _id_produk;

    v_total_harga := v_produk_harga * _quantity;

    insert into produk_order(id_order, id_produk, harga, quantity, total_harga)
    values(v_order_id, _id_produk, v_produk_harga, _quantity, v_total_harga);

    select sum(total_harga) into v_grend_total_harga from produk_order where id_order = v_order_id;
    update orders
    set grand_total_harga = v_grend_total_harga
    where id = v_order_id;

    v_produk_stok := v_produk_stok - _quantity;
    update produk
    set stok = v_produk_stok
    where id = _id_produk;

    exception
        when raise_exception then
            raise info 'Code: %', code;
            raise info 'Message: %', msg;
        when no_data_found then
            raise info 'Code: 404';
            raise info 'Message: %', msg;
            code := 404;
        when others then
            GET STACKED DIAGNOSTICS err_context = PG_EXCEPTION_CONTEXT;
            RAISE INFO 'Error Name:%',SQLERRM;
            RAISE INFO 'Error State:%', SQLSTATE;
            RAISE INFO 'Error Context:%', err_context;
            code := 500;
            msg := 'Internal Server Error';

end; $$

language plpgsql;