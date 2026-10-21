import Foundation
import Testing
import studio_caffe_shared

struct ServiceRequestTests {
    @Test(arguments: ServiceRequestStatus.allCases, ServiceRequestSource.allCases)
    func requestRoundTripsWithEverySourceAndStatus(_ status: ServiceRequestStatus, _ source: ServiceRequestSource) throws {
        let catalogID = UUID()
        let request = ServiceRequestToSave(id: UUID(), machineID: UUID(), requestDate: Date(timeIntervalSince1970: 1000),
                                           source: source, status: status, catalogID: catalogID, operationType: .riparazione,
                                           note: "Non eroga")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        #expect(try decoder.decode(ServiceRequestToSave.self, from: #require(request.toJSONData())) == request)
        let response = ServiceRequestDTO(id: request.id, machineID: request.machineID, requestDate: request.requestDate,
                                         source: source, status: status,
                                         catalog: ServiceCatalogDTO(id: catalogID, serviceDescription: "Gruppo espresso"),
                                         operationType: request.operationType, note: request.note, userID: UUID(),
                                         recordedAt: Date(timeIntervalSince1970: 2000))
        #expect(try decoder.decode(ServiceRequestDTO.self, from: JSONEncoder.scEncoder.encode(response)) == response)
    }

    @Test func aRequestWithoutAStatusOrDiagnosisDefaultsToPending() throws {
        let request = ServiceRequestToSave(id: UUID(), machineID: UUID(), requestDate: Date(timeIntervalSince1970: 1000), source: .cliente)
        #expect(request.status == .pendente)
        var json = try #require(JSONSerialization.jsonObject(with: JSONEncoder.scEncoder.encode(request)) as? [String: Any])
        json.removeValue(forKey: "status")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(ServiceRequestToSave.self, from: JSONSerialization.data(withJSONObject: json))
        #expect(decoded.status == .pendente)
        #expect(decoded.catalogID == nil && decoded.operationType == nil)
        json["status"] = "inesistente"
        #expect(throws: DecodingError.self) { try decoder.decode(ServiceRequestToSave.self, from: JSONSerialization.data(withJSONObject: json)) }
        json["status"] = "pendente"
        json["source"] = "inesistente"
        #expect(throws: DecodingError.self) { try decoder.decode(ServiceRequestToSave.self, from: JSONSerialization.data(withJSONObject: json)) }
    }

    @Test func filtersAndRoutesUseSharedRequestContracts() throws {
        #expect(try JSONDecoder().decode(ServiceRequestFilter.self, from: Data("{}".utf8)) == ServiceRequestFilter())
        let filter = ServiceRequestFilter(statuses: [.pendente, .aperta], source: .operatore, catalogID: UUID(), page: 2, per: 10)
        #expect(try JSONDecoder().decode(ServiceRequestFilter.self, from: JSONEncoder.scEncoder.encode(filter)) == filter)
        let id = UUID()
        #expect(ServiceRequestEndpointsGroup.find(id: id).clientRoute.contains(id.uuidString))
        #expect(ServiceRequestEndpointsGroup.fetchByMachine(machineID: id, filter: filter).clientRoute.contains(id.uuidString))
        #expect(ServiceRequestEndpointsGroup.fetchByMachine(machineID: id).httpMethod == .post)
        #expect(ServiceRequestStatus.nonRisolta.description == "non risolta")
    }
}
