create or replace function produk_edit_by_id(
    _id int,
    _nama varchar(255) default null,
    _harga int default null,
    _stok int default null,
    out code int,
    out msg varchar(255)
)
as $$
declare
    err_context text;
    old_nama varchar(255);
    old_harga int;
    old_stok int;
begin

    code := 200;
    msg := 'Berhasil';

    if (select count(id) from produk where id = _id) < 1 then
        raise no_data_found;
    end if;

    select nama, harga, stok
    into old_nama, old_harga, old_stok
    from produk
    where id = _id;

    _nama := case when _nama is not null then _nama else old_nama end;
    _harga := case when _harga is not null then _harga else old_harga end;
    _stok := case when _stok is not null then _stok else old_stok end;

    update produk
    set
        nama = _nama,
        harga = _harga,
        stok = _stok
    where id = _id;
    
    exception
        when no_data_found then
            raise info 'Code: 404';
            raise info 'Message: data tidak ditemukan';
            code := 404;
            msg := 'data tidak ditemukan';
        when others then
            GET STACKED DIAGNOSTICS err_context = PG_EXCEPTION_CONTEXT;
            RAISE INFO 'Error Name:%',SQLERRM;
            RAISE INFO 'Error State:%', SQLSTATE;
            RAISE INFO 'Error Context:%', err_context;
            code := 500;
            msg := 'Internal Server Error';

end; $$

language plpgsql;