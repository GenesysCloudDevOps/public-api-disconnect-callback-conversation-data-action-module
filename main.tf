resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "additionalProperties" = true,
        "properties" = {
            "ConversationId" = {
                "type" = "string"
            }
        },
        "type" = "object"
    })
    contract_output = jsonencode({
        "additionalProperties" = true,
        "properties" = {},
        "type" = "object"
    })
    
    config_request {
        request_template     = "{ \"state\": \"disconnected\" }"
        request_type         = "PATCH"
        request_url_template = "/api/v2/conversations/callbacks/$${input.ConversationId}"
    }

    config_response {
        success_template = "$${rawResult}"
    }
}