import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:home_services_app/utils/extensions/string_extension.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {

    // This would normally be fetched from API
    const aboutUsHtml = '''
    <h2>About Home Services</h2>
    <p>We are a leading provider of comprehensive home services, dedicated to transforming your living spaces into beautiful, functional environments.</p>
    
    <h3>Our Story</h3>
    <p>Founded in 2009, Home Services has grown from a small local business to a trusted name in home improvement and design. We specialize in landscape design, swimming pool installation, artificial grass, interior design, and complete finishing solutions.</p>
    
    <h3>What We Do</h3>
    <ul>
      <li><strong>Landscape Design:</strong> Creating beautiful outdoor spaces</li>
      <li><strong>Swimming Pools:</strong> Professional installation and maintenance</li>
      <li><strong>Artificial Grass:</strong> High-quality synthetic lawn solutions</li>
      <li><strong>Interior Design:</strong> Complete home makeover packages</li>
      <li><strong>Finishes:</strong> Complete property finishing solutions</li>
    </ul>
    
    <h3>Why Choose Us</h3>
    <p>With over 15 years of experience, we have successfully completed more than 850 projects and served over 1,250 satisfied customers. Our team of skilled professionals is committed to delivering excellence in every project.</p>
    ''';

    return Scaffold(
      appBar: AppBar(
        title: Text("about_us".tr),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Html(
          data: aboutUsHtml,
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