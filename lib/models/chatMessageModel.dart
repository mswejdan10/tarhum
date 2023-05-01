class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

List<ChatMessage> messages = [
  ChatMessage(messageContent: "مرحاً بك يا دكتور", messageType: "receiver"),
  ChatMessage(
      messageContent: "إريد إستشارة من فضلك ؟", messageType: "receiver"),
  ChatMessage(messageContent: "حياك اللة تفضل", messageType: "sender"),
  ChatMessage(
      messageContent: "أريد نوع فيتامين لقطتى.", messageType: "receiver"),
  ChatMessage(
      messageContent: "قم بزيارتى فى العيادة أطلع عليها ؟",
      messageType: "sender"),
];
