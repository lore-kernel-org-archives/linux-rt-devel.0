Received: from mx2.ferchau.com (smtp.ablegroup.de [212.211.156.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF0540B6F5
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Mar 2026 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=212.211.156.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378230; cv=fail; b=jRpv+/53IznpdRTpdU+S/7+x6qvYnzbV87n/GKcPZMV41shMDUXFArmcYkEe80HbrcgnU4nPfLMuAvugPJusu1vFAJCzckkxV2kgOqEHOpSr0+0VpiafDfWK2M3UzB388fCey4cjDNyfQPywqTaWFuNJzNACGY6TQ/31NBIx/hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378230; c=relaxed/simple;
	bh=rBbISBaqTxG5sxEyBZhkbYBxZEB63ssgcpMC9CijWEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mXE8ETn0haW+xwj6rFOKvJA0fdD59BN5Lfc/idWpgowBDnyjoFqClk5XTO1aBloO4B0IOzUaCEazQfxRX8+wlMFqejcj5GmvV1Gz5iPBGWah+WiI3cFgSL8pft8cQYXrsdLd15wPVZGhuH04Yn+LRUM1r0hkRRPxfOitaiR6yZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ferchau.com; spf=pass smtp.mailfrom=ferchau.com; dkim=pass (2048-bit key) header.d=ferchau.com header.i=@ferchau.com header.b=krNjLjAI; dkim=pass (1024-bit key) header.d=ablegroupde.onmicrosoft.com header.i=@ablegroupde.onmicrosoft.com header.b=EtEoHphE; arc=fail smtp.client-ip=212.211.156.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ferchau.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferchau.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferchau.com header.i=@ferchau.com header.b="krNjLjAI";
	dkim=pass (1024-bit key) header.d=ablegroupde.onmicrosoft.com header.i=@ablegroupde.onmicrosoft.com header.b="EtEoHphE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ferchau.com; i=@ferchau.com; q=dns/txt; s=s2048;
  t=1774378225; x=1805914225;
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
  bh=KphGJ/vW0YWMZSdeJJacLgx5ppvttlzuG3tLhovmOIM=;
  b=krNjLjAI4un6AL5CIdPSjYodd3aSr/l03VzY0VbpLd0xc4XzzQc8zEVS
   YL8L92ia1GPBx4Nw/QpFbyiUDDqrIZCMJdBy3ShVTSj/3UdLmLmq1JcSv
   T4B0VWQDsMDKgOi+f9HEK5EB9ZKcZTiEJVQ2gIDaUfsvOLhE/nlMcIRqt
   H6DiRyTQ/Tt70IqEJUDqAAaLyJByrX8MgwmRgXJ7A9vs0q7WbT8DKT3XJ
   da/pS1w6QJhm+xltYNGP9J7odGVAOp3AxlvXdP5i3Q6C2MdDqcnOA1a+S
   4rzXef+h6OyJVqq+17BLZvdZWnArWgR0Bs4sLou3EFqcjcuqI/z40PopB
   w==;
X-CSE-ConnectionGUID: lon0XhSGTz6KeF97rDHnrw==
X-CSE-MsgGUID: 6rQSjwytQT2QeOUOOfDObg==
IronPort-Data: A9a23:VZZyiapkQcimVfRhPLCSINIjMcFeBmLMZBIvgKrLsJaIsI4StFCzt
 garIBmPP6zbazPyKtslPdm39BsB78KBzoBrGQQ5+CoyES0b8JacVYWSI3mrMnLJJKUvbq7HA
 +byyzXkBJppJpMJjk71atANlVEli+fQAOa6ULeaUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYqdDhPg06/gEk35qqq42lE5gBWic1j5zcyqVFEVPrzGonsdxMUcqEMdsamS
 uDKyq2O/2+x138FFtO/n7/nRVYBS7jUMBLmoiI+t3+K20UqSoQai87XBdJEAatlo2zhc+NZk
 b2hgaeNpTIBZcUgrgi9vy5wSEmSNYUekFPOzOPWXca7lyUqeFO0qxli4d1f0ST1NY+bDEkXn
 cH0JgzhYTiHgOTu8LKAZdV+2OcuApi0Jq8/vGt/mGSx4fYOGfgvQo3lwO1i7hoA3pgXW9jTf
 cEZYCcpaBPLahkn1lU/Ucp4xb/wwCSjNWQwRFG9/MLb50D2yxZwzKqrE97cf9mOSN99kEuCr
 WLP4iLyBRRy2Nm3kGXYqCr334cjmwulQrspFqKp6sdW2mSe4VE0LxM6clG09KzRZkmWHog3x
 1Yv0iEqpLIxslOqSt38VhijiHGBtx8YHdFXFoUS4gCCx6PP8i6dB24ZUiRGbt028sM7LRQ22
 VuZt9DkHzpitPuSU3313q+ZsT6oKwAUK2EYbCMJRAdD5MPsyKk3jxTSXpN5DOu5g8P4HRn0w
 iuWt246hrMOnYgH2rvT1VTGhS+845vEVAg44i3JUW+/qAB0foioY8qv81ez0BpbBImcXEOTs
 Whcw5HY4u0UBpGEiWqJR+4EGNlF+sq4DdEVunY3d7FJythn0yfLkVx4iN2mGHpUDw==
IronPort-HdrOrdr: A9a23:DcS/0aoPLizJf5+BSHQ7omIaV5t7LNV00zEX/kB9WHVpm5Oj+P
 xGzc526farslsssSkb6K290KnpewK4yXcH2/hsAV7EZnirhILIFvAu0WKG+VPd8kLFh5dgPM
 tbAstD4ZjLfCJHZKXBkUaF+rQbsaG6GcmT7I+0pRYMcegpUdAa0+4QMHfCLqQcfngjOXNNLu
 v72iMxnUvGRZ14VLXYOlA1G8TTrdzCk5zrJSUBGwMm7we2izap4q7REhST3BsSOgk/j4sKwC
 zgqUjU96+ju/a0xlv3zGnI9albn9Pn159qGNGMotJ9EESsti+YIKBaH5GStjE8p++irHwwls
 PXnhsmN8Nvr1vMY2COpwf30QWI6kdv15ai8y7avZLQm729eNsIMbsEuWufSGqf16MUhqA/7E
 uM5RPei3MYN2KYoM233am2a/gjrDvLnZNqq59is5RSPLFuGYN5vMgR+lhYH4wHGz+/4Ic7EP
 N2BMWZ//pOd0iGBkqp9lWH7ebcKEjbJC32C3Qqq4iQyXxbjXp5x0wXyIgWmWoB7os0T91B6/
 7fOqplmblSRotOBJgNTtspUI+yECjAUBjMOGWdLRDuE7wGIWvEr9ry7K8u7O+ndZQUxN85mY
 jHUllfqWkuEnieQvGmzdlO6FTAUW+9VTPixoVX4IV4oKT1QP7xPSiKWDkV4rydSjUkc7nmst
 qISedr6qXYXBjT8K5yrn/DZ6U=
X-Talos-CUID: 9a23:oebvMG5y3by7S7ZEFNss8EkSQvAlSVLh3inzLmHpVnxFaLuPVgrF
X-Talos-MUID: 9a23:pV1a7QVsGcY90Nbq/GH2vQpgK9Z02pj0MU0qrLIhteWjPyMlbg==
X-IronPort-AV: E=Sophos;i="6.23,138,1770591600"; 
   d="scan'208";a="1752031"
Received: from gmzrzex001.ferchau.local ([10.100.54.1])
  by mx2.ferchau.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 19:50:17 +0100
Received: from GMZRZEX002.Ferchau.local (10.100.54.2) by
 GMZRZEX001.Ferchau.local (10.100.54.1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Mar 2026 19:50:18 +0100
Received: from DB3PR08CU002.outbound.protection.outlook.com (40.93.64.83) by
 exchange.ferchau.com (172.16.19.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Mar 2026 19:50:18 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkN/Ms5PUR+TtiLnGlr4tOZvng34c+PdhV6fI6fPYYboDqL1BSAABIAkvBOx2dSxt+WJE+uIflCXp1uj7IJBa0WAjcfVen6Hzc8xdLGrFCMbyQW7FyOLkyo6BZxfKwr5cB0L4xq5sbMuNSlAlpbLDVQxG0PQ6AkjRlfsSMvtxoudwTFEhNmhSxyt3CXneH3yp+Kx4G2S4nkYaUGNuBHZpUT84KICft56jZNL1TLZlZ9BJQwDMv4z13A22hB8NnxnyoLwxmsGV4QZdDa1IbRIMJRJHxZhGPidjAS5P2giGhjCGdvlWrwJ0sXegu3dEPtA4TYlV6dWTqj7EPDXGz0CKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KphGJ/vW0YWMZSdeJJacLgx5ppvttlzuG3tLhovmOIM=;
 b=RJHMiFJsiaW+JpeCELPBT7E8c1RRCXhcfal5CVpqG/5pAb/cOUjvi6vkCoqPGxr6+H55zIRMW/JiCqMhMi5O7my5E+OprCQVuGW7PY8WTauKJ1qzUOhFJGqZg6I4eD4RQ37L/MqxtdSf37Pbe+CPX2YL7sJS4dGxsa4j7vTa8RNFesCaDWRfYonlxgKvdxbQEYLga0vkEeFrMkqOrFLX+X25ZvnWu1W1KBBaJg3120YRdxpVxHqMZRDDBG+3sKUUJyYIq7W3ONrkht7JOyLfYQ5XgzBWUflFvd03aaBdImW08L14rY5rIk2/Pu7VXQSMrNrLRTA+zbWFpEIt6vAaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ferchau.com; dmarc=pass action=none header.from=ferchau.com;
 dkim=pass header.d=ferchau.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ablegroupde.onmicrosoft.com; s=selector1-ablegroupde-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KphGJ/vW0YWMZSdeJJacLgx5ppvttlzuG3tLhovmOIM=;
 b=EtEoHphEZlLGa0QiErewLvdaTTzkD6wpYBA0rfF+h31SzgfMUljITNo57tvCx41jo+TPQgDQ1WrXhItJG7EIho6DS0CghljbSrwbdJ3+uuw45DQ2XK1HOiyqDZpjsLaobHv1LQ+DrmiStzrRN7PvHvb+/T5x4LHgL37OnbbKAMY=
Received: from PR3PR06MB6889.eurprd06.prod.outlook.com (2603:10a6:102:87::9)
 by PR3PR06MB6986.eurprd06.prod.outlook.com (2603:10a6:102:83::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 18:50:11 +0000
Received: from PR3PR06MB6889.eurprd06.prod.outlook.com
 ([fe80::7396:2256:3ddb:4637]) by PR3PR06MB6889.eurprd06.prod.outlook.com
 ([fe80::7396:2256:3ddb:4637%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 18:50:11 +0000
From: "Moritz KLAMMLER (FERCHAU)" <Moritz.Klammler@ferchau.com>
To: Clark Williams <clark.williams@gmail.com>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
	<tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: AW: Possible PREEMPT_RT live-lock / priority-inversion between
 FUTEX_CMP_REQUEUE_PI and FUTEX_WAIT_REQUEUE_PI
Thread-Topic: AW: Possible PREEMPT_RT live-lock / priority-inversion between
 FUTEX_CMP_REQUEUE_PI and FUTEX_WAIT_REQUEUE_PI
Thread-Index: AQHcuJ4tKJIXTbtBj06xHcNQzZlKbLW8ITcAgAAnI8GAAEz3AIABbWoS
Date: Tue, 24 Mar 2026 18:50:11 +0000
Message-ID: <PR3PR06MB6889277011F601ADC5CDF56EFF48A@PR3PR06MB6889.eurprd06.prod.outlook.com>
References: <VE1PR06MB6894BE61C173D802365BE19DFF4CA@VE1PR06MB6894.eurprd06.prod.outlook.com>
 <20260323133034.vk87xPj9@linutronix.de>
 <PR3PR06MB68891F0E8CF17A4260D46EE8FF4BA@PR3PR06MB6889.eurprd06.prod.outlook.com>
 <acGh3pAAS5Ju6l0Y@demetrius>
In-Reply-To: <acGh3pAAS5Ju6l0Y@demetrius>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ferchau.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR06MB6889:EE_|PR3PR06MB6986:EE_
x-ms-office365-filtering-correlation-id: 9774343d-522c-42b0-6207-08de89d62dcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: jmUedIBo9dC265iBW6cnVBHSsG+QYfvGOkVn2Tof2ZYcyvekd4sHW8nbBElGndRMVYdo2JVuP27H2XQH/GmaRHx+0vbd4v2AhBcmrypG6bgoG2yy6ZY8XIghSaOiRyqr22wLDIyKJM0CrhfplkVjmrecQo1GHsRN+UckeYhWaqhFAzPpX/XBiVVgrQOPEPsIaO/QP0IH0za33M44XLVM90AExPN/UuXx8pc5mpDu1OIOHNpurJgko0VaWwTTdn2f0sylTTm240zgucYVGMz2uL9nI6sAaIthViYN7bX/6dFCztw/H7f/W/pYqk94O2B2hXwLVhsT7o/7kNuLoGmHygYvg5TMPGwNUXhHEmZk74+HaVv6/ML7l+w8ChrCn2m/gp8kzbZP26CBW0tL5FBTkq/w2LEoMLAOzZ8geOjXP6Q5QJXiJjjXeJrqcfH8SsFU74xF3GfTwuPJwdPXIfsKp6rfTZSp6A603v+ZmPZPLhnffphQRn6ffKE67n3Jr7QQJhvNSbNj8iAVEnrIccGMmDCwnqllnrZGaMG1lrDiHZtKe5XR71pXM6VxfmEsdm7Lh3yBBBqj72AYPns2MH1zfBx2kLe5yNAZxY3i785vHWCGGmyLW/+apZWSiK36yNfm11sMi83wp+xRUF72b9txz8ItI0yMrJSOXYCfhHnxVRfeS1J8B+YQsCpippQZ/tewmINlTETFRvHtqExKS4tTGAGvjWIZ51NMZvoleGMn/uMOlUnJoyrK4yFF9dPm0F2dS5y9W3Ri9UoNsYtHNnrJJ606iUgh5Y3L3buBQ9PRQ3s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR06MB6889.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Uav4mincIyI1z5v3R6f8b0z0FGuoAc5NZX7uIupygsiWzrEUtvDP/rRiXz?=
 =?iso-8859-1?Q?J7nsJ1aYP1XaJFYgzoL0NQt85aLTbx3ovVPrWJS8mnvejYQYaXDjLihwlC?=
 =?iso-8859-1?Q?k9v6vM+j8bmmL6vtEwSInaGzlSNpz6XatsUcvX74ScqoYD5n+yIjSI4YGg?=
 =?iso-8859-1?Q?U0nV4t3d25z0Tx8pPOu4jv93eWmGohF8gCsha2qOtdU2QB9RQhDJ6NSaI3?=
 =?iso-8859-1?Q?FPkno2IKuXfATj7uEW6yNGZfV/aAl5meopwj6cWN4/t7TVv+8zMP4awlB3?=
 =?iso-8859-1?Q?bO6duEaIR1Mvq0mx76gYxxcoCp/7c4J4yK4vsAkE5Fhp3z6pFBl0z6QO/G?=
 =?iso-8859-1?Q?4B1HbLxPheKNkgT79TDfN9+Re5IiqYWZc3yAYh2VHVN5rrgeB8rdW/d7Ao?=
 =?iso-8859-1?Q?jiUIS1GG4ZO9/LwSt111asIUEypwm7+xYiReA+fcPZS/q2nZXH3/1MEcik?=
 =?iso-8859-1?Q?8gOJhBM0I8Uz4Cg/vQzUx3MeCVteXxVZfN5MlvZUthlXmouZhySarQ8erA?=
 =?iso-8859-1?Q?6ZPrjaHF6Br7cj4X80tQM7c/CFIFuLxYShEF2LaHkh533/+z+V+uf5v1EV?=
 =?iso-8859-1?Q?AqzOVVAsT14KYluU9f/EIPG+IqOn5uolhMGgHNeDrPW3pACHXzDCdbZav9?=
 =?iso-8859-1?Q?oY+oHyRidt1dPMQfijlWePKm1R+P9ezpk0PT2qLI0MQRCGFS8J8b+oG0a6?=
 =?iso-8859-1?Q?BK6PNtmFaCj18j0U3H1MqDuXytDIr6o2WN1wWQ4CInUVJt4G1qbf2svYYL?=
 =?iso-8859-1?Q?lrCm5GYrm69J06hoMphuk0XkKuP32S6AsF4cFITbV/hZSqUKTZ7ctE4RQF?=
 =?iso-8859-1?Q?Z1LVoxDjWh1JuRhdpHBK1tv1K10re0LKd9ljZDj2kw8LkVDtVkbt/trizq?=
 =?iso-8859-1?Q?1Y8tdZ0kvocAtCgox681C/NuPrVsEfoBNWvL2JCCfq7Ro8JTqatJ2aFUfm?=
 =?iso-8859-1?Q?F1ZAhdaQ+ny96SnKX+RQdCYAaJVDuU0E758un97TjqzxF0XfUVy59OFTAB?=
 =?iso-8859-1?Q?KdPtdzUsYmz4+tGdo5Z0OoGtle816boKlflkQe+WjVvnWsnHwrsa1vFOOh?=
 =?iso-8859-1?Q?Pz6G2zAeaW0iR83Q5D0oG0wiDW3q2RqqIPyTjYayzAIIsKBacOhyF5JMr7?=
 =?iso-8859-1?Q?S7rzzJY2rtri+AmC8Pw7aquFcYkDHIbQ9iREvWCOA1sxVaKXdycmN0fu2f?=
 =?iso-8859-1?Q?WyK3/kA0XdP2Cj1lzbiScDi7Nd4uwC9XgLVsQUSG0fAE8431UQUwYmy/Qk?=
 =?iso-8859-1?Q?LJ4NfvXMmAycPFyiCkymM7R3UaRp155Of5rftdJJRxjAcKjeDXxaDp26Ct?=
 =?iso-8859-1?Q?QIlowhR+AggdSA3nFaKiM/MFhqT36E3cV4NW9mqXEzaMlJWWQX/ZhjxaSp?=
 =?iso-8859-1?Q?A4wghKArd9+CWS9++icruBon9bHcnDGimjeBZqbXo3ugnQtEkwh5zwvxx4?=
 =?iso-8859-1?Q?BDJulDWaDCutr3rB+tjEC7da4JpLKTEAzIiszoRONtSy6vtiHJWhp/Mkuh?=
 =?iso-8859-1?Q?erotaDuwiLu4f4kgtRjXrVmbfLRlRxgjbQGGvBWHiPB9gZFCDSuRJwstki?=
 =?iso-8859-1?Q?Pj21h646hBGuxaPrLPfK9DkXo9KOKGRittc0UKU7THFylevGhkSgITSkSm?=
 =?iso-8859-1?Q?MY4OfBBQPGilzqmr+cIVYxNJdL/FLLvDFD9cMkWvML/ScGZiBy2XOtd+EK?=
 =?iso-8859-1?Q?yo6f1xxolL5Qyd/ElKS8bFqlSSBD3RRnYlarb/c59CeaBO7rtFWVkk/r7t?=
 =?iso-8859-1?Q?is6yr2N1p4x9CVvu31n3zp7aZlWXzmXAnuw2eL8kd8zRh57ECISufu7SoO?=
 =?iso-8859-1?Q?qq1jJqJaUg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WOHaBb9itk9PtdNivTDXHXdVhHQQkx45HV6JkchV7qcmjfvWqJtLYIXEsN0tA1lobHgI9aCG0O7Wc/T//MmVI/LJ7R2Yx80drIIJo/1J8MmND09qujKBavw65vwkXsPufXh7FwOOLrzfVlh7pDP8KxMTY3EN0GGgYh6mZxkjMwP5AVFYJ0/nT3tOe2dj00DEe6gaW4FwJMTJqJsGRDpSM//9U6KMCiutEvqs81N1yHqWWu324+uIumpjQTM9QRLit+OrZUHXQ+Oilbx6HCzmpTaRmUnKnCj/XqnNvn+3UgVX62rI0AD/GgJeIzisH15APConhWgH5PFaUis3FtwfuA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR06MB6889.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9774343d-522c-42b0-6207-08de89d62dcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 18:50:11.7036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9a3c2f68-d5b5-4769-b2f8-8d6fe142b164
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vS4DqEmh9723f2MX2wpwbCk1gfHtO7TQNK/b89NpXBnKY9x7TkMzRE57VFNl3xkjbzwG+8U6cNddKu49UxxgFOgPq7CN12RSqMYfhtTBpQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6986

>>>> we're running Linux 6.6 with PREEMPT_RT on a single-core armv7l machin=
e=0A=
>>>=0A=
>>> v6.6.109+?=0A=
>>=0A=
>> Yes, 6.6.122 to be precise.=0A=
>=0A=
> Just to satisfy my curiosity, are you running my stable v6.6-rt kernels=
=0A=
> or rolling your own? (Not that it would affect this bug at all, since my=
=0A=
> tree has the same issue).=0A=
=0A=
Hi Clark,=0A=
=0A=
it's a BitBake build.  At the time when I started this investigation, it=0A=
took 6.6.122 from linux-stable plus rt67 and then some other patches as=0A=
well, none of which should affect the RT part, though (hopefully).=0A=
Meanwhile, we've moved on to linux-stable 6.6.129 + rt70 patch.  I can't=0A=
find a tag for 6.6.112 in linux-stable-rt (maybe for good reasons?) but=0A=
v6.6.129-rt70 does exist.  I don't know why the project has been set up=0A=
to patch linux-stable instead of using linux-stable-rt in the first=0A=
place, to be honest.  But I'll take this as an opportunity to suggest to=0A=
the team switching to linux-stable-rt as upstream.  Thanks for your=0A=
efforts maintaining it.=0A=
=0A=
KR Moritz=0A=
