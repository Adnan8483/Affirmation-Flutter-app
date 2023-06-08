import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:my_learn_app/Controllers/premium_controller.dart';
import 'package:my_learn_app/Constants/string_constant.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpFAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("FAQ's", style: TextStyle(color: Colors.blue))
                          .paddingOnly(top: 10, left: 10),
                      SizedBox(height: 20),
                      ExpansionTile(
                        collapsedBackgroundColor: Colors.black,
                        collapsedIconColor: Colors.white,
                        backgroundColor: Colors.black,
                        iconColor: Colors.white,
                        title: Text(
                          "What will I get even without PRO Upgrade?",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        children: [
                          RichText(
                            text: TextSpan(
                              text:
                                  "a. Even without upgrading to the PRO version, you'll still have access to our standard messaging capabilities, although there will be some limits on the number of messages you can send.",
                              style: GoogleFonts.lobster(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              children: [
                                const TextSpan(text: "\n\n\n"),
                                TextSpan(
                                  text:
                                      "b. Additionally, you may see advertisements while "
                                      "using the app. However, rest assured that we'll still provide "
                                      "you with regular updates to our language model, which will improve "
                                      "the app's responses over time. Please note that new features and "
                                      "updates may not be available immediately, but we'll strive to make them "
                                      "available as demand increases. Lastly, response times may be slower than in "
                                      "the PRO version due to the increased user traffic.",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ).paddingAll(10)
                        ],
                      ),
                      SizedBox(height: 20),
                      ExpansionTile(
                        collapsedBackgroundColor: Colors.black,
                        collapsedIconColor: Colors.white,
                        backgroundColor: Colors.black,
                        iconColor: Colors.white,
                        title: Text(
                          "Why are you charging for the PRO Upgrade?",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        children: [
                          Text(
                            "We offer a PRO Upgrade for our AI-powered Q&A application, which includes several "
                            "additional features and benefits that are not available in the free version. "
                            "We charge for the PRO Upgrade to cover the costs of developing and maintaining our "
                            "advanced AI-powered Q&A technology, which includes ongoing research and development, "
                            "as well as maintenance and support for our user community. In addition to providing a "
                            "more comprehensive and personalized Q&A experience, we believe that charging for "
                            "the PRO Upgrade is necessary to sustain our operations and continue to improve our "
                            "technology over time. As a business, we are committed to providing the best possible "
                            "service to our users, and we believe that the PRO Upgrade is an important part of "
                            "that commitment.",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ).paddingAll(10),
                        ],
                      ),
                      ExpansionTile(
                        collapsedBackgroundColor: Colors.black,
                        collapsedIconColor: Colors.white,
                        backgroundColor: Colors.black,
                        iconColor: Colors.white,
                        title: Text(
                          "What is the policy for cancelling a subscription to this service, and can it be done at any time?",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        children: [
                          RichText(
                            text: TextSpan(
                              text:
                                  "Our subscription policy allows users to cancel their subscription at any "
                                  "time, without any commitments or penalties. If you decide to cancel your subscription, "
                                  "simply log into your account and follow the cancellation instructions provided. "
                                  "Once you cancel your subscription, you will continue to have access to the service "
                                  "until the end of your current billing cycle. After that, your account will be downgraded "
                                  "to the free version of the service, which may have limited features and functionality "
                                  "compared to the paid version. If you decide to resubscribe at a later date, you can do "
                                  "so by selecting the appropriate subscription plan and providing your payment information. "
                                  "We believe in providing our users with maximum flexibility and control over their subscription "
                                  "experience, and we are committed to making it easy for users to cancel or modify their "
                                  "subscription at any time. Kindly contact us at the email id: ",
                              style: GoogleFonts.lobster(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              children: [
                                TextSpan(
                                  text: StaticLinks.supportEmail,
                                  style: TextStyle(
                                    color: Colors.blue.shade200,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => PremiumController.launchUrl(
                                          "mailto:${StaticLinks.supportEmail}",
                                        ),
                                ),
                                TextSpan(
                                  text: " with your purchase receipt.",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ).paddingAll(10),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ).paddingSymmetric(horizontal: 10, vertical: 10),
                ),
              ],
            )),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        'Help & FAQ',
        style: TextStyle(color: Colors.black),
      ),
      elevation: 0,
    );
  }
}
