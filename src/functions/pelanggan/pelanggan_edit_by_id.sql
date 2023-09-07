create or replace function pelanggan_edit_by_id(
    _id int,
    _nama varchar(255) default null,
    _hp varchar(45)  default null,
    _gender varchar(45) default null,
    _alamat varchar(255) default null,
    out code int,
    out msg varchar(255)
)
as $$
declare
    err_context text;
    old_nama varchar(255);
    old_hp varchar(45);
    old_gender varchar(45);
    old_alamat varchar(255);
begin

    code := 200;
    msg := 'Berhasil';

    if (select count(id) from pelanggan where id = _id) < 1 then
        raise no_data_found;
    end if;

    select nama, hp, gender, alamat
    into old_nama, old_hp, old_gender, old_alamat
    from pelanggan
    where id = _id;

    _nama := case when _nama is not null then _nama else old_nama end;
    _hp := case when _hp is not null then _hp else old_hp end;
    _gender := case when _gender is not null then _gender else old_gender end;
    _alamat := case when _alamat is not null then _alamat else old_alamat end;

    update pelanggan
    set
        nama = _nama,
        hp = _hp,
        gender = _gender,
        alamat = _alamat
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