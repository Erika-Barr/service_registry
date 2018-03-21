module RequestSpecHelper
# Parse JSON response to ruby hash
  def response
    JSON.parse(response_body)
  end

  def response_for(action)
    responses = {
      all_services: {
        "data": [
             {
                 "id": "1",
                 "type": "service_registry",
                 "attributes": {
                     "service": "test",
                     "version": "1.0.0",
                     "status": "created"
                 }
            }
        ],
        "meta": [
            {
               "message": "All services in service registry"
            },
            {
               "service_instance_count": 1
            }
         ]
      },
      creating_service: {
        "data": {
            "id": "2",
            "type": "service_registry",
            "attributes": {
                "service": "test",
                "version": "1.0.0",
                "status": "created"
            }
        },
        "meta": {
            "message": "successfully created service"
        }
      },
      searching_with_version: {
        "data": [
            {
                "id": "1",
                "type": "service_registry",
                "attributes": {
                    "service": "test",
                    "version": "1.0.0",
                    "status": "created"
                }
            }
        ],
        "meta": [
            {
                "message": "list of services with specific version"
            },
            {
                "service_instance_count": 1
            }
        ]
      },
      searching_without_version: {
        "data": [
            {
                "id": "1",
                "type": "service_registry",
                "attributes": {
                    "service": "test",
                    "version": "1.0.0",
                    "status": "created"
                }
            }
        ],
        "meta": [
            {
                "message": "list of services of type: test"
            },
            {
                "service_instance_count": 1
            }
        ]
      },
      nonexistent_service: {
        "data": {
                "id": nil,
                "type": "service_registry",
                "attributes": {
                    "service": "test",
                    "version": "9.0.0",
                    "status": "not_a_service"
                }
        },
        "meta": [
            {
                "message": "cannot find service records for requested version"
            },
            {
                "service_instance_count": 0
            }
        ]
      },
      updating_service: {
        "data": {
            "id": "1",
            "type": "service_registry",
            "attributes": {
                "service": "test_updated",
                "version": "1.0.0",
                "status": "updated"
            }
        },
        "meta": {
            "message": "successfully updated service"
        }
      },
      deleting_service: {
        "data": {
            "id": "1",
            "type": "service_registry",
            "attributes": {
                "service": "test",
                "version": "1.0.0",
                "status": "removed"
            }
        },
        "meta": {
            "message": "successfully removed service"
        }
      }
    } #hash end
    responses[action]
  end
end
