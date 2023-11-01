@AbapCatalog.sqlViewName: 'ZUMUTE_V_007'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS eğitim session 2 ikinci ödev'
define view zumute_ddl_002 as
 select from zumute_ddl_004
{
    key vbeln,
    sum(conversion_netwr) as toplam_net_deger,
    kunnrAd,
    count(*) as toplam_fatura,
    (cast(sum(conversion_netwr) as abap.fltp) / cast(count(*) as abap.fltp)) as ortalama_miktar,
    substring(zumute_ddl_004.fkdat,1,4)   as faturalama_yili,
    substring(zumute_ddl_004.fkdat,4,2)   as faturalama_ayi,
    substring(zumute_ddl_004.fkdat,6,2)   as faturalama_gunu,
    substring(zumute_ddl_004.inco2_l,1,3) as incoterm_yeri   
}
group by vbeln,
         kunnrAd,
         fkdat,
         inco2_l
 