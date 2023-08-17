view: datamart_social_looker {
  sql_table_name: `mightyhive-data-science-poc.friendly_names.datamart_social_looker` ;;

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

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: spend {
    type: number
    sql: ${TABLE}.spend ;;
  }

  dimension: visits {
    type: number
    sql: ${TABLE}.visits ;;
  }

  measure: count {
    type: count
  }
}
