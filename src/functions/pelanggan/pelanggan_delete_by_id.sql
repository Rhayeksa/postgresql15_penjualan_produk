create or replace function pelanggan_delete_by_id(
    _id int,
    out code int,
    out msg varchar(255)
)
as $$
declare
    err_context text;
begin

    code := 200;
    msg := 'Berhasil';

    if (select count(id) from pelanggan where id = _id) < 1 then
        raise no_data_found;
    end if;

    delete from pelanggan
    where id = _id;
    
    exception
        when no_data_found then
            raise info 'Code: 404';
            raise info 'Message: data tidak ditemukan';
            code := 404;
            msg := 'data tidak ditemukan';
        when others then
            GET STACKED DIAGNOSTICS err_context = PG_EXCEPTION_CONTEXT;
            RAISE INFO 'Error Name:%', SQLERRM;
            RAISE INFO 'Error State:%', SQLSTATE;
            RAISE INFO 'Error Context:%', err_context;
            code := 500;
            msg := 'Internal Server Error';

end; $$

language plpgsql;