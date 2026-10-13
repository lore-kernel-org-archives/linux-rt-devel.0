Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F0A5111B2
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Oct 2026 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906966; cv=fail; b=L3/07B7CsoOUS/r8SE3LxE3A3qKIj/E8+FApghyCgPkbfM4V650e2jghyo3+5psitU5KdtRNlfUCradChkpMEodYMI1qDZ/v72YQfYV1Zps4hWA3i32jUBL10bkXJ6hacYGJKWj6K0MuPIGUIw80NoIgBMgh26Pgq578lk1yAFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906966; c=relaxed/simple;
	bh=tUdhhqazPGqwL4bHSyO91jrWfN/geAnXT3eXbZJmU1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uX11l1b0vLmTKwNVHvdzlVrrfkKVLfd4GQ83GEfFBboG7zYOW55+dMvitxrZ0Ozo86mjJNy4yJd6+py/D+gj8yzQWigK58GKbZDxQ33yQvthc13j1iVRNOX5S0pggwIdASeJMaeNCfTl/Jyzz+JUbiU5trRHQOEhwkvADpeB7oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3Macydx; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3Macydx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791906965; x=1823442965;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tUdhhqazPGqwL4bHSyO91jrWfN/geAnXT3eXbZJmU1k=;
  b=H3MacydxOLhHqIOIMR1OZqjjJdBmzcVn/rkRrvtvicp4pfxaqH2gGdJT
   Q0SShsxhJz9dUTigfpEX7noHVtJdFeX4wvtIfzN0WVgo+J3CtOb+qHM4h
   9Bfddm8ujHpKv09iWtmDrPxCgJZZ619tYuA95ecAnbB9ewFy7FHCbbOmL
   e6YCD0JbADUnvQ1qk4DeykVUQBxiOhqw2lA6Wu72ETWMYv8s3rom4UBrP
   LyawMbpiZfeFp9f/Od/h5rI4Xdzn/o8vMWXq/WsikJuWsPi9RhlGz5y3h
   0XgC9QkKFrS+ac3WQUKw1R5nAGhzlpqM76YWjI97AIRGGHRpxAAOyTO9N
   A==;
X-CSE-ConnectionGUID: DWr+EnXMQEmwOtONG6lyqw==
X-CSE-MsgGUID: ADbDbo0GRPu3HkR3eJ0oMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="641055"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="641055"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:56:04 -0700
X-CSE-ConnectionGUID: /XFTOCLZSyi9ZgO9/WLl0Q==
X-CSE-MsgGUID: MOMUAispRsm33n7ogyUlAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1267123"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:56:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 08:56:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 08:56:04 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 08:56:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQTk+KH9CSondGO1bHRQl84rB8/23xYSrq+cjTFn82XYI94EoRzYmw1XXxcidgX0jQxB43hgA0GxuXIFMrpt4PoTdQEYthUHRkXr09iG78CStxMbi4O8fMCuV1hKb9U8qIAA0d1CHIhoY2cclg+1TU4G7uRuxw5VoEvobh22CHlY0QJ9wB1eEp9JzZ94P6X4TP4dzOeMIAzwInUzocr++BotgLSFeMTiW1vhe26BJgQCdV3kIt2yA6VgkkJ2AewaZpDSaSaX4CsLac0tFkVmn2iPzC8uuJQHJUIp0Dko4f6Bwd0tD8Ad+KCbEGi9QW2mxThwPXGS8QtvjMbqIW0naQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUdhhqazPGqwL4bHSyO91jrWfN/geAnXT3eXbZJmU1k=;
 b=KJuEo/vbw2jGJ+3/co4xCutCRyn5eDpsif6+aH0Pyi3I+G5yFlVsFfTkUMKjPiHcntiSWV9l/qWgeEBCXVwT7CJouRhcu9xvSzdOoqHUSU/wMFDKDtuCiKLjh2A8a5I4jxpWZ6CRGoRuhL2pSsmEBmgiZjJT5Wu0qtGd4Jo72d8bGWCD2ZrqUOGeSPu0mEdf7T1H0e82wLFHZ+DEGtMxvCtY8tDT49+chE0fR8YiIxFDnCBOWkHRrNKxzuDS4BFZ4cG7+ryTjRjU5otUzG/evUtT8q6XA4JfuO+sWoSiqcfsj2LJLpM2sjhcwDmL0JwrRwEcTB8pdtojS6jk8m4Mog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS4PPF30373102B.namprd11.prod.outlook.com (2603:10b6:f:fc02::1b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 13 Oct
 2026 15:55:57 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 15:55:57 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>
CC: Drew Fustini <fustini@kernel.org>, Adrien Ricciardi
	<aricciardi@baylibre.com>, Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra
	<atishp@rivosinc.com>, Atish Patra <atish.patra@linux.dev>, Babu Moger
	<babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>, Borislav Petkov
	<bp@alien8.de>, Chen Pei <cp0613@linux.alibaba.com>, Conor Dooley
	<conor.dooley@microchip.com>, Conor Dooley <conor+dt@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dave Martin <Dave.Martin@arm.com>, Fenghua Yu
	<fenghuay@nvidia.com>, Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai
	<gsh517@gmail.com>, "guo.wenjia23@zte.com.cn" <guo.wenjia23@zte.com.cn>,
	James Morse <james.morse@arm.com>, =?utf-8?B?S29ybmVsIER1bMSZYmE=?=
	<mindal@semihalf.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"liu.qingtao2@zte.com.cn" <liu.qingtao2@zte.com.cn>, Liu Zhiwei
	<zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>, "Paul
 Walmsley" <pjw@kernel.org>, Peter Newman <peternewman@google.com>,
	=?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, Rob Herring
	<robh@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Vasudevan Srinivasan
	<vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li
	<liwei1518@gmail.com>, yunhui cui <cuiyunhui@bytedance.com>, Zhanpeng Zhang
	<zhangzhanpeng.jasper@bytedance.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v7 2/5] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
Thread-Topic: [PATCH v7 2/5] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
Thread-Index: AQHdOmHiBkXZvA3/GkWkPGt41t79rbbTADGAgAAFcACAJ2StAIAAbqQAgAEGiZA=
Date: Tue, 13 Oct 2026 15:55:57 +0000
Message-ID: <SJ1PR11MB6083F4281EDD036A4E73A532FC9E2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20260901-dfustini-atl-sc-cbqri-dt-v7-0-ca2935d85622@kernel.org>
 <20260901-dfustini-atl-sc-cbqri-dt-v7-2-ca2935d85622@kernel.org>
 <8230dae2-2cb0-4b46-8cec-dc4e281d4e4a@intel.com>
 <aqwN1szItGPg4Qjh@agluck-desk3> <as0Zeoyjiy5CW1DT@agluck-desk3>
 <eaeb4259-46d6-4656-8354-669ad32654b5@intel.com>
In-Reply-To: <eaeb4259-46d6-4656-8354-669ad32654b5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS4PPF30373102B:EE_
x-ms-office365-filtering-correlation-id: 7cc8afbb-91e2-49d1-3384-08df29427836
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|22082099003|18002099003|261009223027099003|38070700021|56012099006|10067099003|4143699003|11063799006;
x-microsoft-antispam-message-info: t6Ej5OlqGHdrVnXn9Pq9E02QcBGlCXqstcS9Ar57/Gzgd6kbz7Tev5Man/YMTDoYIUE5P7RgzTOD/Yo2BJFjaopAZmQ4fWSIntp0BBrv5OeR+BoJnyLL6dbhifQsF7jrLFcGtJ/ELuofWAV+uknz04zh+R2iZm7w/eYV6EiVTO8DXC2NjSOf/92qgvO8kShBsy3DlrFwRSNkbGva0p5bduQqaQyLwBQQGpIhd4vaz/8eDGB6fINd3UM5vUjqChVXdlO9MEsBmm5u/oCx8nEbs9WXEcOanJ99XMRuV0So6sWf82RWz3trvAFRgr3mRTKEHsI/I0sIeEMAajKV8+VKBXvY3+Y5VKYiKmBjFe71hVdISDS3mjon2Hkgte8Uyjvk4MzTh2tqatk5cPaiynFNpdutKWw9azDNHUk8cH2foAZgMw0hbIeQDdWbHyoEX69Oq7bHio48SjwslUhewx0disESVL3otjUvB6Mqx8ZYjApx5gYfwemVcnF+oRTSU0IEoyXr5UeXNpn1k3rzCOgQPB01wjZ9Qa95860KmOaK61XNTuAWv1+3GqmmfthrbhQXCLpB8W0vQPr6tUIFLCCQWcrk/u7l4YudfVLYw5J+UfN+MeT5F+HaVsi342Keo/WulukzfNImlZqua2RBBeYElsW5XsiW7+Te4167fhNAX74=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(38070700021)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGJSYkNuaUdEMDJoM0FiU0VnVTk1VVZBWlVRK01mN0VrUXVhQ0FDakxrQ09i?=
 =?utf-8?B?SjJldkFIbFdKVEhsazdpbXJFZkhsaXJwRnY0blV6bzFMTlBBRGt3OFVtMkpF?=
 =?utf-8?B?WHg0UHdxeXdrVER0Z3J6YnlnNjZoVjJVdnNkeHMxUmxZaTg3UVdwMVZsWWN3?=
 =?utf-8?B?N2tILzc4aWtPYnZSdGlzY3pxSnVUYlJIUzNjYWlBZTVRUGdHUy96RTY3N1Fl?=
 =?utf-8?B?Q1lQanM1dTJsdkdpdC8rVzlPNmJLTU5NZDcycXhtcklUNW51ZFg5NHhPWHJL?=
 =?utf-8?B?RFR5K1NWWFc2SGtaUTdXZEFLc2Q0cDVJWGtpNVc1dVIyTy9KYTZRZERIL2xY?=
 =?utf-8?B?WDY3SlhNMlg2YVg1bGVqR1VMZWo2R041bDJCRHZIeXhKLzNQRDQ2OFBZazBw?=
 =?utf-8?B?ZUc0OGJ4TlhHYmx3cnFadm42bnNZWDd5SUEwT3dnMnlGZ0c5T2tkZ0V0Smdo?=
 =?utf-8?B?eEFnVW54eXlyMFNWS0VPNitGYnJaOHoxVDJ1cDBwVEZsOGdJZFNqZDNvL21m?=
 =?utf-8?B?U1VWNmRGbkt4OWp6bFZjZ1lEWWhyVXZnNGp3cS9ES1hyT2hJelJMM3RYZTZV?=
 =?utf-8?B?VDZsNFpHZTVxQzQ1QTNZVkZPY1pIYW5jUStUaDVveTd6dXlpWmZxOTZHTU1V?=
 =?utf-8?B?TVRWRE5tSDVyZkNXWUtHTzRlaDN4elV6ektOSzFORUFndjlTUk0zem5CNm1N?=
 =?utf-8?B?RXkvT0xkWUxPd1VQdCtJUGRXQXJJcG5PMXY2SkVLdzcvQ3pWL1M2RmFkTkhJ?=
 =?utf-8?B?L284TklhMEJFVDhrditHYk8wTHFXOFpVMDlMdFFnYXl3MzNaVEw3STFaSE5n?=
 =?utf-8?B?cDFMZ2JKdWJ0UjRheEc2VzlMblF3NjJrZlJncVRRZWVPc1NUMnJLclgxVTNk?=
 =?utf-8?B?WGRtbzBsa1Z3ckkrWm50QUFZeUFzczh0T3FoRE1BRGpacThKNTBZVHREYmwx?=
 =?utf-8?B?R3dHamtQM1J2WWtOZkdIcVZidUVOU0ZpVlhCNm9GZFdtRDIyUGFOdGVuVG56?=
 =?utf-8?B?TkQ2YmZDT2xOWG9iQ01pREI0SWRqVFpsbFRJTXg2eWtmWFdYR0pWUUFDcEZn?=
 =?utf-8?B?bGVZZG50RXhzSWFObXBPcG16eUFFVUtpK2QyeDZnUWpneVh5SndtbTRqdEFa?=
 =?utf-8?B?K1JZYitYRXI1OG8xZkMxNU0wNDMvYVRKamhWblZIV1JGeVc5Q0ljT2U0am43?=
 =?utf-8?B?b0IxR2JicWFiL2l0SWFWVEJLTlFPSkoxQnNQRm9WamZ2ZWUwS3Zmb3FyY3Vt?=
 =?utf-8?B?Wk5FTE9ER0c5MHplYk8ybWdLTUZSMzFXbDg5S2EvRkNnUlRhenZqKzcwZ21B?=
 =?utf-8?B?ZTdKOUR3S0M0dDg5dlh3R0MxWk4vMHhOZFJCZXZmR3VPSHlXcWlHYVIwU20z?=
 =?utf-8?B?NEh6cDQ4NEdDZlJVUFFPUVBiZ3JrYUtXQlFFeVMyckdsUk4zZ29mNm10Z3NF?=
 =?utf-8?B?RXFVb2FpNlpGejlQb3hJVWxiSWQyVEM2NE9DV0pjQVRva0ZvblA5YlJxU0Ur?=
 =?utf-8?B?VWJvR0dlU3dhdEsyV2lnRlJDVXJmYXRVdnFLTEtqWkhwM3YyR2p3empNbEZC?=
 =?utf-8?B?Uk5UMExaSFg5UU5BUXIyS0lPM3J4K0NIbEt1dHFxMW1CeWVqSmhXcE80ZVo0?=
 =?utf-8?B?aFRSQ0FqU2RjMklJTzcxTUljbGRXT21NZ2dnTi94NlZic2pnbzRqUlVKekEy?=
 =?utf-8?B?MVNOYXpVTG9aWFVsWXZYYjJtVVU4aGZteGlPSVVybVNGaDd1MEhBcnRwbGVN?=
 =?utf-8?B?UHNMZVc0L3hPcHBvcXhTT1ozem1pMkNJYjU5aHErZ3hzYWhmRUZSeEQveGhB?=
 =?utf-8?B?bi9FSGp1THhIMkw4LzFyWWozL204N1E5WGZwSlh0b1lmWnJYL3lmS040Tzk4?=
 =?utf-8?B?MktiUUJvTnN5Z3RvUTJTWTZXdVdxcHJ4eDVzM0VucmdqbTRmRlJUdnlWQUJn?=
 =?utf-8?B?MUM1ZGNaWExIVTRnQVdjTUg4WXNXaEN2RVU4Z2pLQWdRUWhJRXZ0QmR5UGxI?=
 =?utf-8?B?YW1KTk9abmFBUzNLRThTT01qcCtKR1JKbCt4MnNVaTVQZnMrOXRQRzRhdHhE?=
 =?utf-8?B?bzBMOTQrOGdNcjNoZ2dIYjJMVmIzR3pxUlF5QjVlT2pzOEdpd0NMUzZITFI2?=
 =?utf-8?B?WmlGV1ZjcUdOaDhEQUs2Z3BBdHQ3QmNzZjg4aThraW10TlVrV0NHeXRTdGJh?=
 =?utf-8?B?dUdqa3J5dUZWZWtuWitsMElEUkR4dnhQUjkzcWt3b1pVclVzNDdhcVkxT09B?=
 =?utf-8?B?WHBvd2hiMmtGTGVBL056UkZMMkVTRDVyUkM0eCs2Q3NPbERKbTNpeWJjNWNh?=
 =?utf-8?Q?oZGiYL/3KhnZu1QXo9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aRiLQJbMrX/tx04/qaM0xho4V4YSn+oS66rOplaNKFGbYKNDuh2uYp8H2wRh7VIoN7iiJuJuysm7/cHerKarU+aMxwQP+Xd0RxX9pzeBQvrvxbRtrL/WbmSYMakJ8GJDme6PzFzw1H5MkHiClDV2xOfvVBCRcAM2gU3xfRQHqpG5FgUBCaVNAwNR8hnsEQB0rVakxmEBGPZVEfeH1g95B4KT4i9D+xLfI+fTRjfEKCzPiJlmu+WNzI4okTEXOblD8UC2ho2C1XcXx92QwtAl9fj934w007UF4/xXN6BjOrQ6SvNT9QtscimHvNOK6vjrcFGscF1atteuIaKtqS2SfA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc8afbb-91e2-49d1-3384-08df29427836
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 15:55:57.0726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FB/BXvcYvWkeV9XgBHpT9dZHsUZHpLxvC0M0ucbNU85Wlej8RvQAB7kC1njfc5S0sWGhd8hJuKmTCEPiZDnVSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF30373102B
X-OriginatorOrg: intel.com

PiA+IDMpIFdoYXQgc2hvdWxkIGhhcHBlbiB0byB0aGUgbGVnYWN5IC9zeXMvZnMvcmVzY3RybC9p
bmZvL0wyL2NibV9tYXNrPw0KPiA+IEp1c3QgaGlkZSBpdD8gSSBhbHNvIGNvbnNpZGVyZWQgcmVu
YW1pbmcgdGhlIHJlc291cmNlIHRvICJMMkEiIHRvDQo+ID4gYXZvaWQgc3VycHJpc2luZyBsZWdh
Y3kgY29kZS4NCj4gVGhlIGN1cnJlbnQgZGlyZWN0aW9uIGlzIHRvIGhhdmUgdGhlc2UgdG9wIGxl
dmVsIGZpbGVzIGNvbnRpbnVlIHRvIHJldHVybg0KPiB0aGUgcHJvcGVydGllcyBvZiB0aGUgZGVm
YXVsdC9sZWdhY3kgY29udHJvbCB3aGlsZSBpbiAibGVnYWN5IiBjb250cm9sIG1vZGUuDQo+IFdo
ZW4gdXNlciBzcGFjZSBzd2l0Y2hlcyB0aGUgY29udHJvbCBtb2RlIHRoZW4gdGhlc2UgZmlsZXMg
cmV0dXJuIGVtcHR5Lg0KPg0KPiBUaGlzIGlzIHdoYXQgaXMgaW1wbGVtZW50ZWQgaW4gUkZDIHYy
IHNvIHlvdSBzaG91bGQgYmUgYWJsZSB0byBzZWUgaXQgaW4gYWN0aW9uLg0KPg0KPiBJdCB3YXMg
bm90ZWQgYXMgb25lIG9mIFJGQyB2MidzIG9wZW5zOg0KPiAgICAgICAtIFdoZW4gc3dpdGNoaW5n
IGNvbnRyb2wgbW9kZSB0byBuYXRpdmUgdGhlIHRvcCBsZXZlbCBjb250cm9sIGluZm8gZmlsZXMN
Cj4gICAgICAgICBzdG9wIHJldHVybmluZyBpbmZvcm1hdGlvbi4gVGhpcyBjb3VsZCBiZSBjb25z
aWRlcmVkICJ3b3JrIGFzIGludGVuZGVkIj8NCj4NCj4gQW4gZXhhbXBsZSBvZiB0aGlzIGJlaGF2
aW9yIGluIGFjdGlvbiBhcyBhcHBsaWVkIHRvICJtaW5fYmFuZHdpZHRoIiBjYW4gYmUgc2Vlbg0K
PiBvbiBzbGlkZSA0IG9mDQo+IGh0dHBzOi8vbHBjLmV2ZW50cy9ldmVudC8yMC9jb250cmlidXRp
b25zLzIzNjgvYXR0YWNobWVudHMvMjA2Ni80NjI1L3Jlc2N0cmxfMjAyNl9jb21iaW5lZC5wZGYN
Cj4NCj4gSGlkaW5nIHRoZSBmaWxlcyBjb3VsZCBhbHNvIGJlIGFuIG9wdGlvbi4gSSBoYXZlIG5v
dCBoZWFyZCBzdHJvbmcgb3BpbmlvbnMgb24gaG93IHRoaXMNCj4gc2hvdWxkIGJlIGhhbmRsZWQg
YWZ0ZXIgdGhlIGFib3ZlIG1lbnRpb25zIG9mIGN1cnJlbnQgZGlyZWN0aW9uLg0KDQpNeSBQb0Mg
aGFzbid0IGltcGxlbWVudGVkIGFueXRoaW5nIGZvciB0aGUgY29udHJvbF9tb2RlIGZpbGUgc28g
SSBnZXQgdGhpczoNCg0KJCBjYXQgTDIvY29udHJvbF9tb2RlDQpbbGVnYWN5XSBuYXRpdmUNCiQg
c3VkbyBzaCAtYyAiZWNobyBuYXRpdmUgPiBMMi9jb250cm9sX21vZGUiDQpzaDogMTogZWNobzog
ZWNobzogSS9PIGVycm9yDQokIGNhdCBsYXN0X2NtZF9zdGF0dXMNCkNoYW5naW5nIGNvbnRyb2wg
bW9kZSBub3Qgc3VwcG9ydGVkIGZvciB0aGlzIHJlc291cmNlLg0KDQpCdXQgaXQgaXNuJ3QgY2xl
YXIgdG8gbWUgd2hhdCBsZWdhY3kgdnMuIG5hdGl2ZSBzaG91bGQgbWVhbiBmb3IgYXN5bW1ldHJp
YyBMMi4NCg0KUG90ZW50aWFsbHk6IExlZ2FjeSBtb2RlOiBMMiBpcyBkaXNhYmxlZCB0byBhdm9p
ZCBjb25mdXNpb24gd2l0aCBkaWZmZXJlbnQgYml0bWFza3MgcGVyIGRvbWFpbj8NCg0KLVRvbnkN
Cg==
