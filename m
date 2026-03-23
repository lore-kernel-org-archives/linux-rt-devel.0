Received: from mx2.ferchau.com (smtp.ablegroup.de [212.211.156.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD383BB9FC
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Mar 2026 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=212.211.156.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282363; cv=fail; b=JR+HTZ69sRQJ+iFQDohUjj274ZyQV5yD7dWCfqiF+BvmhKNcRMV7+mPR3euUIThpTIMrOPEn39wz+MOfaZGxKvSSPsOGZfFimOcFBi+aBhddcVySRGt8cQ8HJPL/lB8dr2MgDZIqKZkmhlcqQD6iBy6zSr9efP4uEx6SXK7gPys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282363; c=relaxed/simple;
	bh=EEkDvwHX2cm6XF/P+QSNszSs543VmdF3SAFSTQ+yj/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jRPN75O3aYSeCu2AXqA+gC0/w9Oz+aE+BUnnE2SUK9RG9B5/YLe9A84XOsbCeor1/Y8z8VHNdOb147XYYG9EG0gFtTu2UUV4/yqzCwd83ePPBrh6ohBR4KX9YMmFEaetxzAQnaEzujOyeXsINDTyKVHyIFUrf6NCb3hIyF9Q0gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ferchau.com; spf=pass smtp.mailfrom=ferchau.com; dkim=pass (2048-bit key) header.d=ferchau.com header.i=@ferchau.com header.b=mdNKuapt; dkim=pass (1024-bit key) header.d=ablegroupde.onmicrosoft.com header.i=@ablegroupde.onmicrosoft.com header.b=QjRuVOEn; arc=fail smtp.client-ip=212.211.156.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ferchau.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferchau.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferchau.com header.i=@ferchau.com header.b="mdNKuapt";
	dkim=pass (1024-bit key) header.d=ablegroupde.onmicrosoft.com header.i=@ablegroupde.onmicrosoft.com header.b="QjRuVOEn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ferchau.com; i=@ferchau.com; q=dns/txt; s=s2048;
  t=1774282360; x=1805818360;
  h=arc-seal:arc-message-signature:
   arc-authentication-results:dkim-signature:from:to:cc:
   subject:thread-topic:thread-index:date:message-id:
   references:in-reply-to:accept-language:content-language:
   x-ms-has-attach:x-ms-tnef-correlator:msip_labels:
   authentication-results:x-ms-publictraffictype:
   x-ms-traffictypediagnostic:
   x-ms-office365-filtering-correlation-id:
   x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
   x-microsoft-antispam:x-microsoft-antispam-message-info:
   x-forefront-antispam-report:
   x-ms-exchange-antispam-messagedata-chunkcount:
   x-ms-exchange-antispam-messagedata-0:content-type:
   content-transfer-encoding:mime-version:
   x-exchange-routingpolicychecked:
   x-ms-exchange-crosstenant-authas:
   x-ms-exchange-crosstenant-authsource:
   x-ms-exchange-crosstenant-network-message-id:
   x-ms-exchange-crosstenant-originalarrivaltime:
   x-ms-exchange-crosstenant-fromentityheader:
   x-ms-exchange-crosstenant-id:
   x-ms-exchange-crosstenant-mailboxtype:
   x-ms-exchange-crosstenant-userprincipalname:
   x-ms-exchange-transport-crosstenantheadersstamped:
   x-cse-connectionguid:x-cse-msgguid:ironport-data:
   ironport-hdrordr:x-talos-cuid:x-talos-muid:x-ironport-av;
  bh=wljDe2WjK5O3VYv2jdgK+KMSpXoiI0gMTGNnTVfKTVM=;
  b=mdNKuaptod7Xh/PT5r4CLocFMo92Oc65AKe+Yd+ehWcOcRQBIUw1ZTRN
   jfHtJ+0Qjg1x0sgk9f/7g124WPyCD+KVWY1pRPDSEJKx4nf8/HMdPq/n9
   HrswhWkoSdiPDL+C0aM8sVm5aLN05Xk81nAMEAak5kj8KgrNSinhSf8sZ
   pVxJ1tcjBK27AQcLChb02j+YRaer+djNhBDY2ZZaU1QdgmsX799zdvfum
   CKVilXtS7ANtFxtMl7IXimnYP+VQAV9VsfWVxMqW3m/mFIGUJTu72wSGw
   vZF04dtXAHdfnUFTdOYh4O44IG5iSYgVNhcXjfl5CUM2WfDCLdAOUwHdm
   w==;
X-CSE-ConnectionGUID: 6Ff+ZS3EQweGxY7Vqhhq3g==
X-CSE-MsgGUID: SAevIrO8QDm9bAHKqrzH4A==
IronPort-Data: A9a23:fHXjFKPvHHOR0bDvrR2XlsFynXyQoLVcMsEvi/4bfWQNrUp3gWMDm
 mBLXGCHaK2JZGr1f9lxbIvi8UkA75PdyIAyGQZtpSBmQkwRpJueD7x1DKtQ0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOSn9SAivU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRWmthg
 vus5ZeEULOZ82QsaDxMsPjY8EoHUMna41v0gHRvPZing3eDzxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw60c+VZk
 72hg3AQpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDkkQ2
 /JbGgtWQymcis2m8e2FU+lsn58seZyD0IM34hmMzBn2KMQcc73zG/2To/FVxjwwj90IGfHVb
 s5xhThHNUyGOkUXfApLTstWcOSA3xETdxV9r0iUubhxwGzayQl13aLFPtfPcdyDWINemUPwS
 mfupjugXU5Lb7RzzxK+23+yp/XozRrXXdMYPZ2b7+R4oAG6kzl75Bo+EAHTTeOColKxX8J3K
 EEO/Ccq668o+ySDVtThUgeqiH+CsAQVV9dZH6s98g7l4q7V5RuJQ3IYCzJMdtEinMs3XiAxk
 FuImc75QzBirtW9TXOb66fRrj6oPyURBXENaDVCTgYf5dTn5oYpgXrnRNdsHaeun/XxGDft3
 yqNqikuwbke5fPnzI20+ELdkT+8/sCQCAA4/A7XV3/j6gRybYrNi5GU1GU3JM1odO6xJmRtd
 lBd8yRCxIji1a2wqRE=
IronPort-HdrOrdr: A9a23:M1u3R6PK8SftUcBcT5H255DYdb4zR+YMi2TDiHofdfUFSKClfp
 6V8cjzjSWE9Qr4WBkb6LW90dq7MA/hHPlOkMUs1NaZLUTbUQ6TQr2KgrGSugEIdxeOldK1kJ
 0QCZSWa+eAQmSS7/yKmDVQeuxIqLLskcCVbKXlvgxQpGlRGvldBmxCe2Km+zhNNW977O0CZf
 2hD6R81lidUEVSQtWwB3EDUeSGnNvWiZLgbycBAh4s+COOgTmr5LOSKWnX4j4uFxd0hZsy+2
 nMlAL0oo+5teug9xPa32jPq7xLhdrI0LJ4dY2xo/lQDg+pphejZYxnVbHHlisyuvuT5FEjl8
 SJiws8Pv5092jacgiO0FvQMkjboXUTAk3ZuBqlaEjY0IjErfUBeo18bLdiA1nkAowbzZdBOe
 xwrjukXtFsfGz9dWzGlqb1vlhR5zqJSXZOq59js1VPFYQZc7NftooZ4QdcF4oBBjvz7MQ9HP
 BpF9y03ocfTbq2VQGugoBU+q3kYl0jWhOdBkQSsM2c1DZb2Hh/0ksD3cQa2nMN7og0RZVI7/
 nNdv0ArsAFcuYGKaZmQOsRS8q+DWLABRrKLWKJOFziUKUKIWjEpZL76Kg8oOuqZJsLxp0vn4
 mpaiISiUciP0b1TcGe1pxC9R7ABG27QDT208lbo4N0v7XtLYCbRhFriGpe5/dIj89vd/EzAc
 zDS66+K8WTX1fTJQ==
X-Talos-CUID: 9a23:PSoncW9I62t1bjqw6nOVvxA6FIMXSSbw9WjdDF+JVlhwSL2MElDFrQ==
X-Talos-MUID: 9a23:/c66rgu0wY6O58v0ss2nvxhvKuZyxPSXJEVcm7wmmNCeJwwsEmLI
X-IronPort-AV: E=Sophos;i="6.23,137,1770591600"; 
   d="scan'208";a="1717793"
Received: from gmzrzex001.ferchau.local ([10.100.54.1])
  by mx2.ferchau.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:12:33 +0100
Received: from GMZRZEX001.Ferchau.local (10.100.54.1) by
 GMZRZEX001.Ferchau.local (10.100.54.1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Mar 2026 17:12:33 +0100
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.66) by
 exchange.ferchau.com (172.16.19.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Mar 2026 17:12:33 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9QYDQ5Q2PvNYz0Vo9asnZ3CVBYGhBqwgv6IBziDkqCY4NjsWT6UuRs4bmuM9kc087DYny+n9Y0WeXXzNKk5JGWKjbm8kzQE4mhKFoJOanvQaJ08/FXyT2GzR5UhYWU6PXZssWL0cKqNPuALdR4NChgB8cqt0CE91LfmHIoiPTQ673fWpk1d1hlq6vLTiZGQi7gK2n/mVfhiXK/z07zj90bEywusn1+IsPyfJ5VGNiEIxxuEZhq51wVVhnD6vYZSnxbAgTzTK9WTnww34zsmUyCJmtL0L6AO7SSAqp8qvom2QNPG//VgkD1N5ZQx9xUcoYaIixToUuYB7ugbTSU3+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wljDe2WjK5O3VYv2jdgK+KMSpXoiI0gMTGNnTVfKTVM=;
 b=OZitu6bkguJ77OUY6A/uDKEjSdWrOFw46iOZerd/kT1GLAuMW254oijyVMiVs7nFex4ESQ6DllJF83Pzen6MNelhW3b3etxR7fGyY12ujZvlNb4QhUp/DPEUW2hSuzkn4SPRK2nPnhKVvqqzQh9/brU86UYEDPV/8LFrm5kHVbUQQksVDfn4dh2Alj6zPKzZ7W/zAhYs+uoqGhawwtjE/N0x+xNIIGBYHKfTggsLgfkbHQ8qkNc63vUPYQ0pBko/F4NER+sf7K7sCO13V/iCooen0KKSFdJk65c+PDrvsl7384Oz3YVI91NXY8bhsatEfFr1onOVRJBHJfH/6dkDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ferchau.com; dmarc=pass action=none header.from=ferchau.com;
 dkim=pass header.d=ferchau.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ablegroupde.onmicrosoft.com; s=selector1-ablegroupde-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wljDe2WjK5O3VYv2jdgK+KMSpXoiI0gMTGNnTVfKTVM=;
 b=QjRuVOEncFS1TkIWfB8RKS+Cqwn0OpExMhMS1SmqnRU0ahoRFfCexjewSCEVKAkrDOY9isfN5i9p1ZBS0Dh29L8CsbUaTh+JMFKsnlZWFmZ9grdwv+ejBNU6puLZWEh3iNz2Vg3gw8pdAU+IwC/tuTWQ9lWC6I5fVsrXRCJnoO0=
Received: from PR3PR06MB6889.eurprd06.prod.outlook.com (2603:10a6:102:87::9)
 by PAWPR06MB8990.eurprd06.prod.outlook.com (2603:10a6:102:38f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 16:12:11 +0000
Received: from PR3PR06MB6889.eurprd06.prod.outlook.com
 ([fe80::7396:2256:3ddb:4637]) by PR3PR06MB6889.eurprd06.prod.outlook.com
 ([fe80::7396:2256:3ddb:4637%3]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 16:12:24 +0000
From: "Moritz KLAMMLER (FERCHAU)" <Moritz.Klammler@ferchau.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: Possible PREEMPT_RT live-lock / priority-inversion between
 FUTEX_CMP_REQUEUE_PI and FUTEX_WAIT_REQUEUE_PI
Thread-Topic: Possible PREEMPT_RT live-lock / priority-inversion between
 FUTEX_CMP_REQUEUE_PI and FUTEX_WAIT_REQUEUE_PI
Thread-Index: AQHcuJ4tKJIXTbtBj06xHcNQzZlKbLW8ITcAgAAnI8E=
Date: Mon, 23 Mar 2026 16:12:24 +0000
Message-ID: <PR3PR06MB68891F0E8CF17A4260D46EE8FF4BA@PR3PR06MB6889.eurprd06.prod.outlook.com>
References: <VE1PR06MB6894BE61C173D802365BE19DFF4CA@VE1PR06MB6894.eurprd06.prod.outlook.com>
 <20260323133034.vk87xPj9@linutronix.de>
In-Reply-To: <20260323133034.vk87xPj9@linutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ferchau.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR06MB6889:EE_|PAWPR06MB8990:EE_
x-ms-office365-filtering-correlation-id: 505ebdf3-3fbc-460c-d6fe-08de88f6f834
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 2G1aR5bGeUBmJthRPguTM7qzvdhr7hKYev42s18YFu/9Qa0fMyVblLbsSfdVKbdBD0bLmNrXG6aL9AmenRJMtAiCmDvUMLDnLUzL9p2ebbbnOJPNbnHnhL39P6FRr37itljh4XdF2ogvguozljeGFDKRP71uwDtJ+Z96QuorUBjKT78mt0kUYjMDJhbmlNtzp8fuS8KSVoOLBMX8rM432tqM5e6mD1D60Xmu4tNnj44b2l97kIlvylco3dYjFQfB5icf0HYJGZXqRgX7DV0tMCzx5+UbI/uU2rfqwz5bErPrKF6hNPaCopujoayZcCaMfsWyAN1CgOj/9VHk9xwv7Vfn0IGEKvnkl490oNpHA+wxgByxz6G6c99VEuUMe87t3dZZCAt44hDsysVbB62iy6BnceS2YCCaUe1qx9Qt6WWHTMi7XTIl8mlamvZtIBbNx1yOjb1dAS3ER7BEJTQ9sadGHRFa347QYugdzjzQPgCwF3JS37D/E+Gf92CYC6qWhH9PoHjB87n394NtRwQNS0n8m+owMdYD695Fp7AVXVUZWYH+ulOhzu+0dEtaR8z5YtYLXseXBivw69RzohoCd/jambrdANjllvNa4Uq13R9h+yLxHFPKDOLc2r37ygEyNzd7oekMUydDH3iTodqU8H3CHDMK2N3vleo9dB/Y7yJoPwPeNeO+JuXgg8bHtFPr2EQZCOBGOoCVjO9QUC7eLjykCZtu0n2bDYyAMXxmFS5ZWyM2fDbNlXWqMSH/6ghMnF7bArNOCeRppqcwU6PwPBzfiBm+HLO/kKzO/aIXJYI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR06MB6889.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-9?Q?okGo90omFR0upmlcKHavkabGLvndAoYAt2XKFC4hUUzWh2av5K16wjtONX?=
 =?iso-8859-9?Q?FSbUDQ12xqXdZhBTvooxZcY4PaAYr/NlcdgtIpyhc4ltsYcgX136Zoipb2?=
 =?iso-8859-9?Q?g+pR3S6/il/vLcpfYwEcwh2aw1hRp4tlZhMhFDBkz6RmoNAsR17maAWOFq?=
 =?iso-8859-9?Q?WJqxICpRVUiDu+KZ0PfZxx4ABgIZBouBOp3xQJq8OjywnUpV5L54+rMxJA?=
 =?iso-8859-9?Q?VCsvPvi0GIS25GgMGfE/SoptlnAc9OYraau6o8W6QP+mFg4+nJwC5yTzh4?=
 =?iso-8859-9?Q?3zUM+yTAtO1d97eg0X6fylSNBx2EqJknxa5V3BhuwubfDeR+/vDzTzjIOh?=
 =?iso-8859-9?Q?4QrFsJ8mOyZ0vD3yoQRwEAU4DS5M2Gdwmls2rDKSM7Q2a+IbxAkS4oXbdn?=
 =?iso-8859-9?Q?16GE2iXLFJeWszc6ZRMz+Ic7Bi5F3cuQhSSqlMvlaQuB4ulzZYoLmJX9Jo?=
 =?iso-8859-9?Q?PTmlNRykEJRDl/49ccyNOx1SpTBMCTCVWabvrcS5/F8z9kFSTts/+Fa5IE?=
 =?iso-8859-9?Q?8sxdEp2Z38nydNiKLP2X2V0yVfpc5XO+hzKy3Pb301XBc4p5p8Dy09Xc7q?=
 =?iso-8859-9?Q?yXffOdj6ImZFm/LZScRPnXIAaF7UDVpSkGipm+rMBkhzh9j6hXRHroP+mv?=
 =?iso-8859-9?Q?BxmhUxkiSzo/HEFEbwlxCQft1TEOoNwa0VSVK8qrUtZ7Yasz1AYt8gmxrw?=
 =?iso-8859-9?Q?nSZ8z/xl4gpGAq6RxiSzY30fxINN/n4sip6KD8H8LnZW94/PBz+y2xs5+L?=
 =?iso-8859-9?Q?QNdcBT0guv1iyr2A0kZR8J/HseCP2T2x2D2sO06LIgRBY7yuKImd4t6Pzo?=
 =?iso-8859-9?Q?/mIJ4HPxDuzXXNy5vMp+Zr7oFymKr74GYSOJGq9cc05d31Ob9rrOKbpUIG?=
 =?iso-8859-9?Q?XbLilZ1lTgcoyZBSnCZlYhLLe9mfRRJR5qq6lzMohe50nIsh1z9JtvzzWX?=
 =?iso-8859-9?Q?iElAc06EcezZaAl4jXZ9Z3yV3FAbrAwYtQB9revIW1hlWAUh+5WW8n3GI1?=
 =?iso-8859-9?Q?Yv7ZNR1AeN4stD/VAuSnHmhIRkhjIKOOQVCwXeDnCSG9++N/NwutG71Gkl?=
 =?iso-8859-9?Q?Xrghbz5uP2Rm+GjmnRTDdAYsoMsvcASNq84SYqFg5NRAe+TH4FAoqD/2Hu?=
 =?iso-8859-9?Q?mUQdpZwYpxvqXG72vsaEI2Uv5VtMC9YTq1YoPLf41Zd8jEzxoH/4Xy7R1X?=
 =?iso-8859-9?Q?swSw3kg8j1bcixqz4+QkiQZBRJAdoZWGAbSs28Nv0H+G3/UHdMM4BOcoYQ?=
 =?iso-8859-9?Q?aZfCQAbqKn9YlGynk4RF8qZh4ita7GafvPy7fe838GlAE99gXsXJsIZgja?=
 =?iso-8859-9?Q?Qf9GZbKq2O+2QKCOgtvv5F/Ctw5YzBDlOtxaYuX1a0zI+dRUEPCEmKBkLi?=
 =?iso-8859-9?Q?L4uDkx8v615wHHqbRKtNPJBMY3gF7OKW+1oUj6Es4V2E4QKge1zMIJzEjh?=
 =?iso-8859-9?Q?eKxn9sWN7JZUB1tWD2gE36ISWXsDBdwLvkd7+C9qi3M1fThbaC6dy23U3k?=
 =?iso-8859-9?Q?dd096lTqdOtKj3sg9+3eBNmgSjR6F4+HT4jQJUdf2MM88M0HJIPbeI6Eaq?=
 =?iso-8859-9?Q?pABOVhAI2f7AAHjzAcfyJXGP0IxVci/EYBrH+nUlzYIX8/BlktKuG2vxCc?=
 =?iso-8859-9?Q?NQzfvmGLITevIUn54AdTU3WBSkOJFfQoW3ckPGUAm9a3A1KvlDlUc4BsEu?=
 =?iso-8859-9?Q?nMmAGrleAcZJBMyFkmaqlltAkAKr46zjDxHUIxGkWuuv54EGWHivqK3v2b?=
 =?iso-8859-9?Q?onR+xvSPJnsLRqFvrbbgChjokDrX22BOSVAnySNhsMRV0E5/TofPWtH6UB?=
 =?iso-8859-9?Q?/jYIbpEF1w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KOAkVOJYxNQ9R0wxKyem+0ZAzx2/SeFaENkAUngXmw1bYL9xIywAcH7WN9H8aVdoggAnsWKeXtXjlY1lDsvplMVZoMiSEECQA8xklsSpv8VmEuQlfMFcR4oUvFDhY3QrXDvDK6oiD/KzRQbxv3NKcc/IsbK9e8l6Ok36O+K/glO8Wp5lKHW+Rv3+qzOwi9XycfM6uyWVj1tfR/zMektMGe1oLZRaKOiIegTOnBEynWnkVphgLbUZ5GA+8j/xvbvFQ+s4u9dJytcCEjcvqCEy+VQcz7nEiXRoZP8gL66CJ7cqpc/d/C0ZvRPUlEfqrow6qSjn5TkSlWiDuxA0b1v8uA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR06MB6889.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505ebdf3-3fbc-460c-d6fe-08de88f6f834
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 16:12:24.0121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9a3c2f68-d5b5-4769-b2f8-8d6fe142b164
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6DOyTx7i83TZ2JgSdQpfePU/NaTDoFLMOCQg95472cEzMHv88VwOJIDAdGX15FAxm/kIHn3MJtVB8aU0igAHLjZIhZj//76qPzJgQ1Th3fE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR06MB8990

Thanks for your quick and helpful response, Sebastian.

We have tried your patch and it indeed seems to solve the problem (using
the example program from my previous message as a test case).  It also
certainly is more elegant than any of the other options we've considered
so far.  Thank you very much.  I'll report back if our system test
should find any unexpected regression in the following days.

>> we're running Linux 6.6 with PREEMPT_RT on a single-core armv7l machine
> v6.6.109+?

Yes, 6.6.122 to be precise.

I've also compared the logic with newer kernel versions, but couldn't
identify any differences that seemed significant to me, with respect to
the logic in question.  I have to admit that I didn't actually /run/ the
test with any newer kernels, though.

> So the syscall, that saw Q_REQUEUE_PI_IGNORE, returned and now a second
> requeue-PI is attempted?

I /think/ that it's already the first syscall seeing the
Q_REQUEUE_PI_IGNORE that gets locked up.

Please excuse some bad copy pasta in my first message where at least
once I wrote Q_REQUEUE_PI_DONE instead of Q_REQUEUE_PI_IGNORE.  Sorry
for any confusion this might have caused.

________________________________________
Von: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Gesendet: Montag, 23. M=E4rz 2026 14:30
An: Moritz KLAMMLER (FERCHAU)
Cc: Thomas Gleixner; Peter Zijlstra; linux-rt-devel@lists.linux.dev; linux-=
kernel@vger.kernel.org
Betreff: Re: Possible PREEMPT_RT live-lock / priority-inversion between FUT=
EX_CMP_REQUEUE_PI and FUTEX_WAIT_REQUEUE_PI

On 2026-03-20 19:23:01 [+0000], Moritz KLAMMLER (FERCHAU) wrote:
> Hello,
Hi,

> we're running Linux 6.6 with PREEMPT_RT on a single-core armv7l machine
v6.6.109+?

> and observed our devices getting locked-up every few days.  We're using
> RT/PI condition variables from librtpi [1] and determined that the RT
> (SCHED_FIFO) thread making the FUTEX_CMP_REQUEUE_PI syscall from within
> pi_cond_broadcast seems to occasionally live-lock inside the kernel.
>
> Thanks to a possibly less than ideal design decision in our system, the
> "producer" thread calling pi_cond_broadcast (i.e. doing the
> FUTEX_CMP_REQUEUE_PI) has a higher priority than the "consumer" threads
> that are waiting on the condition variable (calling pi_cond_timedwait
> which eventually makes a FUTEX_WAIT_REQUEUE_PI call).  While this might
> not be ideal, I suppose that it still ought to be allowed; please
> correct me if I should be mistaken on that point.

Not sure why not. Worst case would be that the producer would snap all
locks and see no waiter because the consumer never managed to enqueue.

> What seems to happen next is that when the waiter exceeds its finite
> timeout [2] and half an eye-blink later, the producer thread decides to
The alternative to timeout is signal.

> call FUTEX_CMP_REQUEUE_PI after all, the lower-priority consumer might
> make it to the point where it sets the requeue state to
> Q_REQUEUE_PI_DONE in futex_requeue_pi_wakeup_sync but then gets
> preempted before it has a chance to remove itself from the waiters list.
> Now, the higher-priority producer thread calls futex_requeue_pi_prepare
> which will return false because it sees the Q_REQUEUE_PI_IGNORE.

> Subsequently, futex_proxy_trylock_atomic will fail with -EAGAIN and

So the syscall, that saw Q_REQUEUE_PI_IGNORE, returned and now a second
requeue-PI is attempted?

> futex_requeue "goto retry".  Which effectively results in the
> higher-priority RT thread busy-waiting on the lower-priority thread
> forever.  It will call cond_resched before the "goto retry" but since it
> is considered the most important task in the system, it doesn't seem to
> be scheduled away anymore.

Yup. Kind of obvious if you put it like this.
What about

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 7e43839ca7b05..ce02cc715c98d 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -307,8 +307,11 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct=
 futex_hash_bucket *hb1,
                return -EINVAL;

        /* Ensure that this does not race against an early wakeup */
-       if (!futex_requeue_pi_prepare(top_waiter, NULL))
+       if (!futex_requeue_pi_prepare(top_waiter, NULL)) {
+               plist_del(&top_waiter->list, &hb1->chain);
+               futex_hb_waiters_dec(hb1);
                return -EAGAIN;
+       }

        /*
         * Try to take the lock for top_waiter and set the FUTEX_WAITERS bi=
t
@@ -709,8 +712,10 @@ int handle_early_requeue_pi_wakeup(struct futex_hash_b=
ucket *hb,
         * We were woken prior to requeue by a timeout or a signal.
         * Unqueue the futex_q and determine which it was.
         */
-       plist_del(&q->list, &hb->chain);
-       futex_hb_waiters_dec(hb);
+       if (!plist_node_empty(&q->list)) {
+               plist_del(&q->list, &hb->chain);
+               futex_hb_waiters_dec(hb);
+       }

        /* Handle spurious wakeups gracefully */
        ret =3D -EWOULDBLOCK;


? It compiles and might work.

Sebastian
