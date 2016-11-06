//
//  EULAView.m
//  sunflower
//
//  Created by Connor Wood on 10/1/16.
//  Copyright © 2016 Connor Wood. All rights reserved.
//

#import "EULAView.h"
#import "UIView+Autolayout.h"
#import "SunflowerCommon.h"

@interface EULAView() {
    UITextView *_textView;
}
@end

@interface EULAView(Private)
- (void)setupCreditsView;
@end

@implementation EULAView

@synthesize dismissButton = _dismissButton;
@synthesize acceptButton = _acceptButton;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCreditsView];
    }
    return self;
}


@end

@implementation EULAView(Private)
- (void) setupCreditsView{
    [self setupTextView];
    [self setupDismissButton];
    [self setupAcceptButton];
    [self setBackgroundColor: [UIColor blackColor]];
    [self createWebViewWithHTML];
}

- (void) setupTextView{
    _textView = [[UITextView alloc]initWithFrame:CGRectZero];
    [_textView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_textView];
    
    [_textView addBottomConstraint:15];
    [_textView addTrailingConstraint:15];
    [_textView addLeadingConstraint:15];
    [_textView addTopConstraint:15];
    
    [_textView setText:@"EULA: \n Please accept"];
    [_textView setBackgroundColor:[UIColor blackColor]];
    [_textView setTextColor:[UIColor whiteColor]];
    [_textView setFont:[UIFont systemFontOfSize:30]];
    [_textView setEditable:NO];
    [_textView setScrollEnabled:YES];
    [_textView setTextAlignment:NSTextAlignmentCenter];
    
}
- (void) createWebViewWithHTML{
    //create the string
    NSMutableString *html = [NSMutableString stringWithString: @"<html><head><title></title></head><body style=\"background:transparent;\">"];
                             
     //continue building the string
     [html appendString:@"<h2>Crazy Coop - Terms and conditions</h2><ol><li><p><strong>Preamble:</strong> This Agreement, signed on Nov 6, 2016 (hereinafter: Effective Date) governs the relationship between End User, a Business Entity, (hereinafter: Licensee) and The Bird Group, a private person whose principal place of business is {location} (hereinafter: Licensor). This Agreement sets the terms, rights, restrictions and obligations on using Crazy Coop (hereinafter: The Software) created and owned by Licensor, as detailed herein</p></li><li><p><strong>License Grant:</strong> Licensor hereby grants Licensee a Sublicensable, Non-assignable &amp; non-transferable, Pepetual, Commercial with terms, Including the rights to create but not distribute derivative works, Non-exclusive license, all with accordance with the terms set forth and other legal restrictions set forth in 3rd party software used while running Software.</p><ol><li><p><strong>Limited:</strong> Licensee may use Software for the purpose of:</p><ol><li>Running Software on Licensee&rsquo;s Website[s] and Server[s];</li><li>Allowing 3rd Parties to run Software on Licensee&rsquo;s Website[s] and Server[s];</li><li>Publishing Software&rsquo;s output to Licensee and 3rd Parties;</li><li>Distribute verbatim copies of Software&rsquo;s output (including compiled binaries);</li><li>Modify Software to suit Licensee&rsquo;s needs and specifications.</li></ol> </li><li>This license is granted perpetually, as long as you do not materially breach it.</li><li><b>Binary Restricted:</b> Licensee may sublicense Software as a part of a larger work containing more than Software, distributed solely in Object or Binary form under a personal, non-sublicensable, limited license. Such redistribution shall be limited to unlimited codebases.</li><li><p><strong>Non Assignable &amp; Non-Transferable:</strong> Licensee may not assign or transfer his rights and duties under this license.</p></li><li><p><strong>Commercial use allowed with restrictions:</strong> Give us some pizza.</p></li><li><p><strong>Including the Right to Create Derivative Works: </strong>Licensee may create derivative works based on Software, including amending Software&rsquo;s source code, modifying it, integrating it into a larger work or removing portions of Software, as long as no distribution of the derivative works is made</p></li><li><p><strong>With Attribution Requirements﻿:</strong> Please think about us sometimes.</p></li></ol></li><li> <strong>Term &amp; Termination:</strong> The Term of this license shall be until terminated. Licensor may terminate this Agreement, including Licensee&rsquo;s license in the case where Licensee : <ol><li><p>became insolvent or otherwise entered into any liquidation process; or</p></li><li><p>exported The Software to any jurisdiction where licensor may not enforce his rights under this agreements in; or</p></li><li><p>Licensee was in breach of any of this license's terms and conditions and such   breach was not cured, immediately upon notification; or</p></li><li><p>Licensee in breach of any of the terms of clause 2 to this license; or</p></li><li><p>Licensee otherwise entered into any arrangement which caused Licensor to be unable to enforce his rights under this License.</p></li></ol></li><li><strong>Payment:</strong> In consideration of the License granted under clause 2, Licensee shall pay Licensor a fee, via Credit-Card, PayPal or any other mean which Licensor may deem adequate. Failure to perform payment shall construe as material breach of this Agreement. </li><li><p><strong>Upgrades, Updates and Fixes:</strong> Licensor may provide Licensee, from time to time, with Upgrades,   Updates or Fixes, as detailed herein and according to his sole   discretion. Licensee hereby warrants to keep The Software up-to-date and   install all relevant updates and fixes, and may, at his sole discretion,   purchase upgrades, according to the rates set by Licensor. Licensor   shall provide any update or Fix free of charge; however, nothing in this   Agreement shall require Licensor to provide Updates or Fixes.</p><ol><li><p><strong>Upgrades:</strong> for the purpose of this license, an Upgrade  shall be a material amendment in The Software, which contains new features   and or major performance improvements and shall be marked as a new   version number. For example, should Licensee purchase The Software under   version 1.X.X, an upgrade shall commence under number 2.0.0.</p></li><li><p><strong>Updates: </strong> for the purpose of this license, an update shall be a minor amendment   in The Software, which may contain new features or minor improvements and   shall be marked as a new sub-version number. For example, should   Licensee purchase The Software under version 1.1.X, an upgrade shall   commence under number 1.2.0.</p></li><li><p><strong>Fix:</strong> for the purpose of this license, a fix shall be a minor amendment in   The Software, intended to remove bugs or alter minor features which impair   the The Software's functionality. A fix shall be marked as a new   sub-sub-version number. For example, should Licensee purchase Software   under version 1.1.1, an upgrade shall commence under number 1.1.2.</p></li></ol></li><li><p><strong>Support:</strong> Software is provided under an AS-IS basis and without any support, updates or maintenance. Nothing in this Agreement shall require Licensor to provide Licensee with support or fixes to any bug, failure, mis-performance or other defect in The Software.</p><ol><li><p><strong>Bug Notification: </strong> Licensee may provide Licensor of details regarding any bug, defect or   failure in The Software promptly and with no delay from such event;  Licensee  shall comply with Licensor's request for information regarding  bugs,  defects or failures and furnish him with information,  screenshots and  try to reproduce such bugs, defects or failures.</p></li><li><p><strong>Feature Request: </strong> Licensee may request additional features in Software, provided,   however, that (i) Licensee shall waive any claim or right in such feature   should feature be developed by Licensor; (ii) Licensee shall be   prohibited from developing the feature, or disclose such feature   request, or feature, to any 3rd party directly competing with Licensor   or any 3rd party which may be, following the development of such   feature, in direct competition with Licensor; (iii) Licensee warrants   that feature does not infringe any 3rd party patent, trademark,   trade-secret or any other intellectual property right; and (iv) Licensee   developed, envisioned or created the feature solely by himself.</p></li></ol></li><li><p><strong>Liability: </strong>&nbsp;To the extent permitted under Law, The Software is provided under an   AS-IS basis. Licensor shall never, and without any limit, be liable for   any damage, cost, expense or any other payment incurred by Licensee as a   result of Software&rsquo;s actions, failure, bugs and/or any other  interaction  between The Software &nbsp;and Licensee&rsquo;s end-equipment, computers,  other  software or any 3rd party, end-equipment, computer or  services.  &nbsp;Moreover, Licensor shall never be liable for any defect in  source code  written by Licensee when relying on The Software or using The Software&rsquo;s source  code.</p></li><li><p><strong>Warranty: &nbsp;</strong></p><ol><li><p><strong>Intellectual Property: </strong>Licensor   hereby warrants that The Software does not violate or infringe any 3rd   party claims in regards to intellectual property, patents and/or   trademarks and that to the best of its knowledge no legal action has   been taken against it for any infringement or violation of any 3rd party   intellectual property rights.</p></li><li><p><strong>No-Warranty:</strong> The Software is provided without any warranty; Licensor hereby disclaims   any warranty that The Software shall be error free, without defects or code   which may cause damage to Licensee&rsquo;s computers or to Licensee, and  that  Software shall be functional. Licensee shall be solely liable to  any  damage, defect or loss incurred as a result of operating software  and  undertake the risks contained in running The Software on License&rsquo;s  Server[s]  and Website[s].</p></li><li><p><strong>Prior Inspection: </strong> Licensee hereby states that he inspected The Software thoroughly and found   it satisfactory and adequate to his needs, that it does not interfere   with his regular operation and that it does meet the standards and  scope  of his computer systems and architecture. Licensee found that  The Software  interacts with his development, website and server environment  and that  it does not infringe any of End User License Agreement of any  software  Licensee may use in performing his services. Licensee hereby  waives any  claims regarding The Software's incompatibility, performance,  results and  features, and warrants that he inspected the The Software.</p></li></ol></li><li><p><strong>No Refunds:</strong> Licensee warrants that he inspected The Software according to clause 7(c)   and that it is adequate to his needs. Accordingly, as The Software is   intangible goods, Licensee shall not be, ever, entitled to any refund,   rebate, compensation or restitution for any reason whatsoever, even if   The Software contains material flaws.</p></li><li><p><strong>Indemnification:</strong> Licensee hereby warrants to hold Licensor harmless and indemnify   Licensor for any lawsuit brought against it in regards to Licensee&rsquo;s use   of The Software in means that violate, breach or otherwise circumvent this   license, Licensor's intellectual property rights or Licensor's title  in  The Software. Licensor shall promptly notify Licensee in case of such  legal  action and request Licensee&rsquo;s consent prior to any settlement in   relation to such lawsuit or claim.</p></li><li><p><strong>Governing Law, Jurisdiction: </strong>Licensee hereby agrees not to initiate class-action lawsuits against   Licensor in relation to this license and to compensate Licensor for any   legal fees, cost or attorney fees should any claim brought by Licensee   against Licensor be denied, in part or in full.</p></li></ol>		</div></div></div>"];
    [html appendString:@"</body></html>"];
    
    //instantiate the web view
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 200)];
    
    //make the background transparent
    [webView setBackgroundColor:[UIColor clearColor]];
    
    //pass the string to the webview
    [webView loadHTMLString:[html description] baseURL:nil];
    
    //add it to the subview
    [self addSubview:webView];
    
}

//lazy man tap to exit, dont wanna register all clicks
- (void) setupDismissButton{
    _dismissButton = [[UIButton alloc]initWithFrame:CGRectZero];
    [_dismissButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_dismissButton];
    
    [_dismissButton addWidthConstraint:100];
    [_dismissButton addBottomConstraint:10];
    [_dismissButton addHeightConstraint:50];
    [_dismissButton addLeadingConstraint:10];
    
    [_dismissButton setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
    [_dismissButton setTitle:@"Decline" forState:UIControlStateNormal];
}

- (void) setupAcceptButton{
    _acceptButton = [[UIButton alloc]initWithFrame:CGRectZero];
    [_acceptButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_acceptButton];
    
    [_acceptButton addWidthConstraint:100];
    [_acceptButton addBottomConstraint:10];
    [_acceptButton addHeightConstraint:50];
    [_acceptButton addTrailingConstraint:10];
    
    [_acceptButton setBackgroundColor:[UIColor colorWithRed:0 green:1 blue:0 alpha:1]];
    [_acceptButton setTitle:@"Accept" forState:UIControlStateNormal];
    [_acceptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

}

@end
