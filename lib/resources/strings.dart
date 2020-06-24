//DON'T EDIT OR TRANSLATE
import 'package:rxdart/rxdart.dart';

class CodeStrings {
  static final googleMapsServerAPI = "AIzaSyDbwppcxdRlIqQ3o20xYU2T0_oSpi5IrbI";

  static final updateSPNodeName = "updateSP";

  static final mode_archive = "mode_archive";
  static final AMAZON_PAY = "AMAZON_PAY";
  static final BANK_TRANSFER = "BANK_TRANSFER";
  static final CASH_ON_DELIVERY = "CASH_ON_DELIVERY";
  static final AS_ORDER = "AS_ORDER";
  static final AS_INV = "AS_INV";
  static final chatDBName = "chat";
  static final worker = "worker";
  static final sp = "sp";
  static final standard = "standard";
  static final custom = "custom";

  static const msg_type_price_offer = "price_offer";
  static const msg_type_customer_rate_sp = "customer_rate_sp";
  static const msg_type_price_retract = "price_retract";
  static const msg_type_price_normal = "normal";
  static const msg_type_price_reject = "price_reject";
  static const msg_type_text = "text";
  static const msg_type_image = "image";
  static const msg_type_audio = "audio";
  static const msg_type_invitation_completed = "invitation_completed";
  static const msg_type_invitation_closed = "invitation_closed";
  static const msg_type_loading = "loading";
  static const msg_type_navigation_started = "navigation_started";
  static const msg_type_worker_arrived = "worker_arrived";
  static const msg_type_visit_created = "visit_created";
  static const msg_type_visit_updated = "visit_updated";
  static const msg_type_visit_deleted = "visit_deleted";
  static const msg_type_invitation_cancelled = "invitation_cancelled";
  static const msg_type_visit_done = "visit_done";
  static const msg_type_visit_completed = "visit_done";
  static const msg_type_bill_paid = "bill_paid";
  static const msg_type_bill_created = "bill_created";
  static const msg_type_order_closed = "order_closed";
  static const msg_type_sp_rate_customer = "sp_rate_customer";
  static const msg_type_sp_invitation_unavailable = "invitation_unavailable";
  static const msg_type_sp_invitation_rejected = "invitation_rejected";
  static const msg_type_sp_invitation_closed = "invitation_closed";

  static const can_offer = "can_offer";
  static const can_retract = "can_retract";

  static const openStatus = "_OPEN";
  static const onTheWay = "_ON_HIS_WAY";
  static const startedWorking = "_WORKING";
  static const done = "_DONE";

  static const r_openStatus = "OPEN";
  static const r_onTheWay = "ON_HIS_WAY";
  static const r_startedWorking = "WORKING";
  static const r_done = "DONE";

  static const c_pending = "PENDING";
  static const r_in_progress = "IN_PROGRESS";
  static const r_complete = "COMPLETE";
  static const c_paid = "PAID";
  static const c_created = "CREATED";
  static const c_cancelled = "CANCELLED";
  static const c_waiting_payment = "WAITING_PAYMENT";

  static const r_rejected = "_REJECTED";
  static const r_accepted = "_ACCEPTED";

  static const g_accepted = "ACCEPTED";

  static final inv_accepted = "accepted";
  static final inv_rejected = "rejected";
  static const inv_closed = "closed";
  static const inv_cancelled = "cancelled";
  static const inv_unavailable = "unavailable";
  static const inv_status_completed = "completed";

  static final inv_pending = "pending";
  static final inv_in_progress= "in_progress";

  static const visit_status_done = "DONE";
  static const inv_status_closed = "_CLOSED";

  static const String sunday = "Sunday";
  static const String monday = "Monday";
  static const String tuesday = "Tuesday";
  static const String wednesday = "Wednesday";
  static const String thursday = "Thursday";
  static const String friday = "Friday";
  static const String saturday = "Saturday";

  static const String addVisit = "addVisit";
  static const String editVisit = "editVisit";
}

class AppStrings {
  static PublishSubject<String> langChangedSubject = PublishSubject();
  static String currentCode = en_code;

  /* Chat */
  static const String tapToRecord = "Tap to record";
  static const String tapToStop = "Tap to stop";
  static const String tapToPause = "Tap to pause";
  static const String tapToPlay = "Tap to play";
  static const String recordAudio = "Record Audio";
  static const String audioLoading = "Audio is being uploaded";

  static String get taxIdSubtitle => _sMap[currentCode]["taxIdSubtitle"];
  static String get taxIdRequired => _sMap[currentCode]["taxIdRequired"];
  static String get taxId => _sMap[currentCode]["taxId"];
  static String get readyText => _sMap[currentCode]["readyText"];

  static String get workersAssigned => _sMap[currentCode]["workersAssigned"];
  static String get generatedBill => _sMap[currentCode]["generatedBill"];
  static String get uploadedDoc => _sMap[currentCode]["uploadedDoc"];
  static String get cash => _sMap[currentCode]["cash"];

  static String get mySelf => _sMap[currentCode]["mySelf"];

  static String get gallery => _sMap[currentCode]["gallery"];

  static String get camera => _sMap[currentCode]["camera"];

  static String get initialPrice => _sMap[currentCode]["initialPrice"];

  static String get giveRating => _sMap[currentCode]["giveRating"];

  static String get getDirections => _sMap[currentCode]["getDirections"];

  static String get assignedSelf => _sMap[currentCode]["assignedSelf"];

  static String get send => _sMap[currentCode]["send"];

  static String get edit => _sMap[currentCode]["edit"];

  static String get viewWorkerLoc => _sMap[currentCode]["viewWorkerLoc"];

  static String get youAssigned => _sMap[currentCode]["youAssigned"];

  static String get no => _sMap[currentCode]["no"];

  static String get smallCompany => _sMap[currentCode]["smallCompany"];

  static String get submitting => _sMap[currentCode]["submitting"];

  static String get archive => _sMap[currentCode]["archive"];

  static String get deleteBillDesc => _sMap[currentCode]["deleteBillDesc"];

  static String get amazon_pay => _sMap[currentCode]["amazon_pay"];

  static String get bank_transfer => _sMap[currentCode]["bank_transfer"];

  static String get cash_on_delivery => _sMap[currentCode]["cash_on_delivery"];

  static String get customerSetPayment =>
      _sMap[currentCode]["customerSetPayment"];

  static String get assignedOn => _sMap[currentCode]["assignedOn"];

  static String get genRate => _sMap[currentCode]["genRate"];

  static String get notInterested => _sMap[currentCode]["notInterested"];

  static String get euro => _sMap[currentCode]["euro"];

  static String get priceRate => _sMap[currentCode]["priceRate"];

  static String get youRated => _sMap[currentCode]["youRated"];

  static String get ratedYou => _sMap[currentCode]["ratedYou"];

  static String get rating => _sMap[currentCode]["rating"];

  static String get gotPaid => _sMap[currentCode]["gotPaid"];

  static String get err_fileOrDesc => _sMap[currentCode]["err_fileOrDesc"];

  static String get s_bill_pending => _sMap[currentCode]["s_bill_pending"];

  static String get s_waiting_payment =>
      _sMap[currentCode]["s_waiting_payment"];

  static String get s_created => _sMap[currentCode]["s_created"];

  static String get deleteBill => _sMap[currentCode]["deleteBill"];

  static String get cantUndoAction => _sMap[currentCode]["cantUndoAction"];

  static String get sureDeleteBill => _sMap[currentCode]["sureDeleteBill"];

  static String get submit => _sMap[currentCode]["submit"];

  static String get billDocument => _sMap[currentCode]["billDocument"];

  static String get addNewBill => _sMap[currentCode]["addNewBill"];

  static String get managePayment => _sMap[currentCode]["managePayment"];

  static String get paymentMethod => _sMap[currentCode]["paymentMethod"];
  static String get selectedPaymentMethod => _sMap[currentCode]["selectedPaymentMethod"];

  static String get billDate => _sMap[currentCode]["billDate"];

  static String get description => _sMap[currentCode]["description"];
  static String get descriptionText => _sMap[currentCode]["descriptionText"];

  static String get myBills => _sMap[currentCode]["myBills"];

  static String get requestBill => _sMap[currentCode]["requestBill"];
  static String get requestNewBill => _sMap[currentCode]["requestNewBill"];

  static String get addBills => _sMap[currentCode]["addBills"];

  static String get noBills => _sMap[currentCode]["noBills"];

  static String get updatingVisit => _sMap[currentCode]["updatingVisit"];

  static String get emailRegistered => _sMap[currentCode]["emailRegistered"];

  static String get editVisit => _sMap[currentCode]["editVisit"];

  static String get saveChanges => _sMap[currentCode]["saveChanges"];

  static String get s_unavailable => _sMap[currentCode]["s_unavailable"];

  static String get s_cancelled => _sMap[currentCode]["s_cancelled"];

  static String get s_closed => _sMap[currentCode]["s_closed"];

  static String get loading => _sMap[currentCode]["loading"];

  static String get call => _sMap[currentCode]["call"];

  static String get tasks => _sMap[currentCode]["tasks"];

  static String get task => _sMap[currentCode]["task"];

  static String get assignmentCompleted =>
      _sMap[currentCode]["assignmentCompleted"];

  static String get doneWorking => _sMap[currentCode]["doneWorking"];

  static String get doneWorkingMsg => _sMap[currentCode]["doneWorkingMsg"];

  static String get priceRetracted => _sMap[currentCode]["priceRetracted"];

  static String get priceRetractedMsg =>
      _sMap[currentCode]["priceRetractedMsg"];

  static String get priceOffered => _sMap[currentCode]["priceOffered"];
  static String get visitDeleted => _sMap[currentCode]["visitDeleted"];
  static String get visitCompleted => _sMap[currentCode]["visitCompleted"];
  static String get rateAdded => _sMap[currentCode]["rateAdded"];
  static String get invitationClosed => _sMap[currentCode]["invitationClosed"];
  static String get invitationCompleted => _sMap[currentCode]["invitationCompleted"];
  static String get invitationDeleted => _sMap[currentCode]["invitationDeleted"];
  static String get anotherOffer => _sMap[currentCode]["anotherOffer"];
  static String get visitCreated => _sMap[currentCode]["visitCreated"];
  static String get billCreated => _sMap[currentCode]["billCreated"];
  static String get billPaid => _sMap[currentCode]["billPaid"];
  static String get orderClosed => _sMap[currentCode]["orderClosed"];
  static String get navigationStarted => _sMap[currentCode]["navigationStarted"];

  static String get priceRejected => _sMap[currentCode]["priceRejected"];

  static String get sendingPrice => _sMap[currentCode]["sendingPrice"];

  static String get retractingPrice => _sMap[currentCode]["retractingPrice"];

  static String get emptyPrice => _sMap[currentCode]["emptyPrice"];

  static String get initialOfferProposed =>
      _sMap[currentCode]["initialOfferProposed"];

  static String get reject => _sMap[currentCode]["reject"];

  static String get accept => _sMap[currentCode]["accept"];

  static String get rejectInvitationMsg =>
      _sMap[currentCode]["rejectInvitationMsg"];

  static String get rejectInvitationHeader =>
      _sMap[currentCode]["rejectInvitationHeader"];

  static String get problemDetails => _sMap[currentCode]["problemDetails"];

  static String get contact => _sMap[currentCode]["contact"];

  static String get typeYourMessage => _sMap[currentCode]["typeYourMessage"];

  static String get imageLoading => _sMap[currentCode]["imageLoading"];

  static String get cantUpdateVisit => _sMap[currentCode]["cantUpdateVisit"];

  static String get selectWorkersError =>
      _sMap[currentCode]["selectWorkersError"];

  static String get selectWorkers => _sMap[currentCode]["selectWorkers"];

  static String get setVisitDate => _sMap[currentCode]["setVisitDate"];

  static String get selectDateError => _sMap[currentCode]["selectDateError"];

  static String get activeVisit => _sMap[currentCode]["activeVisit"];

  static String get noRole => _sMap[currentCode]["noRole"];

  static String get errorOccured => _sMap[currentCode]["errorOccured"];

  static String get cantGetWorkers => _sMap[currentCode]["cantGetWorkers"];

  static String get register => _sMap[currentCode]["register"];

  static String get createAccount => _sMap[currentCode]["createAccount"];

  static String get signup => _sMap[currentCode]["signup"];

  static String get agbRules => _sMap[currentCode]["agbRules"];

  static String get agreeError => _sMap[currentCode]["agreeError"];

  static String get agb => _sMap[currentCode]["agb"];

  static String get agreeTo => _sMap[currentCode]["agreeTo"];

  static String get alreadyMember => _sMap[currentCode]["alreadyMember"];

  static String get login => _sMap[currentCode]["login"];
  static String get acceptRules1 => _sMap[currentCode]["acceptRules1"];
  static String get acceptRules2 => _sMap[currentCode]["acceptRules2"];
  static String get terms => _sMap[currentCode]["terms"];
  static String get termsAndConditions =>
      _sMap[currentCode]["termsAndConditions"];

  static String get loginToSercl => _sMap[currentCode]["loginToSercl"];

  static String get forgotPassword => _sMap[currentCode]["forgotPassword"];

  static String get noAccount => _sMap[currentCode]["noAccount"];

  static String get password => _sMap[currentCode]["password"];

  static String get email => _sMap[currentCode]["email"];

  static String get enterEmail => _sMap[currentCode]["enterEmail"];

  static String get resetPassword => _sMap[currentCode]["resetPassword"];

  static String get emailRequired => _sMap[currentCode]["emailRequired"];

  static String get passwordRequired => _sMap[currentCode]["passwordRequired"];

  static String get passHint => _sMap[currentCode]["passHint"];

  static String get confirmPassword => _sMap[currentCode]["confirmPassword"];

  static String get invalidEmail => _sMap[currentCode]["invalidEmail"];

  static String get invalidPassword => _sMap[currentCode]["invalidPassword"];

  static String get passwordDontMatch =>
      _sMap[currentCode]["passwordDontMatch"];

  static String get checkEmail => _sMap[currentCode]["checkEmail"];

  static String get resetDone => _sMap[currentCode]["resetDone"];

  static String get signupSuccess => _sMap[currentCode]["signupSuccess"];

  static String get success => _sMap[currentCode]["success"];

  static String get enterNewPassword => _sMap[currentCode]["enterNewPassword"];

  static String get passwordChangeSuccess =>
      _sMap[currentCode]["passwordChangeSuccess"];

  static String get profileNotFound => _sMap[currentCode]["profileNotFound"];

  static String get companyInfo => _sMap[currentCode]["companyInfo"];

  static String get companyName => _sMap[currentCode]["companyName"];

  static String get companyNameHint => _sMap[currentCode]["companyNameHint"];

  static String get companyBio => _sMap[currentCode]["companyBio"];

  static String get companyBioHint => _sMap[currentCode]["companyBioHint"];

  static String get addImages => _sMap[currentCode]["addImages"];

  static String get saveAndContinue => _sMap[currentCode]["saveAndContinue"];

  static String get legalDocuments => _sMap[currentCode]["legalDocuments"];

  static String get businessCertificate =>
      _sMap[currentCode]["businessCertificate"];

  static String get insurance => _sMap[currentCode]["insurance"];

  static String get contract => _sMap[currentCode]["contract"];

  static String get areas => _sMap[currentCode]["areas"];

  static String get area => _sMap[currentCode]["area"];

  static String get from => _sMap[currentCode]["from"];

  static String get invalidFromTo => _sMap[currentCode]["invalidFromTo"];

  static String get to => _sMap[currentCode]["to"];

  static String get myCodes => _sMap[currentCode]["myCodes"];

  static String get noAreas => _sMap[currentCode]["noAreas"];

  static String get forServiceProviders =>
      _sMap[currentCode]["forServiceProviders"];

  static String get nameLogoBio => _sMap[currentCode]["nameLogoBio"];

  static String get areasSub => _sMap[currentCode]["areasSub"];

  static String get invalidAreas => _sMap[currentCode]["invalidAreas"];

  static String get outOfOrderAreas => _sMap[currentCode]["outOfOrderAreas"];

  static String get services => _sMap[currentCode]["services"];

  static String get servicesSub => _sMap[currentCode]["servicesSub"];

  static String get billingInfoTitle => _sMap[currentCode]["billingInfoTitle"];

  static String get billingInfoSubtitle =>
      _sMap[currentCode]["billingInfoSubtitle"];

  static String get streetName => _sMap[currentCode]["streetName"];

  static String get streetNameRequired =>
      _sMap[currentCode]["streetNameRequired"];

  static String get streetNumber => _sMap[currentCode]["streetNumber"];

  static String get streetNumberRequired =>
      _sMap[currentCode]["streetNumberRequired"];

  static String get postalCode => _sMap[currentCode]["postalCode"];

  static String get postalCodeRequired =>
      _sMap[currentCode]["postalCodeRequired"];

  static String get city => _sMap[currentCode]["city"];

  static String get cityRequired => _sMap[currentCode]["cityRequired"];

  static String get companyPhoneNumber =>
      _sMap[currentCode]["companyPhoneNumber"];

  static String get companyPhoneNumberRequired =>
      _sMap[currentCode]["companyPhoneNumberRequired"];

  static String get iban => _sMap[currentCode]["iban"];

  static String get ibanRequired => _sMap[currentCode]["ibanRequired"];

  static String get bic => _sMap[currentCode]["bic"];

  static String get bicRequired => _sMap[currentCode]["bicRequired"];

  static String get address => _sMap[currentCode]["address"];

  static String get phoneNumber => _sMap[currentCode]["phoneNumber"];

  static String get accountInfo => _sMap[currentCode]["accountInfo"];

  static String get legalDocumentsSub =>
      _sMap[currentCode]["legalDocumentsSub"];

  static String get fromHint => _sMap[currentCode]["fromHint"];

  static String get toHint => _sMap[currentCode]["toHint"];

  static String get pending => _sMap[currentCode]["pending"];

  static String get pleaseWait => _sMap[currentCode]["pleaseWait"];

  static String get areasSuccess => _sMap[currentCode]["areasSuccess"];

  static String get fromRequired => _sMap[currentCode]["fromRequired"];

  static String get toRequired => _sMap[currentCode]["toRequired"];

  static String get areasRequired => _sMap[currentCode]["areasRequired"];

  static String get invalidCharacters =>
      _sMap[currentCode]["invalidCharacters"];

  static String get removeImage => _sMap[currentCode]["removeImage"];

  static String get companyInfoSuccess =>
      _sMap[currentCode]["companyInfoSuccess"];

  static String get companyNameRequired =>
      _sMap[currentCode]["companyNameRequired"];

  static String get legalSuccess => _sMap[currentCode]["legalSuccess"];

  static String get uploadFile => _sMap[currentCode]["uploadFile"];

  static String get removeFile => _sMap[currentCode]["removeFile"];

  static String get editFile => _sMap[currentCode]["editFile"];

  static String get companyBioRequired =>
      _sMap[currentCode]["companyBioRequired"];

  static String get companyLogo => _sMap[currentCode]["companyLogo"];

  static String get editImage => _sMap[currentCode]["editImage"];

  static String get notes => _sMap[currentCode]["notes"];

  static String get note => _sMap[currentCode]["note"];

  static String get logout => _sMap[currentCode]["logout"];

  static String get submitForReview => _sMap[currentCode]["submitForReview"];

  static String get gotNotes => _sMap[currentCode]["gotNotes"];

  static String get viewNotes => _sMap[currentCode]["viewNotes"];

  static String get refresh => _sMap[currentCode]["refresh"];

  static String get servicesSuccess => _sMap[currentCode]["servicesSuccess"];

  static String get servicesRequired => _sMap[currentCode]["servicesRequired"];

  static String get remove => _sMap[currentCode]["remove"];

  static String get selectFile => _sMap[currentCode]["selectFile"];

  static String get settings => _sMap[currentCode]["settings"];

  static String get profile => _sMap[currentCode]["profile"];

  static String get adminPanel => _sMap[currentCode]["adminPanel"];

  static String get showMore => _sMap[currentCode]["showMore"];

  static String get showLess => _sMap[currentCode]["showLess"];

  static String get createVisit => _sMap[currentCode]["createVisit"];

  static String get greatProgress => _sMap[currentCode]["greatProgress"];

  static String get noProblem => _sMap[currentCode]["noProblem"];

  static String get visitDeletedMsg => _sMap[currentCode]["visitDeletedMsg"];

  static String get workersAssignedMsg =>
      _sMap[currentCode]["workersAssignedMsg"];

  static String get selfAssignedMsg => _sMap[currentCode]["selfAssignedMsg"];

  static String get creatingVisit => _sMap[currentCode]["creatingVisit"];

  static String get addVisit => _sMap[currentCode]["addVisit"];

  static String get appointment => _sMap[currentCode]["appointment"];

  static String get avWorkers => _sMap[currentCode]["avWorkers"];

  static String get available => _sMap[currentCode]["available"];

  static String get unavailable => _sMap[currentCode]["unavailable"];

  static String get unavWorkers => _sMap[currentCode]["unavWorkers"];

  static String get submitVisit => _sMap[currentCode]["submitVisit"];

  static String get select => _sMap[currentCode]["select"];

  static String get selected => _sMap[currentCode]["selected"];

  static String get setDate => _sMap[currentCode]["setDate"];

  static String get date => _sMap[currentCode]["date"];

  static String get time => _sMap[currentCode]["time"];

  static String get details => _sMap[currentCode]["details"];

  static String get visits => _sMap[currentCode]["visits"];

  static String get files => _sMap[currentCode]["files"];

  static String get deleteVisit => _sMap[currentCode]["deleteVisit"];

  static String get deleteVisitMsg => _sMap[currentCode]["deleteVisitMsg"];

  static String get cancel => _sMap[currentCode]["cancel"];

  static String get delete => _sMap[currentCode]["delete"];

  static String get filters => _sMap[currentCode]["filters"];

  static String get categories => _sMap[currentCode]["categories"];

  static String get applyFilters => _sMap[currentCode]["applyFilters"];

  static String get clear => _sMap[currentCode]["clear"];

  static String get zip => _sMap[currentCode]["zip"];

  static String get s_pending => _sMap[currentCode]["s_pending"];

  static String get s_rejected => _sMap[currentCode]["s_rejected"];

  static String get s_accepted => _sMap[currentCode]["s_accepted"];

  static String get s_inProgress => _sMap[currentCode]["s_inProgress"];

  static String get s_complete => _sMap[currentCode]["s_complete"];

  static String get s_completed => _sMap[currentCode]["s_completed"];
  static String get invitationRejected => _sMap[currentCode]["invitationRejected"];

  static String get s_paid => _sMap[currentCode]["s_paid"];

  static String get receipt => _sMap[currentCode]["receipt"];

  static String get deleteReceipt => _sMap[currentCode]["deleteReceipt"];

  static String get deleteReceiptMsg => _sMap[currentCode]["deleteReceiptMsg"];

  static String get s_open => _sMap[currentCode]["s_open"];

  static String get s_onhisway => _sMap[currentCode]["s_onhisway"];

  static String get s_working => _sMap[currentCode]["s_working"];

  static String get s_done => _sMap[currentCode]["s_done"];

  static String get assignments => _sMap[currentCode]["assignments"];
  static String get openAssignments => _sMap[currentCode]["openAssignments"];

  static String get history => _sMap[currentCode]["history"];

  static String get completedJobs => _sMap[currentCode]["completedJobs"];

  static String get invitations => _sMap[currentCode]["invitations"];

  static String get searchByCustomerName =>
      _sMap[currentCode]["searchByCustomerName"];

  static String get currentPassword => _sMap[currentCode]["currentPassword"];

  static String get newPassword => _sMap[currentCode]["newPassword"];

  static String get confirmNewPassword =>
      _sMap[currentCode]["confirmNewPassword"];

  static String get progress => _sMap[currentCode]["progress"];

  static String get noWorkers => _sMap[currentCode]["noWorkers"];

  static String get noWorkersMessage => _sMap[currentCode]["noWorkersMessage"];

  static String get gotIt => _sMap[currentCode]["gotIt"];

  static String get workerHelp => _sMap[currentCode]["workerHelp"];

  static String get nameRequired => _sMap[currentCode]["nameRequired"];

  static String get invalidInput => _sMap[currentCode]["invalidInput"];

  static String get name => _sMap[currentCode]["name"];

  static String get status => _sMap[currentCode]["status"];

  static String get changedStatusTo => _sMap[currentCode]["changedStatusTo"];

  static String get noVisits => _sMap[currentCode]["noVisits"];

  static String get upload => _sMap[currentCode]["upload"];

  static String get receivedPayment => _sMap[currentCode]["receivedPayment"];

  static String get setPaid => _sMap[currentCode]["setPaid"];

  static String get setPaidMsg => _sMap[currentCode]["setPaidMsg"];

  static String get noScheduledVisits =>
      _sMap[currentCode]["noScheduledVisits"];

  static String get conflicts => _sMap[currentCode]["conflicts"];

  static String get conflictingVisits =>
      _sMap[currentCode]["conflictingVisits"];

  static String get updateStatus => _sMap[currentCode]["updateStatus"];

  static String get updateStatusBody => _sMap[currentCode]["updateStatusBody"];

  static String get yes => _sMap[currentCode]["yes"];

  static String get open => _sMap[currentCode]["open"];

  static String get onTheWay => _sMap[currentCode]["onTheWay"];

  static String get startedWorking => _sMap[currentCode]["startedWorking"];

  static String get done => _sMap[currentCode]["done"];

  static String get editSchedule => _sMap[currentCode]["editSchedule"];

  static String get changePassword => _sMap[currentCode]["changePassword"];

  static String get next => _sMap[currentCode]["next"];

  static String get schedule => _sMap[currentCode]["schedule"];

  static String get account => _sMap[currentCode]["account"];

  static String get day => _sMap[currentCode]["day"];

  static String get worker => _sMap[currentCode]["worker"];

  static String get sunday => _sMap[currentCode]["sunday"];

  static String get monday => _sMap[currentCode]["monday"];

  static String get tuesday => _sMap[currentCode]["tuesday"];

  static String get wednesday => _sMap[currentCode]["wednesday"];

  static String get thursday => _sMap[currentCode]["thursday"];

  static String get friday => _sMap[currentCode]["friday"];

  static String get saturday => _sMap[currentCode]["saturday"];

  static String get workerName => _sMap[currentCode]["workerName"];

  static String get workerEmail => _sMap[currentCode]["workerEmail"];

  static String get workers => _sMap[currentCode]["workers"];

  static String get addWorkers => _sMap[currentCode]["addWorkers"];

  static String get editWorker => _sMap[currentCode]["editWorker"];

  static String get standardSchedule => _sMap[currentCode]["standardSchedule"];

  static String get standard => _sMap[currentCode]["standard"];

  static String get custom => _sMap[currentCode]["custom"];

  static String get customSchedule => _sMap[currentCode]["customSchedule"];

  static String get standardTime => _sMap[currentCode]["standardTime"];

  static String get fullSchedule => _sMap[currentCode]["fullSchedule"];

  static String get noWorkersYet => _sMap[currentCode]["noWorkersYet"];

  static String get noAssignments => _sMap[currentCode]["noAssignments"];

  static String get deleteTech => _sMap[currentCode]["deleteTech"];

  static String get deleteTechMsg => _sMap[currentCode]["deleteTechMsg"];

  static String get changeLang => _sMap[currentCode]["changeLang"];

  static String get English => _sMap[currentCode]["English"];

  static String get customerDetails => _sMap[currentCode]["customerDetails"];

  static String get attachments => _sMap[currentCode]["attachments"];

  static String get chats => _sMap[currentCode]["chats"];

  static String get noInvitations => _sMap[currentCode]["noInvitations"];

  static String get noInvitationsMsg => _sMap[currentCode]["noInvitationsMsg"];

  static String get noChats => _sMap[currentCode]["noChats"];

  static String get noChatsMsg => _sMap[currentCode]["noChatsMsg"];

  static String get noWork => _sMap[currentCode]["noWork"];

  static String get noWorkMsg => _sMap[currentCode]["noWorkMsg"];

  static String get noReviewes => _sMap[currentCode]["noReviewes"];

  static String get noReviewesMsg => _sMap[currentCode]["noReviewesMsg"];

  static String get allWell => _sMap[currentCode]["allWell"];

  static String get proposeOffer => _sMap[currentCode]["proposeOffer"];

  static String get liveLocation => _sMap[currentCode]["liveLocation"];

  static String get sendOffer => _sMap[currentCode]["sendOffer"];

  static String get initialOffer => _sMap[currentCode]["initialOffer"];

  static String get estimatedPrice => _sMap[currentCode]["estimatedPrice"];

  static String get priceOfferMsg => _sMap[currentCode]["priceOfferMsg"];


  static String get proposedOffer => _sMap[currentCode]["proposedOffer"];

  static String get retract => _sMap[currentCode]["retract"];

  static String get retractOffer => _sMap[currentCode]["retractOffer"];

  static String get retractOfferMsg => _sMap[currentCode]["retractOfferMsg"];

  static String get requestDetails => _sMap[currentCode]["requestDetails"];

  static String get block => _sMap[currentCode]["block"];

  static String get payment => _sMap[currentCode]["payment"];

  static String get complain => _sMap[currentCode]["complain"];

  static String get blockUser => _sMap[currentCode]["blockUser"];

  static String get blockWarning => _sMap[currentCode]["blockWarning"];

  static String get workersCountError =>
      _sMap[currentCode]["workersCountError"];

  static String get cannotSendMessage_unavailable =>
      _sMap[currentCode]["cannotSendMessage_unavailable"];

  static String get cannotSendMessage_closed =>
      _sMap[currentCode]["cannotSendMessage_closed"];

  static String get cannotSendMessage_cancelled =>
      _sMap[currentCode]["cannotSendMessage_cancelled"];

  static String get doneNavigating => _sMap[currentCode]["doneNavigating"];

  static String get arrived => _sMap[currentCode]["arrived"];

  static String get onWay => _sMap[currentCode]["onWay"];

  static String get notify => _sMap[currentCode]["notify"];

  static String get workerOnWay => _sMap[currentCode]["workerOnWay"];

  static String get workerArrived => _sMap[currentCode]["workerArrived"];

  static String get workerDoneWorking =>
      _sMap[currentCode]["workerDoneWorking"];

  static String get offer => _sMap[currentCode]["offer"];

  static String get sorry => _sMap[currentCode]["sorry"];

  static String get congratulations => _sMap[currentCode]["congratulations"];

  static String get offerdMsg => _sMap[currentCode]["offerdMsg"];

  static String get rejectMsg => _sMap[currentCode]["rejectMsg"];

  static String get acceptedMsg => _sMap[currentCode]["acceptedMsg"];

  static String get assignMySelf => _sMap[currentCode]["assignMySelf"];

  static String get selfAssignDialog => _sMap[currentCode]["selfAssignDialog"];

  static String get complainHeader => _sMap[currentCode]["complainHeader"];

  static String get weGotComplain => _sMap[currentCode]["weGotComplain"];

  static String get complainContact => _sMap[currentCode]["complainContact"];

  static String get complainRequired => _sMap[currentCode]["complainRequired"];

  static String get workLog => _sMap[currentCode]["workLog"];

  static String get assignedWorkers => _sMap[currentCode]["assignedWorkers"];

  static String get started => _sMap[currentCode]["started"];

  static String get finished => _sMap[currentCode]["finished"];

  static String get enjoyedWorking => _sMap[currentCode]["enjoyedWorking"];

  static String get rateExperience => _sMap[currentCode]["rateExperience"];

  static String get info => _sMap[currentCode]["info"];

  static String get reviews => _sMap[currentCode]["reviews"];

  static String get visitDate => _sMap[currentCode]["visitDate"];

  static String get greatJob => _sMap[currentCode]["greatJob"];
  static String get thanks => _sMap[currentCode]["thanks"];

  static String get rate => _sMap[currentCode]["rate"];

  static String get assignmentDone => _sMap[currentCode]["assignmentDone"];

  static const Map<String, Map<String, String>> _sMap = {
    AppStrings.en_code: {
      "taxIdRequired":"This field is necessary",
      "taxId": "Tax Number",
      "taxIdSubtitle": "(Required for large companies only)",
      "readyText": "Ready to start?",
      "workersAssigned": "Workers Assigned to the job",
      "generatedBill": "Generated Bill",
      "uploadedDoc": "Uploaded Document",
      "cash": "Cash",
      "mySelf": "Myself",
      "gallery": "Gallery",
      "camera": "Camera",
      "initialPrice": "Initial Price",
      "giveRating": "Give Rating",
      "getDirections": "Get Directions",
      "assignedSelf": "You assigned yourself",
      "send": "Send",
      "edit": "Edit",
      "viewWorkerLoc": "View worker's live location",
      "youAssigned": "You Assigned",
      "no": "No",
      "smallCompany": "Are you a small company?",
      "submitting": "Submitting...",
      "archive": "Archive",
      "deleteBillDesc":
          "Something wrong with the bill? Please delete it and create a new one",
      "amazon_pay": "Amazon Pay",
      "bank_transfer": "Klarna",
      "cash_on_delivery": "Cash On Delivery",
      "customerSetPayment": "Customer set payment method to",
      "assignedOn": "Assigned on",
      "genRate": "General Rate",
      "notInterested": "Not Interested?",
      "euro": "Euro",
      "priceRate": "Price Rate",
      "ratedYou": "You got rated",
      "youRated": "You gave rating",
      "rating": "Rating",
      "gotPaid": "Bill paid",
      "err_fileOrDesc": "Please submit atleast a document or a description",
      "s_bill_pending": "Waiting Bill Creation",
      "s_waiting_payment": "Waiting Customer Payment",
      "s_created": "Created",
      "deleteBill": "Delete Bill",
      "sureDeleteBill": "Are you sure you want to delete this bill?",
      "cantUndoAction": "**Note: You'll not be able to undo this action",
      "submit": "Submit",
      "billDocument": "If materials have been purchased for the order, please take photos and upload the photo here",
      "addNewBill": "Request Bill",
      "managePayment": "Manage Payment",
      "paymentMethod": "Payment Method",
      "selectedPaymentMethod": "Payment method: ",
      "billDate": "Bill request date",
      "description": "Description",
      "descriptionText": "Add all the information you need to prepare the invoice (work performed, working hours, instructions for receipts, ...)",
      "myBills": "My Bills",
      "requestNewBill": "Request New Bill",
      "requestBill": "Request Bill",
      "addBills": "Add bills to get payments from customer",
      "noBills": "No Bills",
      "updatingVisit": "Updating Visit...",
      "emailRegistered": "This email is NOT allowed to login to this app",
      "editVisit": "Edit Visit",
      "saveChanges": "Save Changes",
      "s_unavailable": "Unavailable",
      "s_cancelled": "Cancelled",
      "s_closed": "Closed",
      "priceRejected": "Offer Rejected",
      "priceOffered": "Price Offered",
      "rateAdded": "Rate Added",
      "invitationClosed": "Invitation Closed",
      "invitationDeleted": "Invitation Deleted",
      "anotherOffer": "Customer accepted another offer",
      "visitCreated": "Visit Created",
      "invitationCompleted": "Invitation Completed",
      "visitDeleted": "Visit Deleted",
      "visitCompleted": "Visit Completed",
      "orderClosed": "Assignment Closed",
      "navigationStarted": "Navigation Started",
      "billCreated": "Bill Created",
      "billPaid": "Bill Paid",
      "priceRetracted": "Offer Retracted",
      "priceRetractedMsg": "You Retracted price offer",
      "sendingPrice": "Sending Price ...",
      "retractingPrice": "Retracting Price ...",
      "loading": "Loading ...",
      "call": "CALL",
      "tasks": "Tasks",
      "task": "Task",
      "assignmentCompleted": "Task Completed Successfully",
      "doneWorking": "Done Working?",
      "doneWorkingMsg": "What did you work on today?",
      "emptyPrice": "Enter Price",
      "initialOfferProposed": "Initial Offer Proposed",
      "retract": "Retract",
      "retractOffer": "Retract Offer",
      "retractOfferMsg": "Are you sure you want to retract this offer?",
      "proposedOffer": "Proposed Offer: ",
      "allWell": "All is going well?",
      "proposeOffer": "Propose Offer?",
      "liveLocation": "Live Location",
      "estimatedPrice": "Estimated Price",
      "priceOfferMsg":
          "Once customer accepts your price offer, you will be assigned the job",
      "initialOffer": "Initial Offer",
      "sendOffer": "Send Offer",
      "attachments": "Attachments",
      "rejectInvitationHeader": "Reject Invitation",
      "rejectInvitationMsg": "Are you sure you want to reject this invitation?",
      "reject": "Reject",
      "accept": "Accept",
      "customerDetails": "Customer Details",
      "problemDetails": "Problem Details",
      "contact": "Contact",
      "typeYourMessage": "Type message",
      "imageLoading": "Sending Image ...",
      "cantUpdateVisit": "Couldn't update visit",
      "selectWorkersError": "You have to select workers",
      "selectWorkers": "Select Workers",
      "setVisitDate": "Set Visit Date",
      "selectDateError": "You have to choose a valid date",
      "activeVisit": "Active Visit",
      "noRole": "This User Doesn't have a Role Yet!",
      "errorOccured": "Error Occured",
      "cantGetWorkers": "Couldnt Get Available Workers",
      "Deutsche": "Deutsch",
      "English": "English",
      "changeLang": "Change Language",
      "register": "Register",
      "createAccount": "Create account to join SERCL",
      "signup": "Create Account",
      "agbRules": 'Agb Rules',
      "agreeError": "Agree to agb rules to submit profile",
      "agb": "AGB Rules",
      "agreeTo": "I agree to",
      "alreadyMember": "Already a member?",
      "login": "Login",
      "termsAndConditions": 'Terms and conditions',
      "terms": "conditions and the general terms and conditions",
      "acceptRules1": "I have read and accepted the above ",
      "acceptRules2": " for SERCL as well as the data protection regulations",
      "loginToSercl": "Login to your SERCL",
      "forgotPassword": "Forgot Password?",
      "noAccount": "Don't have account?",
      "password": "Password",
      "email": "Email",
      "enterEmail": "Enter your Email",
      "resetPassword": "Reset Password",
      "emailRequired": "Email Required",
      "passwordRequired": "Password Required",
      "passHint": "Must be 6 characters or longer",
      "confirmPassword": "Confirm Password",
      "invalidEmail": "This Email is invalid",
      "invalidPassword": "Password must be 8 characters or longer",
      "passwordDontMatch": "Passwords don't match",
      "checkEmail": "please Check your Email",
      "resetDone": "Rassword Reset Done",
      "signupSuccess":
          "Signed up successfully, please check your email for confirmation meessage",
      "success": "Success",
      "enterNewPassword": "Enter new password",
      "passwordChangeSuccess": "Password Changed Successfully",
      "profileNotFound":
          "Your profile has been deleted please contact your service provider for more information",
      "companyInfo": "Company Info",
      "companyName": "Company Name",
      "companyNameHint": "Example Group",
      "companyBio": "Bio",
      "companyBioHint":
          "Tell us how can customers benefit from your services and how do you stand out?",
      "addImages": "Add Images (Optional, Max. 4)",
      "saveAndContinue": "Save and Continue",
      "legalDocuments": "Legal Documents",
      "businessCertificate": "Business Certificate",
      "insurance": "Insurance",
      "contract": "Contract",
      "areas": "Areas",
      "area": "Area",
      "from": "From",
      "invalidFromTo": "Invalid areas",
      "to": "To",
      "myCodes": "My Codes",
      "noAreas": "You haven't added any areas",
      "forServiceProviders": "for service providers",
      "nameLogoBio": "Name, Logo and Bio",
      "areasSub": "Areas you operate in",
      "invalidAreas": "Should be 5 digits",
      "outOfOrderAreas":
          "The smaller code area should come first. Try to swap them",
      "services": "Services",
      "servicesSub": "Services you provide",
      "billingInfoTitle": "Billing Info",
      "billingInfoSubtitle": "To receive payments from customers",
      "streetName": "Street Name",
      "streetNameRequired": "Street Name required",
      "streetNumber": "Street Number",
      "streetNumberRequired": "Street Number required",
      "postalCode": "Postal Code",
      "postalCodeRequired": "Postal Code required",
      "city": "City",
      "cityRequired": "City required",
      "companyPhoneNumber": "Company Phone Number",
      "companyPhoneNumberRequired": "Company Phone Number required",
      "iban": "IBAN",
      "ibanRequired": "IBAN required",
      "bic": "BIC",
      "bicRequired": "BIC required",
      "address": "Address",
      "phoneNumber": "Phone Number",
      "accountInfo": "Account Info",
      "legalDocumentsSub": "Optional",
      "fromHint": "EX:80331",
      "toHint": "EX:81929",
      "pending": "Pending Verification",
      "pleaseWait": "Please wait while our admin verify your data",
      "areasSuccess": "Areas Updated",
      "fromRequired": "From is required",
      "toRequired": "To is required",
      "areasRequired": "Add at least 1 area",
      "invalidCharacters": "Invalid Characters",
      "removeImage": "Remove Image",
      "companyInfoSuccess": "Company Info Updated",
      "companyNameRequired": "Company Name is required",
      "legalSuccess": "Legal Documents Updated",
      "uploadFile": "Upload File",
      "removeFile": "Remove File",
      "editFile": "Edit File",
      "companyBioRequired": "Company Bio is required",
      "companyLogo": "Company Logo (optional)",
      "editImage": "Edit Image",
      "notes": "Notes",
      "note": "Note",
      "logout": "Logout",
      "submitForReview": "Submit for Review",
      "gotNotes": "You've got feedback notes",
      "viewNotes": "View Notes",
      "refresh": "Refresh",
      "servicesSuccess": "Services Updated",
      "servicesRequired": "Select at least 1 service",
      "remove": "remove",
      "selectFile": "Select File",
      "settings": "Settings",
      "profile": "Profile",
      "adminPanel": "Go to Admin Panel",
      "showMore": "Show More",
      "showLess": "Show Less",
      "createVisit": "Create Visit",
      "greatProgress": "Great Progress!",
      "noProblem": "No Problem!",
      "visitDeletedMsg": "You removed assigned workers",
      "workersAssignedMsg": "You assigned workers to the job",
      "selfAssignedMsg": "You assigned yourself to the job",
      "creatingVisit": "Assigning Workers ...",
      "addVisit": "Add Visit",
      "appointment": "Appointment",
      "avWorkers": "Available Workers",
      "available": "Available",
      "unavailable": "Unavailable",
      "unavWorkers": "Unavailable Workers",
      "submitVisit": "Submit Visit",
      "select": "Select",
      "selected": "Selected",
      "setDate": "Set Date",
      "date": "Date",
      "time": "Time",
      "details": "Details",
      "visits": "Visits",
      "files": "Files",
      "deleteVisit": "Delete Visit",
      "deleteVisitMsg": "Are you sure you want to delete this visit?",
      "cancel": "Cancel",
      "delete": "Delete",
      "filters": "Filters",
      "categories": "Categories",
      "applyFilters": "Apply Filters",
      "clear": "Clear",
      "zip": "Zip Code",
      "s_pending": "Pending",
      "s_rejected": "Rejected",
      "s_accepted": "Accepted",
      "s_inProgress": "In Progress",
      "s_complete": "Complete",
      "s_completed": "Completed",
      "invitationRejected": "Invitation Rejected",
      "s_paid": "Paid",
      "receipt": "Receipt",
      "deleteReceipt": "Delete Receipt",
      "deleteReceiptMsg": "Are you sure you want to delete this receipt?",
      "s_open": "open",
      "s_onhisway": "on his way",
      "s_working": "WORKING",
      "s_done": "DONE",
      "assignments": "Assignments",
      "openAssignments": "Open Assignments",
      "invitations": "Invitations",
      "searchByCustomerName": "Search by customer name",
      "currentPassword": "Current Password",
      "newPassword": "New password",
      "confirmNewPassword": "Confirm new password",
      "progress": "Progress",
      "noWorkers": 'No Workers',
      "noWorkersMessage": 'There are no workers available in this period',
      "gotIt": "Got It",
      "workerHelp":
          "Indicates that the worker hasn't logged in into his account yet",
      "nameRequired": "Name Required",
      "invalidInput": "Invalid Input",
      "name": "Name",
      "status": "Status",
      "changedStatusTo": "changed status to",
      "noVisits": 'No Visits',
      "upload": "Upload",
      "receivedPayment": "Did you receive payment?",
      "setPaid": "Set as paid",
      "setPaidMsg": "Are you sure you want to set this order status to paid?",
      "noScheduledVisits": "There's no scheduled visits for this order",
      "conflicts": "Conflicts",
      "conflictingVisits": "Conflicting Visits",
      "updateStatus": "Update Status",
      "updateStatusBody": "Are you sure you want to change status to",
      "yes": "Yes",
      "open": "Open",
      "onTheWay": "On The Way",
      "startedWorking": "Started Working",
      "done": "Done",
      "editSchedule": "Edit Schedule",
      "changePassword": "Change Password",
      "next": "Next",
      "schedule": "Schedule",
      "account": "Account",
      "day": "Day",
      "worker": "Worker",
      "sunday": "Sunday",
      "monday": "Monday",
      "tuesday": "Tuesday",
      "wednesday": "Wednesday",
      "thursday": "Thursday",
      "friday": "Friday",
      "saturday": "Saturday",
      "workerName": "Worker Name",
      "workerEmail": "Worker Email",
      "workers": "Workers",
      "addWorkers": "Add Workers",
      "editWorker": "Edit Worker",
      "standardSchedule": "Standard Schedule",
      "standard": "Standard",
      "custom": "Custom",
      "customSchedule": "Custom Schedule",
      "standardTime": "(08:00 - 18:00 Monday to Friday)",
      "fullSchedule": "Standard (8:00 - 18:00 Monday to Friday)",
      "noWorkersYet": 'Add Workers to be able to assign them to visits',
      "noAssignments": 'No assignments yet',
      "completedJobs": 'Completed Jobs',
      "history": 'History',
      "deleteTech": "Delete Worker",
      "deleteTechMsg": "Are you sure you want to delete?",
      "chats": "Chats",
      "noInvitations": "No Invitations",
      "noInvitationsMsg": "You haven't received any invitations yet",
      "noChats": "No Chats",
      "noChatsMsg": "Accept Invitations to start chatting with customers",
      "noWork": "Nothing to do",
      "noWorkMsg": "You don't have any assignments",
      "noReviewes": "No Reviews",
      "visitDate": "Visit Date",
      "noReviewesMsg": "Complete jobs to get reviews",
      "requestDetails": "Request details",
      "block": "Block",
      "payment": "Payment",
      "complain": "Complain",
      "blockWarning": "**Note: You'll not be able to undo this action",
      "blockUser": "Are you sure you want to block",
      "cannotSendMessage_unavailable":
          "This chat is closed",
      "cannotSendMessage_closed": "This chat is closed",
      "cannotSendMessage_cancelled":
          "This chat is closed",
      "workersCountError":
          "You should assign at least one worker for this order",
      "doneNavigating": "Done Navigating",
      "arrived": "Started working",
      "onWay": "Are you on your way?",
      "notify": "Notify",
      "workerOnWay": "Worker is on the way",
      "workerArrived": "Started working",
      "workerDoneWorking": "I'm done working",
      "offer": "Offer",
      "sorry": "Sorry!",
      "congratulations": "Congratulations!",
      "offerdMsg": "You Proposed an offer to do the job for ",
      "rejectMsg":
          "Your price offer is rejected, make sure to negotiate before offering another price",
      "acceptedMsg": "Your price offer is accepted, you're all set to work",
      "assignMySelf": "Assign Myself",
      "selfAssignDialog":
          "By clicking on confirm you will be assigned to this visit",
      "complainHeader": "Tell us what went wrong",
      "weGotComplain": "We got your complain",
      "complainContact": "SERCL team will contact you soon",
      "complainRequired": "Complain body is required",
      "workLog": "Work Log",
      "assignedWorkers": "Assigned Workers: ",
      "started": "Started: ",
      "finished": "Finished: ",
      "enjoyedWorking": "Enjoyed working with us?",
      "rateExperience": "How do you rate your experience?",
      "info": "Info",
      "reviews": "Reviews",
      "greatJob": "Great Job",
      "thanks": "Thank you!",
      "rate": "Rate",
      "assignmentDone": "Assignment Completed",
    },
    AppStrings.de_code: {
      "taxIdRequired":"Umsatzsteuer-ID oder Steuernummer erforderlich",
      "taxId": "Umsatzsteuer-ID oder Steuernummer",
      "taxIdSubtitle": "(für Kleingewerben nicht erforderlich)",
      "readyText": "Ab in die Arbeit?",
      "workersAssigned": "Workers Assigned to the job",
      "generatedBill": "Rechnung",
      "uploadedDoc": "Dokumente",
      "cash": "Barzahlung",
      "send": "Senden",
      "gallery": "Gallerie",
      "camera": "Kamera",
      "initialPrice": "Kostenvoranschlag",
      "giveRating": "Bewertung abgeben",
      "getDirections": "Navigation starten",
      "assignedSelf": "Aktivitäten starten",
      "edit": "Editieren",
      "viewWorkerLoc": "Standort verfolgen",
      "youAssigned": "Zugewiesen an",
      "submitting": "Wird versendet...",
      "archive": "Archiv",
      "deleteBillDesc":
          "Solange die Rechnung noch nicht erstellt ist, können Sie die Anfrage löschen und eine neue verschicken",
      "amazon_pay": "Amazon Pay",
      "bank_transfer": "Klarna",
      "cash_on_delivery": "Bargeld",
      "customerSetPayment": "Kunde hat folgende Zahlungsart ausgewählt:",
      "assignedOn": "Zugewiesen an",
      "genRate": "Allgemeine Bewertung",
      "notInterested": "Nicht interessiert?",
      "euro": "Euro",
      "priceRate": "Preisbewertung",
      "ratedYou": "Bewertung erhalten",
      "youRated": "Bewertung abgegeben",
      "rating": "Bewertung",
      "gotPaid": "Rechnung bezahlt",
      "err_fileOrDesc": "Bitte mindestens ein Dokument oder Kommentar anhängen",
      "s_bill_pending": "Rechnung ausstehend",
      "s_waiting_payment": "Rechnung wird erstellt",
      "s_created": "Erstellt",
      "deleteBill": "Rechnung löschen",
      "sureDeleteBill": "Sie wollen wirklich mit dem Löschen fortfahren?",
      "cantUndoAction":
          "**Hinweis: Sie werden diese Aktivität nicht widerrufen können",
      "submit": "Einreichen",
      "billDocument": "Falls Materialien für den Auftrag gekauft worden sind, bitte Belege fotografieren und foto hier  hochladen",
      "addNewBill": "Rechnung anfordern",
      "managePayment": "Zahlung verwalten",
      "paymentMethod": "Zahlungsart",
      "selectedPaymentMethod": "Bezahlungsart: ",
      "billDate": "Rechnungsdatum",
      "description": "Beschreibung",
      "descriptionText": "Alle benötigten Informationen zur Erstellung der Rechnung hinzufügen (durchgeführte Arbeiten, Arbeitszeitien, Henweise für Belege, ...)",
      "myBills": "Meine Rechnungen",
      "requestNewBill": "Neue Rechnung anfordern",
      "requestBill": "Rechnung anfordern",
      "addBills": "Rechnung anfordern, um die Bezahlung anzustoßen",
      "noBills": "Keine Rechnungen",
      "updatingVisit": "Besuch wird aktualisiert..",
      "emailRegistered": "Diese Emailadresse ist bereits vergeben",
      "editVisit": "Besuch aktualisieren",
      "saveChanges": "Änderungen speichern",
      "s_unavailable": "Nicht verfügbar",
      "s_cancelled": "Abgebrochen",
      "s_closed": "Abgeschlossen",
      "priceRejected": "Angebot abgelehnt",
      "rateAdded": "Bewertung abgegeben",
      "invitationClosed": "Einladung geschlossen",
      "invitationDeleted": "Einladung gelöscht",
      "anotherOffer": "Kunde hat einem anderen Dienstanbieter zugesagt. Trotzdem danke und Sie erhalten bald neue Anfragen. Viel Erfolg!",
      "visitCreated": "Arbeit aufgenommen",
      "invitationCompleted": "Einladung abgeschlossen",
      "priceOffered": "Angebot abgegeben",
      "visitDeleted": "Arbeit geändert",
      "visitCompleted": "Arbeit abgeschlossen",
      "orderClosed": "Abgeschlossen",
      "navigationStarted": "Dienstleister auf dem Weg",
      "billCreated": "Rechnung erstellt",
      "billPaid": "Rechnung bezahlt",
      "priceRetracted": "Angebot zurückgezogen",
      "priceRetractedMsg": "Sie haben das Angebot zurückgezogen",
      "sendingPrice": "Angebot wird verschickt...",
      "retractingPrice": "Angebot wird zurückgezoben...",
      "loading": "Ladevorgang ...",
      "call": "ANRUFEN",
      "tasks": "Aufgaben",
      "task": "Aufgabe",
      "assignmentCompleted": "Auftrag erfolgreich abgeschlossen",
      "doneWorking": "Arbeit erledigt?",
      "doneWorkingMsg": "Teilen SIe dem Kunden mit, was Sie erledigt haben.",
      "initialOfferProposed": "Kostenvoranschlag",
      "emptyPrice": "Preis eingeben",
      "retract": "Zurückziehen",
      "retractOffer": "Angebot zurückziehen",
      "retractOfferMsg":
          "Sind Sie sicher, dass Sie das Angebot zurückziehen möchten?",
      "proposedOffer": "Ihr Angeobt: ",
      "allWell": "Alles gut gelaufen?",
      "proposeOffer": "Angebot abgeben?",
      "liveLocation": "Live-Standort",
      "initialOffer": "Kostenvoranschlag",
      "estimatedPrice": "Geschätzter Preis",
      "priceOfferMsg":
          "Sobald der Kunde das Angebot annimmt, erhält der Dienstleister den Auftrag automatisch",
      "sendOffer": "Angebot senden",
      "chats": "Chats",
      "noInvitations": "Keine Anfragen",
      "noInvitationsMsg": "Sie haben noch keine Anfragen erhalten",
      "noWork": "Keine Auträge",
      "noWorkMsg": "Sie haben keine Aufträge",
      "noReviewes": "Keine Rezensionen",
      "visitDate": "Termin",
      "noReviewesMsg": "Auftrag abschließen, um Bewertung zu erhalten",
      "noChats": "Keine Chats",
      "noChatsMsg": "Anfrage annehmen und Chat mit dem Kunden starten",
      "attachments": "Anhänge",
      "rejectInvitationHeader": "Anfrage ablehnen",
      "rejectInvitationMsg": "Bitte bestätigen Sie die Ablehnung der Anfrage",
      "problemDetails": "Mehr Details zur Anfrage",
      "reject": "Ablehnen",
      "accept": "Annehmen",
      "customerDetails": "Info vom Kunden",
      "contact": "Kontakt",
      "typeYourMessage": "Schreiben Sie Ihre Nachricht",
      "imageLoading": "Bild wird verschickt ...",
      "cantUpdateVisit": "Aktualisierung nicht möglich",
      "selectWorkersError": "Bitte Mitarbeiter selektieren",
      "selectWorkers": "Mitarbeiter selektieren",
      "setVisitDate": "Wählen Sie Beuchsdatum",
      "selectDateError": "Sie müssen ein gültiges Datum wählen",
      "activeVisit": "Termin",
      "noRole": "User noch nicht aktiv!",
      "errorOccured": "Fehler eingetreten",
      "cantGetWorkers": "Keine verfügbaren Mitarbeiter",
      "conflictingVisits": "Terminkonflikt",
      "conflicts": "Konflikt",
      "Deutsche": "Deutsch",
      "English": "English",
      "changeLang": "Sprache ändern",
      "register": "Registrieren",
      "createAccount": "Konto erstellen bei SERCL",
      "signup": "Konto erstellen",
      "agbRules": 'Hiermit bestätigen Sie unsere ',
      "agb": "AGBs",
      "agreeTo": "Hiermit bestätigen Sie unsere",
      "agreeError": "Bitte AGBs bestätigen, um fortzufahren",
      "alreadyMember": "Sie sind bereits registriert?",
      "login": "Login",
      "termsAndConditions": 'Bitte prüfen und bestätigen',
      "terms": 'genannten Konditionen und die allgemeinen Geschäftsbedingungen',
      "acceptRules1": "Ich habe die oben ",
      "acceptRules2":
          " für SERCL sowie die Datenschutzbestimmungen gelesen und bin damit einverstanden",
      "loginToSercl": "Ihr SERCL Konto",
      "forgotPassword": "Passwort vergessen?",
      "noAccount": "Sie haben noch kein Konto?",
      "password": "Passwort",
      "email": "Email",
      "enterEmail": "Email eingeben",
      "resetPassword": "Reset Passwort",
      "emailRequired": "Geben Sie hier Ihre Emailadresse ein",
      "passwordRequired": "Passwort bestätigen",
      "passHint": "Passwort (Mind. 8 Zeichen)",
      "confirmPassword": "Passwort bestätigen",
      "invalidEmail": "Falsche Email",
      "invalidPassword": "Geben Sie hier Ihr Passwort ein (Mind. 8 Zeichen)",
      "passwordDontMatch": "Falsches Passwort",
      "checkEmail": "Bitte prüfen Sie Ihre Email",
      "resetDone": "Passwort erfolgreich geändert",
      "signupSuccess":
          "Registrierung erfolgt. Bitte prüfen Sie Ihre Email und bestätigen die Registrierung",
      "success": "Danke!",
      "enterNewPassword": "Neues Passwort eingeben",
      "passwordChangeSuccess": "Passwort erfolgreich geändert",
      "profileNotFound": "Ihr Profil wurde gelöscht",
      "companyInfo": "Allgemeine Info",
      "name": "Name",
      "companyNameHint": "Mustername",
      "companyName": "Firmenname",
      "companyBio": "Was zeichnet mich aus?",
      "companyBioHint":
          "z.B. seit wann sind sie tätig? Ehrlichkeit und Zuverlässigkeit schätzen unsere Kunden",
      "saveAndContinue": "Speichern und fortfahren",
      "legalDocuments": "Wichtige Dokumente",
      "businessCertificate": "Gewerbeanmeldung",
      "insurance": "Wichtige Versicherung",
      "contract": "Wichtiges Dokument",
      "areas": "Gebiet",
      "area": "Gebiet",
      "from": "Von",
      "invalidFromTo": "Eingabe ungültig",
      "to": "Bis",
      "myCodes": "Mein Gebiet",
      "noAreas": "Sie haben noch keine hinzugefügt",
      "forServiceProviders": "Für Dienstleister",
      "nameLogoBio": "Name, Logo, Beschreibung",
      "areasSub": "Wo sind Sie tätig?",
      "invalidAreas": "5 Ziffern",
      "outOfOrderAreas":
          "Die kleinere Zahl soll zuerst eingegeben werden. Bitte Zahlen tauschen",
      "services": "Dienste",
      "servicesSub": "Welche Dienste bieten Sie an?",
      "billingInfoTitle": "Eingaben für Rechnung",
      "billingInfoSubtitle": "Wird für Zahlungen benötigt",
      "streetName": "Straßenname",
      "streetNameRequired": "Straßenname erforderlich",
      "streetNumber": "Straßennummer",
      "streetNumberRequired": "Straßennummer erforderlich",
      "postalCode": "PLZ",
      "postalCodeRequired": "PLZ erforderlich",
      "city": "Stadt",
      "cityRequired": "Stadt erforderlich",
      "companyPhoneNumber": "Telefonnummer",
      "companyPhoneNumberRequired": "Telefonnummer erforderlich",
      "iban": "IBAN Nummer",
      "ibanRequired": "IBAN erforderlich",
      "bic": "BIC Nummer",
      "bicRequired": "BIC erforderlich",
      "address": "Adresse",
      "phoneNumber": "Telefonnummer",
      "accountInfo": "Konto",
      "legalDocumentsSub": "Optional",
      "fromHint": "z.B. 80801",
      "toHint": "z.B. 80809",
      "pending": "Ihre Daten werden geprüft",
      "pleaseWait": "SERCL prüft Ihre Daten und meldet sich bald bei Ihnen",
      "areasSuccess": "PLZ aktualisiert",
      "fromRequired": "Von ist erforderlich",
      "toRequired": "Bis ist erforderlich",
      "areasRequired": "Mindestens eine PLZ hinzufügen",
      "invalidCharacters": "Ungültige Zeichen",
      "addImages": "Mehr Fotos (Optional, Max. 4)",
      "removeImage": "Bild löschen",
      "companyInfoSuccess": "Bild löschen",
      "companyNameRequired": "Firmenname erforderlich",
      "companyBioRequired": "Firmenprofil erforderlich",
      "uploadFile": "Datei Hochladen",
      "removeFile": "Datei entfernen",
      "editFile": "Datei editieren",
      "legalSuccess": "Dateien hinzugefügt",
      "companyLogo": "Firmenlogo/Bild (optional)",
      "editImage": "Bild editieren",
      "notes": "Hinweis",
      "note": "Hinweis",
      "logout": "Ausloggen",
      "submitForReview": "Zur Überprüfung einreichen",
      "gotNotes": "Nachricht erhalten",
      "viewNotes": "Nachricht öffnen",
      "refresh": "Aktualisieren",
      "servicesSuccess": "Dienste gespeichert",
      "servicesRequired": "Mindestens einen Dienst selektieren",
      "remove": "entfernen",
      "selectFile": "Datei durchsuchen",
      "settings": "Einstellungen",
      "profile": "Profil",
      "adminPanel": "Wechseln zu Admin Panel",
      "showMore": "Mehr anzeigen",
      "showLess": "Weniger anzeigen",
      "createVisit": "Besuch erstellen",
      "greatProgress": "Great Progress!",
      "noProblem": "Kein Problem!",
      "visitDeletedMsg": "Mitarbeiter entfernt",
      "workersAssignedMsg": "Mitarbeiter zugeordnet",
      "selfAssignedMsg": "Auftrage sich selbst zugeordnet",
      "creatingVisit": "Mitarbieter zuordnen ...",
      "addVisit": "Termin einstellen",
      "appointment": "Termin",
      "avWorkers": "Verfügbare Mitarbeiter",
      "available": "Verfügbar",
      "unavailable": "Nicht verfügbar",
      "unavWorkers": "Nicht Verfügbare Mitarbeiter",
      "submitVisit": "Termin speichern",
      "select": "Auswählen",
      "selected": "Selektiert",
      "setDate": "Zeit auswählen",
      "date": "Datum",
      "time": "Zeit",
      "details": "Details",
      "visits": "Termine",
      "files": "Datein",
      "deleteVisit": "Termin löschen",
      "deleteVisitMsg": "Wollen Sie wirklich mit der Änderung fortfahren?",
      "cancel": "Abbrechen",
      "delete": "Löschen",
      "filters": "Filters",
      "categories": "Kategorien",
      "applyFilters": "Filter speichern",
      "clear": "Deselektieren",
      "zip": "PLZ",
      "s_pending": "Ausstehend",
      "s_rejected": "Abgelehnt",
      "s_accepted": "Angenommen",
      "s_inProgress": "In Arbeit",
      "s_complete": "Abgeschlossen",
      "s_completed": "Abgeschlossen",
      "invitationRejected": "Einladung abgelehnt",
      "s_paid": "Bezahlt",
      "receipt": "Rechnung",
      "deleteReceipt": "Rechnung löschen",
      "deleteReceiptMsg": "Wollen Sie wirklich die Rechnung löschen?",
      "s_open": "Öffnen",
      "s_onhisway": "Auf dem Weg",
      "s_working": "In Arbeit",
      "s_done": "Abgeschlossen",
      "assignments": "Aufträge",
      "openAssignments": "Offene Aufträge",
      "invitations": "Anfragen",
      "searchByCustomerName": "Kundenname suchen",
      "currentPassword": "Aktuelles Passwort",
      "newPassword": "Neues Passwort",
      "confirmNewPassword": "Neues Passwort bestätigen",
      "progress": "In Arbeit",
      "noWorkers": 'Keine Mitarbeiter',
      "noWorkersMessage": 'Keine Mitarbeiter verfügbar im Zeitraum',
      "gotIt": "Verstanden",
      "workerHelp": "Zeigt, dass der Mitarbeiter noch nicht eingeloggt ist",
      "nameRequired": "Name erforderlich",
      "invalidInput": "Eingabe ungügltig",
      "status": "Status",
      "changedStatusTo": "Statusänderung zu",
      "noVisits": 'Keine Termine',
      "upload": "Hochladen",
      "receivedPayment": "Haben Sie die Zahlung erhalten?",
      "setPaid": "Als bezahlt markieren",
      "setPaidMsg": "Wollen Sie wirklich auf 'Bezahlt' ändern?",
      "noScheduledVisits": "Noch keine Termine für diesen Auftrag vorhanden",
      "updateStatus": "Statusupdate",
      "updateStatusBody": "Statusänderung bestätigen zu",
      "yes": "Ja",
      "open": "Öffnen",
      "onTheWay": "Auf dem Weg",
      "startedWorking": "In Arbeit",
      "done": "Abgeschlossen",
      "editSchedule": "ARBEITSZEIT EDITIEREN",
      "changePassword": "Passwort ändern",
      "next": "Nächster",
      "schedule": "Fortschritt",
      "account": "Profil",
      "day": "Tag",
      "worker": "Arbeiter",
      "sunday": "Sonntag",
      "monday": "Montag",
      "tuesday": "Dienstag",
      "wednesday": "Mittwoch",
      "thursday": "Donnerstag",
      "friday": "Freitag",
      "saturday": "Samstag",
      "workerName": "Mitarbeitername",
      "workerEmail": "Mitarbeiter Email",
      "workers": "Mitarbeiter",
      "addWorkers": "Mitarbeiter hinzufügen",
      "editWorker": "Mitarbeiter editieren",
      "standardSchedule": "Standard Arbeitszeit",
      "standard": "Standard",
      "custom": "Individuell",
      "customSchedule": "Individuelle Arbeitszeit",
      "standardTime": "(08:00 – 18:00 Uhr Montag bis Feitag)",
      "fullSchedule": "Standard (08:00 – 18:00 Uhr Montag bis Feitag)",
      "noWorkersYet": 'Mitarbeiter hinzufügen, um sie den Terminen zuzuweisen',
      "noAssignments": 'Keine Aufträge',
      "completedJobs": 'Auftrag abschließen',
      "history": 'Historie',
      "deleteTech": "Mitarbeiter löschen",
      "deleteTechMsg": "Wollen Sie wirklich löschen?",
      "requestDetails": "Anfragen-Details",
      "block": "Ablehnen",
      "payment": "Zahlung",
      "complain": "Beschwerde",
      "blockUser": "Wollen Sie wirklich mit der Aktion fortfahren?",
      "blockWarning": "**Hinweis: Diese Aktion können Sie nicht widerrufen",
      "cannotSendMessage_unavailable":
          "Dieser Chat ist geschlossen",
      "cannotSendMessage_closed": "Dieser Chat ist geschlossen",
      "cannotSendMessage_cancelled":
          "Dieser Chat ist geschlossen",
      "workersCountError":
          "Sie müssen mindestens einen Mitarbeiter dem Auftrag zuweisen",
      "doneNavigating": "Navigieren beendet",
      "arrived": "Arbeit gestartet",
      "onWay": "Sind Sie schon unterwegs?",
      "notify": "Mitteilung senden",
      "workerOnWay": "Dienstleister schon auf dem Weg",
      "workerArrived": "Arbeit gestartet",
      "workerDoneWorking": "Arbeit abgeschlossen",
      "offer": "Angebot",
      "sorry": "Sorry!",
      "congratulations": "Gratuliere!",
      "offerdMsg": "Sie haben ein Angebot gesendet",
      "rejectMsg":
          "Angebot abgelehnt. Bitte offene Punkte klären und neues Angebot senden",
      "acceptedMsg": "Ihr Angebot wurde angenommen. Sie können schon loslegen",
      "assignMySelf": "Aktiv werden",
      "selfAssignDialog":
          "By clicking on confirm you will be assigned to this visit",
      "complainHeader": "Sagen Sie un, was schief gelaufen ist",
      "weGotComplain": "Wir haben Ihre Beschwerde erhalten",
      "complainContact":
          "Wir nehmen Ihre Beschwerde sehr ernst. SERCL Team wird Sie kontaktieren",
      "complainRequired": "Beschreibung erforderlich",
      "workLog": "Arbeitsfortschritt",
      "assignedWorkers": "Zugewiesene Mitarbeiter: ",
      "started": "Arbeit gestartet: ",
      "finished": "Arbeit abgeschlossen: ",
      "enjoyedWorking": "Sind Sie mit uns zufrieden?",
      "rateExperience": "Wie würden Sie Ihre Erfahrung mit uns bewerten?",
      "info": "Info",
      "reviews": "Rezensionen",
      "mySelf": "Mich Selbst",
      "no": "Nein",
      "smallCompany": "Kleingewerbe",
      "greatJob": "Großartige Arbeit",
      "thanks": "Vielen Dank!",
      "rate": "Bewerten",
      "assignmentDone": "Auftrag abgeschlossen",
    }
  };

  static String get Deutsche => _sMap[currentCode]["Deutsche"];
  static const String en_code = "en";
  static const String de_code = "de";

  static void setCurrentLocal(String code) {
    if (code == currentCode) return;
    currentCode = code;
    if (code != en_code && code != de_code) {
      currentCode = en_code;
    }
    langChangedSubject.sink.add(currentCode);
  }

  static printUnTranslatedString() {
    List<String> enKeys = _sMap[en_code].keys.toList();
    List<String> deKeys = _sMap[de_code].keys.toList();
    for (String key in enKeys) {
      if (!deKeys.contains(key)) {
        print("This Key is not Translated to German: $key");
      }
    }
  }
}
