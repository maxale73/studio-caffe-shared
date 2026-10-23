import Foundation
import Testing
import studio_caffe_shared

struct ServiceTests {
    @Test func activitiesKeepTheirPairsIdentityAndOrder() throws {
        let component = ServiceCatalogDTO(id: UUID(), serviceDescription: "gruppo espresso")
        let items = [ServiceItemDTO(id: UUID(), catalog: component, operationType: .lavaggio),
                     ServiceItemDTO(id: UUID(), catalog: component, operationType: .riparazione)]
        let service = ServiceDTO(id: UUID(), machineID: UUID(), items: items, serviceDate: .now,
                                 counter: nil, userID: UUID(), recordedAt: nil, note: nil, parts: [])
        let decoded = try decoder.decode(ServiceDTO.self, from: JSONEncoder.scEncoder.encode(service))
        #expect(decoded.items == items)
        #expect(decoded.items.map(\.description) == ["gruppo espresso · lavaggio", "gruppo espresso · riparazione"])
        let selection = items.map { ServiceItemToSave(id: $0.id, catalogID: $0.catalog.id, operationType: $0.operationType) }
        #expect(ServiceItemToSave.isValidSelection(selection))
        #expect(!ServiceItemToSave.isValidSelection([]))
        #expect(!ServiceItemToSave.isValidSelection(selection + [selection[0]]))
        #expect(!ServiceItemToSave.isValidSelection(selection + [.init(catalogID: component.id, operationType: .lavaggio)]))
        let tooMany = (0...50).map { _ in ServiceItemToSave(catalogID: UUID(), operationType: .lavaggio) }
        #expect(!ServiceItemToSave.isValidSelection(tooMany))
    }

    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    @Test(arguments: ServiceOperationType.allCases)
    func serviceRoundTripPreservesOperationAndParts(_ operationType: ServiceOperationType) throws {
        let catalog = ServiceCatalogDTO(id: UUID(), serviceDescription: "Gruppo espresso")
        let part = ServicePartDTO(id: UUID(), product: ProductID(id: UUID(), productDescription: "Guarnizione"), quantity: 2)
        let service = ServiceDTO(id: UUID(), machineID: UUID(), items: [ServiceItemDTO(id: UUID(), catalog: catalog, operationType: operationType)], serviceDate: Date(timeIntervalSince1970: 1_000), counter: 42_150, userID: UUID(), recordedAt: Date(timeIntervalSince1970: 2_000), note: "Controllo tenuta", parts: [part], requestID: UUID())
        let page = ServicePageDTO(items: [service], page: 1, per: 50, total: 1)
        let data = try JSONEncoder.scEncoder.encode(page)
        let decoded = try decoder.decode(ServicePageDTO.self, from: data)
        #expect(decoded == page)
    }

    @Test func optionalCounterAndNoteRemainAbsent() throws {
        let service = ServiceToSave(id: UUID(), machineID: UUID(), items: [ServiceItemToSave(catalogID: UUID(), operationType: .riparazione)], serviceDate: Date(timeIntervalSince1970: 0), counter: nil)
        let data = try #require(service.toJSONData())
        let decoded = try decoder.decode(ServiceToSave.self, from: data)
        #expect(decoded == service)
        #expect(decoded.counter == nil)
        #expect(decoded.note == nil)
        #expect(decoded.parts.isEmpty)
        #expect(decoded.requestID == nil)
        #expect(throws: (any Error).self) {
            try JSONDecoder().decode(ServiceOperationType.self, from: Data("\"invalid\"".utf8))
        }
    }

    @Test func endpointsShareRoutesAndRequestBodies() throws {
        let machineID = UUID()
        let filter = ServiceHistoryFilter(page: 2, per: 10, catalogID: UUID(), operationType: .lavaggio, requestID: UUID())
        let endpoint = ServiceEndpointsGroup.fetchByMachine(machineID: machineID, filter: filter)
        #expect(endpoint.group == "service")
        #expect(endpoint.clientRoute == "service/fetch_by_machine/\(machineID.uuidString)/")
        #expect(endpoint.serverRoute == ["fetch_by_machine", ":machine_id"])
        #expect(endpoint.httpMethod == .post)
        #expect(endpoint.requiresToken)
        #expect(!endpoint.allowsCaching)
        let body = try #require(endpoint.body?.toJSONData())
        #expect(try decoder.decode(ServiceHistoryFilter.self, from: body) == filter)
        #expect(ServiceCatalogEndpointsGroup.index().serverRoute == ["index"])
        #expect(ServiceCatalogEndpointsGroup.save().group == "service_catalog")
        let catalogID = UUID()
        let deletion = ServiceCatalogEndpointsGroup.delete(catalogID: catalogID)
        #expect(deletion.clientRoute == "service_catalog/delete/\(catalogID.uuidString)/")
        #expect(deletion.serverRoute == ["delete", ":catalog_id"])
        #expect(deletion.httpMethod == .post)
        #expect(deletion.requiresToken)
        #expect(!deletion.allowsCaching)
    }

    @Test func catalogUsageRoundTripsAndOlderResponsesRemainReadable() throws {
        let catalog = ServiceCatalogDTO(id: UUID(), serviceDescription: "Gruppo espresso", hasBeenUsed: true)
        let data = try JSONEncoder.scEncoder.encode(catalog)
        #expect(try decoder.decode(ServiceCatalogDTO.self, from: data) == catalog)
        var legacy = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
        legacy.removeValue(forKey: "hasBeenUsed")
        let decoded = try decoder.decode(ServiceCatalogDTO.self, from: JSONSerialization.data(withJSONObject: legacy))
        #expect(decoded.id == catalog.id)
        #expect(!decoded.hasBeenUsed)
    }

    @Test func requestLinksRoundTripAndOlderServicesRemainReadable() throws {
        let requestID = UUID()
        let service = ServiceToSave(id: UUID(), machineID: UUID(), items: [ServiceItemToSave(catalogID: UUID(), operationType: .lavaggio)], serviceDate: Date(timeIntervalSince1970: 0), counter: nil, requestID: requestID)
        let data = try #require(service.toJSONData())
        #expect(try decoder.decode(ServiceToSave.self, from: data).requestID == requestID)
        var older = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
        older.removeValue(forKey: "requestID")
        #expect(try decoder.decode(ServiceToSave.self, from: JSONSerialization.data(withJSONObject: older)).requestID == nil)
        let response = ServiceDTO(id: service.id, machineID: service.machineID, items: [ServiceItemDTO(id: UUID(), catalog: ServiceCatalogDTO(id: service.items[0].catalogID, serviceDescription: "gruppo espresso"), operationType: service.items[0].operationType)], serviceDate: service.serviceDate, counter: nil, userID: UUID(), recordedAt: nil, note: nil, parts: [], requestID: requestID)
        older = try #require(JSONSerialization.jsonObject(with: JSONEncoder.scEncoder.encode(response)) as? [String: Any])
        older.removeValue(forKey: "requestID")
        #expect(try decoder.decode(ServiceDTO.self, from: JSONSerialization.data(withJSONObject: older)).requestID == nil)
    }
}
