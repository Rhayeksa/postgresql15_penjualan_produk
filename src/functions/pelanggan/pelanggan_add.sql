create or replace function pelanggan_add(
    _nama varchar(255),
    _hp varchar(45),
    _gender varchar(45),
    _alamat varchar(255),
    out code int,
    out msg varchar(255)
)
as $$
declare
    err_context text;
begin

    code := 201;
    msg := 'Berhasil';

    insert into pelanggan(nama, hp, gender, alamat)
    values(_nama,_hp,_gender,_alamat);

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