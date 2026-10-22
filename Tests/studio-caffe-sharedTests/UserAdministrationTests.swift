import Foundation
import Testing
import studio_caffe_shared

struct UserAdministrationTests {
    @Test func credentialsUseRequestBodiesAndRequireAuthentication() throws {
        let create = UserCreateDTO(name: "Utente", email: "test@example.invalid", password: "Password42", role: .gestore)
        let createData = try #require(create.toJSONData())
        #expect(try JSONDecoder().decode(UserCreateDTO.self, from: createData) == create)
        let update = UserPasswordUpdateDTO(password: "NewPassword42")
        let updateData = try #require(update.toJSONData())
        #expect(try JSONDecoder().decode(UserPasswordUpdateDTO.self, from: updateData) == update)
        let id = UUID()
        let routes = [UserEndpointsGroup.administration(), UserEndpointsGroup.create(user: create),
                      UserEndpointsGroup.changePassword(userID: id, password: update), UserEndpointsGroup.delete(userID: id)]
        #expect(routes.allSatisfy { $0.requiresToken })
        #expect(routes.allSatisfy { !$0.clientRoute.contains("Password") })
        #expect(routes[2].clientRoute == "user/change_password/\(id.uuidString)/")
        #expect(routes[3].clientRoute == "user/delete/\(id.uuidString)/")
    }

    @Test func userResponsesDiscardLegacyHashesAndKeepTheLegacyKeyEmpty() throws {
        let id = UUID()
        let json: [String: String] = ["id": id.uuidString, "name": "Utente", "email": "test@example.invalid", "role": "gestore", "passwordHash": "SECRET_HASH"]
        let user = try JSONDecoder().decode(UserDTO.self, from: JSONSerialization.data(withJSONObject: json))
        let data = try JSONEncoder().encode(user)
        let encoded = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])
        #expect(encoded["passwordHash"] == "" && !String(decoding: data, as: UTF8.self).contains("SECRET_HASH"))
        var withoutHash = json
        withoutHash.removeValue(forKey: "passwordHash")
        #expect(try JSONDecoder().decode(UserDTO.self, from: JSONSerialization.data(withJSONObject: withoutHash)) == user)
        #expect(UserDTO.emptyUser() == UserDTO.emptyUser())
        #expect(Set([UserDTO.emptyUser(), UserDTO.emptyUser()]).count == 1)
    }

    @Test(arguments: ["short", String(repeating: "a", count: 73), String(repeating: "è", count: 37), "abcdefgh\0"])
    func rejectsPasswordsBcryptCannotRepresentSafely(_ password: String) {
        #expect(!UserPasswordPolicy.isValid(password))
    }

    @Test(arguments: ["password", String(repeating: "a", count: 72), String(repeating: "è", count: 36)])
    func acceptsPasswordsWithinTheSharedPolicy(_ password: String) {
        #expect(UserPasswordPolicy.isValid(password))
    }
}
