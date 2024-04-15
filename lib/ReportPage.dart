import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  final String forumId;  // Pass the forum ID to know which forum is being reported
  final String? commentId;  // Optional: Pass the comment ID if a comment is being reported

  ReportPage({required this.forumId, this.commentId});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final List<String> reportReasons = [
    "Offensive Content",
    "Spam",
    "Misinformation",
    "Harassment",
    "Other"
  ];  // Example report reasons

  String? selectedReason;

  @override
  Widget build(BuildContext context) {
    bool isCommentReport = widget.commentId != null;
    String titleText = isCommentReport ? "Report Comment" : "Report Forum";
    String promptText = isCommentReport ? "Select a reason for reporting this comment:" : "Select a reason for reporting this forum:";

    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        backgroundColor: Color(0xffad32fe),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(promptText),
            DropdownButton<String>(
              value: selectedReason,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  selectedReason = value;
                });
              },
              items: reportReasons.map<DropdownMenuItem<String>>((String reason) {
                return DropdownMenuItem<String>(
                  value: reason,
                  child: Text(reason),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Functionality to handle submit, currently does nothing
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Report Submitted"),
                        content: Text("Your report has been submitted for review."),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text("OK")
                          ),
                        ],
                      );
                    }
                );
              },
              child: Text("Submit Report"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffae32ff),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
