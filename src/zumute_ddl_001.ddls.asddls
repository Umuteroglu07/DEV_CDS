@AbapCatalog.sqlViewName: 'ZUMUTE_V_006'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS session 2 ödev'
define view zumute_ddl_004 as 
select from vbrp
        inner join vbrk
        on  vbrk.vbeln = vbrp.vbeln
        inner join mara
        on  mara.matnr = vbrp.matnr
        left outer join vbak
        on  vbak.vbeln = vbrp.aubel
        left outer join kna1
        on  kna1.kunnr = vbak.kunnr
        left outer join makt
        on  makt.matnr = mara.matnr
        and makt.spras = $session.system_language

{
 key vbrp.vbeln,
  key vbrp.posnr,
  vbrp.aubel,
  vbrp.aupos,
  vbak.kunnr,
  vbrk.inco2_l,
  concat (kna1.name1,concat(' ', kna1.name2)) as kunnrAd,
  currency_conversion( 
  amount =>vbrp.netwr,
  source_currency=>vbrp.waerk,
  target_currency=>cast('EUR' as abap.cuky),
  exchange_rate_date=>vbrk.fkdat
  )       as conversion_netwr,
  left(vbak.kunnr,3) as left_kunnr,
  length(mara.matnr) as matnr_length,
   @EndUserText.label: 'Faturalama Türü'
  case vbrk.fkart
            when 'FAS' then 'Peşinat talebi iptali'
            when 'FAZ'  then 'Peşinat talebi'
            else 'Fatura'
            end as faturalama_turu,
  vbrk.fkdat
}
