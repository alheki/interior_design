import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:home_services_app/utils/extensions/string_extension.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {

    // This would normally be fetched from API
    const termsHtml = '''
    <h2>Terms of Use</h2>
    <p><em>Last updated: January 2024</em></p>
    
    <h3>1. Acceptance of Terms</h3>
    <p>By accessing and using the Home Services mobile application, you accept and agree to be bound by the terms and provision of this agreement.</p>
    
    <h3>2. Use License</h3>
    <p>Permission is granted to temporarily use this application for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title, and under this license you may not:</p>
    <ul>
      <li>modify or copy the materials;</li>
      <li>use the materials for any commercial purpose or for any public display;</li>
      <li>attempt to reverse engineer any software contained in the application;</li>
      <li>remove any copyright or other proprietary notations from the materials.</li>
    </ul>
    
    <h3>3. Service Terms</h3>
    <p>All service requests made through this application are subject to availability and confirmation. Pricing and terms may vary based on project scope and requirements.</p>
    
    <h3>4. Privacy</h3>
    <p>Your privacy is important to us. Please review our Privacy Policy, which also governs your use of the Service.</p>
    
    <h3>5. Contact Information</h3>
    <p>If you have any questions about these Terms of Use, please contact us through the contact information provided in the application.</p>
    ''';

    return Scaffold(
      appBar: AppBar(
        title: Text("terms_of_use".tr),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Html(
          data: termsHtml,
          style: {
            "body": Style(
              margin: Margins.zero,
              padding: HtmlPaddings.zero,
            ),
            "h2": Style(
              color: Theme.of(context).primaryColor,
              fontSize: FontSize(24),
              fontWeight: FontWeight.bold,
            ),
            "h3": Style(
              color: Theme.of(context).primaryColor,
              fontSize: FontSize(20),
              fontWeight: FontWeight.bold,
            ),
          },
        ),
      ),
    );
  }
}