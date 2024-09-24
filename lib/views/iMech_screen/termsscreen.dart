import 'package:flutter/material.dart';

import '../../helpers/ProjectResource.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProjectResource.setScreenSize(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Use',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: themeColor,
        leading:IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Image.asset(Images.backIcon,color: Colors.white,),
        ),
      ),
      body:
      const SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("SUBSCRIPTIONS",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),
            const SizedBox(height: 10,),
            const Text('Surefix membership subscriptions are payable by credit or debit card using our secure online payment service. Please allow up to 3 working days for transactions to be processed. At the end of each period we will automatically renew your membership from the card details you have supplied, however you can cancel at any time. If your card details expire before your renewal is due, we will send you an e-mail to update your card details.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),),
            const SizedBox(height: 8,),
            const Text('To unsubscribe at any time, just e-mail us your username and we will remove your details from our database, your card will not be debited and you will not be sent a reminder to renew your membership.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),),
            const SizedBox(height: 8,),
            const Text('MEMBERSHIP POLICY & USER GUIDE LINES',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
            const Text('By using Surefix you are agreeing to our terms & conditions and to abide by our user rules & policy. We only grant Pro mechanic access to experienced & qualified mechanics to ensure that the faults & fixes posted are genuine and correct. To enable all users to benefit from our data, we expect everyone to follow our guidelines when posting any queries or fixes, so that the integrity of the information is maintained at all times.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('When posting faults or fixes, please enter details in all applicable fields such as make, model, engine and fault codes. Also add photos and videos so as to help users save time in identifying where the fault lies and the proposed fix. For the benefit of all follow the principle of identifying cause & effect.ONLY POST A FIX IF IT DEFINATELY CURED THE FAULT on the vehicle you worked on and has not re-occurred. The ethos of this site is not to post maybe and possible fixes, as all users are experienced mechanics and will be able to fault find themselves. Please bear in mind before posting that Surefix is here to SAVE all users time and effort, so if your post is not a definite fix don\'t post it until it is.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text(' In order to maintain high standards, we would ask members to follow a few basic rules when posting faults on this site.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('As a technician you MUST NOT promote your equipment, products or services on any part of this site.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('1) Please keep your technical posting relevant to the UK automotive industry & specific to fault finding.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('2) Please do not post messages that may be interpreted as OFFENSIVE or LIABLE towards any automotive company/manufacturer/individual or motor trade organization, national or global.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('3) Please remember that your professional image and source of income relies on CUSTOMERS so please treat them with respect',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('4) Please make sure the vehicle is or has recently been in your workshop. Then ONLY post once you have carried out all the relevant test and checks with the equipment and technical information at your disposal. Please do not pre-post about problems (i.e. The vehicle is booked in next week, have you had this problem before etc.). Once you have repaired the vehicle, then please POST the FIX at the bottom of your original message. Please do not start a fresh post about a FIX',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('5) For your security, please do not share your personal contact details or information anywhere on this site.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('6) If you feel that some of the content is OFFENSIVE then please contact Surefix and we will review the content and if required we will DELETE when possible. Surefix reserve the right to remove any posts that we feel are not relevant to this site, or are of a poor technical quality and lack relevant information about the tests you have carried out prior to posting.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('7) Copyright of all messages posted belongs to Surefix, please do not copy, or reproduce any of the technical information without prior consent from us.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('8) Surefix cannot be held responsible for the accuracy of the information posted, the posting member is solely responsible for the content of that post and must be treated as for information purposes only. ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('TERMS & CONDITIONS.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
            const Text('By visiting our website or mobile app (referred to as site), you are confirming that you have read and accepted all of the following terms and conditions:',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('Definitions',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('1.1 In these terms and conditions the following words have the following meanings: ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('1.2 Feedback & ratings means users comments regarding other users of Surefix;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('1.3 Subscription fee means the sum payable every month or annually by you to us;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('1.4 User means a person, firm or company (collectively and/or individually as the context admits) that has been issued with a username and password for accessing www.surefixai.co.uk or mobile app;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('1.5 Username and password means the username and password issued to you to allow you or your business to access the site;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('1.6 Website means the website located at www.surefixai.co.uk;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('1.7 We/Us/Our means  Surefix Ltd a company registered in England and Wales under company number 15754497 , whose registered office is, 74 Dukes Brow Blackburn BB2 6DH;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('1.8 You/Your/Yourself means a person using the site or receiving our emails.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('Username and password',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('2.1 If you believe there has been any breach of security including (but not limited to) the disclosure, theft or unauthorised use of your username or password, you agree to notify us immediately in writing by email to support@surefixai.co.uk or by first class post to our place of business (as set out in clause 1 above).',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('2.2 Your username and password are unique to you and are issued on the express understanding that they are for the intended user only. The sharing of user names and passwords and accounts is expressly prohibited.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('2.3 You will be liable for all use of the site made by you or anyone else using your username and password and you are solely responsible for preventing unauthorised use of your username and password.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('2.4 We may include your username and password in email that we send to you, it is therefore important that you are careful not to forward those emails onto others as this would result in that person having access to your username and password. If you believe this may have happened you agree to notify us immediately in accordance with 2.1.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('Feedback',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('3.1 We provide a feedback & rating facility so that users may inform others about the experiences they have had whilst communicating with other Surefix users.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('3.2 You must not take any actions that may undermine the integrity of the feedback & rating system. Feedback & ratings posted on the site by users is solely the opinion and responsibility of the person posting that message. We are not responsible for feedback & rating left by users.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('3.3 You are responsible for any feedback & ratings that you leave about others. You must not post any feedback or ratings that is unlawful, threatening, abusive, libellous, indecent, infringes the rights of third parties or which includes any other form of illegal content.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('Subscription Fees',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('4.1 Subscription fees are normally collected on a monthly basis by direct debit.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('4.2 We reserve the right to suspend or terminate your right to access and to use the site at any time if we are unable to collect a payment.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('4.3 If you wish to cancel your subscription to Surefix you must give notice in writing to us at our place of business or by email to admin@surefixai.co.uk.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('Use of information relating to other users',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('5.1 You hereby agree only to contact other users regarding the posting of queries and fixes on the site and not to use contact details of other users for any other purpose. Misuse of the site will result in a breach of these terms and conditions and may result in termination of membership.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('5.2 You hereby agree not to disclose any contact details of any user to any third party who is not a user.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('5.3 You hereby agree to indemnify us and hold us harmless from and against all losses, costs (including reasonable costs on a full indemnity basis), claims, demands, actions, liabilities and expenses in connection with any breach of paragraph 5.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('Termination',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('6.1 We reserve the right to suspend or terminate your right to access and use of the site at any time. We also reserve the right to cease your posts at any time. Such rights may be exercised without notice.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('6.2 If you wish to cancel your subscription to Surefix you must give notice in writing to us at our place of business or by email to admin@surefixai.co.uk.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('Limitation of liability and disclaimer',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('7.1 We give no warranties in respect of the site or any posts thereon, or any e-mails . The site is provided on an "as is", "as available" basis and although we make every effort we do not guarantee the accuracy, timeliness, completeness, performance or fitness for a particular purpose of the posts or the answers provided thereon. All implied warranties are excluded by these terms and conditions to the fullest extent that they may be excluded by law.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('7.2 We make no warranty that the website is free from infection by viruses or anything else that has contaminating or destructive properties.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('7.3 We will not be liable for any damages (including without limitation, damages for loss of profits) arising in contract, tort or otherwise from your use or inability to use the site or any content or from any action taken (or refrained from being taken) as a result of using the site.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('7.4 Although every effort has been made to ensure the accuracy of information on this site, neither we, nor any of our employees, suppliers or users make any warranty, expressed or implied, or assume any legal liability (to the fullest extent permitted by law) or responsibility for the accuracy or completeness of any information contained on the site.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('7.5 The site contains material and posts submitted by third parties to us. Such third parties are responsible for ensuring that material submitted for inclusion on the site is subject to these terms and conditions. We do not accept liability in respect of any posts or material submitted by third parties.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('7.6 Every effort is made to ensure that this site is accessed and used only by professional mechanics of the motor trade. However we strongly advise that you check and test any recommendations made as to their suitability for your vehicle & purpose before final implementation.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('7.7 We reserve the right to revise the site or withdraw access to part or all of it at any time.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('Privacy Policy',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('8.1 You acknowledge and agree to be bound by the terms of our privacy policy. A copy of which can be found below.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('Changes to these Terms and Conditions',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('9.1 From time to time we may change these terms and conditions. It is your responsibility to refer to our terms and conditions on a regular basis. By accessing the site you are agreeing to be bound by the terms and conditions as varied or amended from time to time.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('Database theft',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('10.1 Our database is protected by law. The establishment of our database has involved, and its maintenance and development continues to involve, extensive work, including the collection of raw data, the design of the database, the selection and verification of data for inclusion in the database and the insertion and arrangement of selected data in the database. The cost of establishing the database and of continuing to obtain, verify and present its contents is considerable.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('10.2 No permission to copy, reproduce, modify or download the site (or any part of it) is given.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('10.3 We put you on notice that we will instruct our Solicitors to bring an action against you for any unauthorised use of the data on the site. Such unauthorised use includes, but is not limited to, the copying of the content, the extraction and/or re-utilisation of the whole or of a part, of the contents of the database and utilising the same whether acting by yourself, your servants, agents, associated companies, or otherwise howsoever and (to the extent permitted by law) in another site or similar portal that serves the motor trade or sites of similar functionality.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('External links and banner Advertisements',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('11.1 Where this site is hypertext linked to any site operated by any third party, we accept no responsibility or liability arising in respect of any content on such a site. When You access any other site from the site you understand that it is independent from the site and that we have no control over the content or availability of that site. The inclusion of a hypertext link on the site to any other site does not mean that we endorse or accept any responsibility for the content, or the use of, such a site and we shall not be liable for any loss or damage caused or alleged to be caused by or in connection with use of or reliance on any content, goods, services available on or through any other site or resource.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('11.2 Third party banner advertisements, pop-up advertisements and other virtual advertising may be experienced whilst browsing the site. Such third party advertisements may not have been approved by us and may appear on the site without our knowledge or consent, and we accept no responsibility or liability in respect of the content or display of any such third party advertisements.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('11.3 We do not permit any links to be made to the website without our written permission.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('Trademarks and Copyright',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('12.1 The word or mark "Surefix" however represented, including stylised representations, all associated logos and symbols, and combinations of any of the foregoing with another word or mark, used on the site, are the trade marks of Surefix AI Limited or one of its associated companies.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('12.2 The trade marks, domain name www.surefixai.co.uk  and copyright in the site and its materials, including the database are the property of Surefix AI Limited unless otherwise stated.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('General',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('13.1 If any part of these terms and conditions is unenforceable (including any provision in which we exclude or limit our liability) the enforceability of any other part of these conditions will not be affected.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('13.2 Except for our directors, employees or representatives, a person who is not a party to this agreement has no right under the Contracts (Rights of Third Parties) Act 1999 to enforce these terms and conditions but this does not affect any right or remedy of a third party that exists or is available apart from that Act.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('13.3 These terms and conditions shall be governed by and construed in accordance with English law and the English courts shall have jurisdiction to resolve any disputes between us.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('13.4 These terms and conditions, together with our privacy policy, set out the whole of our agreement relating to your use of the site.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('13.5 Failure by either party to exercise any right or remedy under these terms and conditions does not constitute a waiver of that right or remedy.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('13.6 You may contact us in the case of queries by email to admin@surefixai.co.uk or by post to Our place of business at Surefix AI Ltd , 74 Dukes Brow, Blackburn BB2 6DH',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('Privacy Policy ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('This Privacy Policy sets out the data processing practices carried out through the use of the Internet and any other electronic communications networks by Surefix. If you have any requests concerning your personal information or any queries with regard to these practices please contact us at admin@surefixai.co.uk ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('Information Collected',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('1.1 We collect personal information from users of the site through the use of our online information request and every time you email us your details. We also collect information about the pages of the site you visit.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('1.2 Our Websites registration form requires users to give us contact and personal information (like their name and email address). We use customer contact information from the registration form to send the user information about our company, to contact the user when necessary and is also used to send you advertisements compiled by other users registered with us.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('Information Collected',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('1.3 We collect information automatically about your visit to the site.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('2. Use of Personal Information',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const SizedBox(height: 8,),
            const Text('2.1 We process personal information collected via the site for the purposes of: ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('2.1.1 providing and personalising our services;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('2.1.2 dealing with your inquiries and requests;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('2.1.3 administering orders and accounts relating to our suppliers or customers;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('2.1.4 maintaining information as a reference tool or general resource;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('2.1.5 carrying out market research campaigns;',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('2.1.6 providing you with information about our services.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('2.2 Please send us an email to admin@Surefixai.co.uk clearly marked "Unsubscribe" if you do not wish to receive information about our services. ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('2.3 Your details are not displayed or released to other users of our system, neither do we release them to external third parties (non Surefix Subscribers) (except where legally obliged to do so). ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('2.4 The site gives users the option to remove their information from our database and prevent future communications or to no longer receive our services. You can send email to admin@Surefixai.co.uk clearly marked "Unsubscribe" or you can send mail to the following postal address: Surefix AI Ltd 74 Dukes Brow, Blackburn, BB2 6DH and supply sufficient details for us to positively identify your account.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('3. Use of Cookies',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('3.1 We use cookies to keep track of your progress and information entered by you, as you navigate through the site. We use cookies to deliver content specific to your interests based on information which you have entered and to save your password so you do not have to re-enter it for each page you visit. Because our security relies on cookies, the site will not allow you to log in with this facility disabled. We use "per-session" cookies which means that we do not continue to monitor them after you have left our site and you are not obliged to retain them on your computer once you have left our site.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('4. Other websites and mobile Apps (referred to as site/s)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text(' 4.1 Any sites which are linked from the site are outside our control and are not covered by this Privacy Policy. If you access other sites using the links provided, the operators of these sites may collect information from you which will be used by them in accordance with their privacy policy, which may differ from ours.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('5. Access right',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('5.1 You have a right to access the personal data held about you. To obtain a copy of the information we hold about you, please write to us at: Surefix AI Ltd, 74 Dukes Brow BB2 6DH with  a cheque in the sum of £10.00 payable to Surefix AI Limited',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const Text('5.2 The site gives users the following options for changing and modifying information previously provided. You can either logon to our  site using your username and password or send an email to support@surefixai.co.uk  or you can send mail to the postal address above. ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('6. Internet-based transfers',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('6.1 Given that the Internet is a global environment, using the Internet to collect and process personal data necessarily involves the transmission of data on an international basis. Therefore, by using the site and communicating electronically with us, you acknowledge and agree to our processing of personal data in this way. ',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
            const SizedBox(height: 8,),
            const Text('7. Queries',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            const Text('7.1 If you have any questions about this privacy statement, the practices of the site, or your dealings with this site, you can send email to admin@surefixai.co.uk  or you can send mail to the following postal address: Surefix AI Ltd 74 Dukes Brow, Blackburn, BB2 6DH and supply sufficient details for us to positively identify your account.',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),

          ],
        ),
        )
      ),
    );
  }
}


/*
  Text('ACCEPTANCE OF TERMS OF USE.',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
 SizedBox(height: 8,),
 Text('',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),),
  SizedBox(height: 8,),
  Text('ACCEPTANCE OF TERMS OF USE.',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
  SizedBox(height: 8,),
*
* */