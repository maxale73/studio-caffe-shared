import Foundation
import Testing
import studio_caffe_shared

struct ServiceRequestTests {
    @Test(arguments: ServiceRequestStatus.allCases, ServiceRequestSource.allCases)
    func requestRoundTripsWithEverySourceAndStatus(_ status: ServiceRequestStatus, _ source: ServiceRequestSource) throws {
        let catalogID = UUID()
        let request = ServiceRequestToSave(id: UUID(), machineID: UUID(), requestDate: Date(timeIntervalSince1970: 1000),
                                           source: source, status: status, catalogID: catalogID, operationType: .riparazione,
                                           note: "Non eroga", counter: 5_000_000_000)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        #expect(try decoder.decode(ServiceRequestToSave.self, from: #require(request.toJSONData())) == request)
        let response = ServiceRequestDTO(id: request.id, machineID: request.machineID, requestDate: request.requestDate,
                                         source: source, status: status,
                                         catalog: ServiceCatalogDTO(id: catalogID, serviceDescription: "Gruppo espresso"),
                                         operationType: request.operationType, note: request.note, userID: UUID(),
                                         recordedAt: Date(timeIntervalSince1970: 2000), serviceIDs: [UUID(), UUID()], counter: request.counter)
        #expect(try decoder.decode(ServiceRequestDTO.self, from: JSONEncoder.scEncoder.encode(response)) == response)
    }

    @Test func aRequestWithoutAStatusOrDiagnosisDefaultsToOpen() throws {
        let request = ServiceRequestToSave(id: UUID(), machineID: UUID(), requestDate: Date(timeIntervalSince1970: 1000), source: .cliente)
        #expect(request.status == .aperta)
        var json = try #require(JSONSerialization.jsonObject(with: JSONEncoder.scEncoder.encode(request)) as? [String: Any])
        json.removeValue(forKey: "status")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(ServiceRequestToSave.self, from: JSONSerialization.data(withJSONObject: json))
        #expect(decoded.status == .aperta)
        #expect(decoded.catalogID == nil && decoded.operationType == nil && decoded.counter == nil)
        json["status"] = "inesistente"
        #expect(throws: DecodingError.self) { try decoder.decode(ServiceRequestToSave.self, from: JSONSerialization.data(withJSONObject: json)) }
        json["status"] = "pendente"
        #expect(throws: DecodingError.self) { try decoder.decode(ServiceRequestToSave.self, from: JSONSerialization.data(withJSONObject: json)) }
        json["status"] = "aperta"
        json["source"] = "inesistente"
        #expect(throws: DecodingError.self) { try decoder.decode(ServiceRequestToSave.self, from: JSONSerialization.data(withJSONObject: json)) }
    }

    @Test func filtersAndRoutesUseSharedRequestContracts() throws {
        #expect(try JSONDecoder().decode(ServiceRequestFilter.self, from: Data("{}".utf8)) == ServiceRequestFilter())
        let filter = ServiceRequestFilter(statuses: [.aperta], source: .operatore, catalogID: UUID(), page: 2, per: 10)
        #expect(try JSONDecoder().decode(ServiceRequestFilter.self, from: JSONEncoder.scEncoder.encode(filter)) == filter)
        let id = UUID()
        #expect(ServiceRequestEndpointsGroup.find(id: id).clientRoute.contains(id.uuidString))
        #expect(ServiceRequestEndpointsGroup.fetchByMachine(machineID: id, filter: filter).clientRoute.contains(id.uuidString))
        #expect(ServiceRequestEndpointsGroup.fetchByMachine(machineID: id).httpMethod == .post)
        #expect(ServiceRequestEndpointsGroup.index(filter: filter).clientRoute == "service_request/index/")
        #expect(ServiceRequestEndpointsGroup.index().httpMethod == .post)
        #expect(ServiceRequestStatus.nonRisolta.description == "non risolta")
    }

    @Test func globalPagesCarryMachineIdentityAndInsertionDate() throws {
        let machine = FilteredMachineDTO(id: UUID(), internalID: 100001, factoryID: "CALL123", model: .emptyModel)
        let request = ServiceRequestDTO(id: UUID(), machineID: machine.id, requestDate: Date(timeIntervalSince1970: 1000),
                                         source: .cliente, userID: UUID(), recordedAt: Date(timeIntervalSince1970: 2000))
        let item = ServiceRequestListItemDTO(request: request, machine: machine)
        let page = ServiceRequestListPageDTO(items: [item], page: 2, per: 10, total: 11)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(ServiceRequestListPageDTO.self, from: JSONEncoder.scEncoder.encode(page))
        #expect(decoded == page)
        #expect(decoded.items.first?.id == request.id)
        #expect(decoded.items.first?.machine.id == decoded.items.first?.request.machineID)
        #expect(decoded.items.first?.request.recordedAt != decoded.items.first?.request.requestDate)
    }

    @Test func olderRequestResponsesDefaultToOpenAndAnEmptyServiceList() throws {
        let response = ServiceRequestDTO(id: UUID(), machineID: UUID(), requestDate: Date(timeIntervalSince1970: 1000),
                                         source: .cliente, userID: UUID())
        var json = try #require(JSONSerialization.jsonObject(with: JSONEncoder.scEncoder.encode(response)) as? [String: Any])
        json.removeValue(forKey: "serviceIDs")
        json.removeValue(forKey: "status")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(ServiceRequestDTO.self, from: JSONSerialization.data(withJSONObject: json))
        #expect(decoded.status == .aperta && decoded.serviceIDs.isEmpty && decoded.counter == nil)
        #expect(ServiceRequestStatus.allCases.count == 3)
    }

    @Test func counterCanBeExplicitlyClearedAndIsOptionalForOlderPayloads() throws {
        let request = ServiceRequestToSave(id: UUID(), machineID: UUID(), requestDate: .now, source: .cliente)
        var json = try #require(JSONSerialization.jsonObject(with: JSONEncoder.scEncoder.encode(request)) as? [String: Any])
        #expect(json["counter"] is NSNull)
        json.removeValue(forKey: "counter")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let old = try decoder.decode(ServiceRequestToSave.self, from: JSONSerialization.data(withJSONObject: json))
        #expect(old.counter == nil)
        json["counter"] = "123"
        #expect(throws: DecodingError.self) {
            try decoder.decode(ServiceRequestToSave.self, from: JSONSerialization.data(withJSONObject: json))
        }
    }
}
