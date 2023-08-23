include: "/views/*.view.lkml"


view: datamart_social_friendly_names {
  derived_table: {
    sql:
    SELECT
      a.*,
      COALESCE(b.Friendly_Name, CONCAT(SPLIT(a.campaign, '_')[SAFE_OFFSET(2)], ' | ', SPLIT(a.campaign, '_')[SAFE_OFFSET(3)])) AS campaign_friendly_name
    FROM ${datamart_social_looker.SQL_TABLE_NAME} a
    LEFT JOIN ${social_friendly_names.SQL_TABLE_NAME}  b
    ON
      campaign=b.CampaignName AND a.brand=b.Brand
    #WHERE a.date >= DATE('2023-04-01')
    ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }
  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }
  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }
  dimension: partner {
    type: string
    sql: ${TABLE}.partner ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: campaign_friendly_name {
    type: string
    sql: ${TABLE}.campaign_friendly_name ;;
  }

  measure: sum_clicks {
    type: sum
    sql: ${clicks} ;;
  }

  measure: sum_spend {
    type: sum
    sql: ${TABLE}.spend ;;
  }

  measure: sum_revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
  }

  measure: sum_visits {
    type: sum
    sql: ${TABLE}.visits ;;
  }

}
