class DeletePostRequest {
  String mRecordId;

  DeletePostRequest(this.mRecordId);

  Map<String, dynamic> toBodyRequest() => {
        'recordId': mRecordId,
      };
}
