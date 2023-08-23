include: "/views/*.view.lkml"

view: social_friendly_names {
  sql_table_name: `mightyhive-data-science-poc.friendly_names.social_friendly_names` ;;

  dimension: brand {
    type: string
    sql: ${TABLE}.Brand ;;
  }
  dimension: campaign_name {
    type: string
    sql: ${TABLE}.CampaignName ;;
    action: {
      label: "Add friendly name"
      url: "https://us-central1-mightyhive-data-science-poc.cloudfunctions.net/friendly_names"
      param: {
        name:"campaign_name"
        value: "{{ value }}"
        }
      form_param: {
        name: "friendly_name"
        type: textarea
        label: "Enter the friendly name"
        required: yes
        }
      form_param: {
        name: "contains"
        type: select
        label: "Do you want to impute the friendly name to all campaigns that contain some string in common?"
        required: yes
        option: {
          name: "No"
          label: "No"
        }
        option: {
          name: "Yes"
          label: "Yes"
        }
      }
      form_param: {
        name: "contains_string"
        type: textarea
        label: "Enter the string in common"
        required: no
      }
    }
  }
  dimension: friendly_name {
    type: string
    sql: ${TABLE}.Friendly_Name ;;
  }
  dimension_group: max {
    type: time
    description: "%E4Y-%m-%d"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.MaxDate ;;
  }
  dimension: new_friendly_name {
    type: string
    sql: ${TABLE}.New_Friendly_Name ;;
  }
  dimension: partner {
    type: string
    sql: ${TABLE}.Partner ;;
  }
  measure: count {
    type: count
    drill_fields: [friendly_name, campaign_name, new_friendly_name]
  }
}
