create or replace function produk_add(
    _nama varchar(255),
    _harga int,
    _stok int,
    out code int,
    out msg varchar(255)
)
as $$
declare
    err_context text;
begin

    code := 201;
    msg := 'Berhasil';

    insert into produk(nama, harga, stok)
    values(_nama,_harga,_stok);

    exception
        when others then
            GET STACKED DIAGNOSTICS err_context = PG_EXCEPTION_CONTEXT;
            RAISE INFO 'Error Name:%',SQLERRM;
            RAISE INFO 'Error State:%', SQLSTATE;
            RAISE INFO 'Error Context:%', err_context;
            code := 500;
            msg := 'Internal Server Error';

end; $$

language plpgsql;