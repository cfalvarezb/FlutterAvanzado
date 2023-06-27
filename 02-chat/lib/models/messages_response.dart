// To parse this JSON data, do
//
//     final messagesReponse = messagesReponseFromJson(jsonString);

import 'dart:convert';

MessagesReponse messagesReponseFromJson(String str) => MessagesReponse.fromJson(json.decode(str));

String messagesReponseToJson(MessagesReponse data) => json.encode(data.toJson());

class MessagesReponse {
    bool ok;
    List<Message> messages;

    MessagesReponse({
        required this.ok,
        required this.messages,
    });

    factory MessagesReponse.fromJson(Map<String, dynamic> json) => MessagesReponse(
        ok: json["ok"],
        messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
    };
}

class Message {
    String from;
    String to;
    String message;
    DateTime createdAt;
    DateTime updatedAt;

    Message({
        required this.from,
        required this.to,
        required this.message,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        from: json["from"],
        to: json["to"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
